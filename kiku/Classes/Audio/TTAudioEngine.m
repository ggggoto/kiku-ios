//
//  TTAudioEngine.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTAudioEngine.h"
#import "Macro.h"

#define kThresholdTimeToPlayPreviousSong 2

@implementation TTAudioEngine

@synthesize delegate = _delegate;
@synthesize audioPlayer = _audioPlayer;
@synthesize mediaPlayer = _mediaPlayer;
@synthesize mode = _mode;
@synthesize currentPlayingUrl = _currentPlayingUrl;
@synthesize queue = _queue;
@synthesize fifo = _fifo;

- (id)init {
    self = [super init];
    _mode = kAudioDoNotRepeat;
    _currentPlayingUrl = NULL;
    _queue = [[TTQueue alloc]init];
    _fifo = [[TTFifo alloc]init];
    return self;
}

- (MPMoviePlaybackState)getPlaybackState {
    return  _mediaPlayer.playbackState;
}

- (void)resumePlay {
    [_mediaPlayer play];
}

- (void)pausePlay {
    [_mediaPlayer pause];
}

- (void)playNextSong {
    if (![_queue hasNext]) {
        return;
    }
    [_fifo put:[_queue deque]];
    [self playPeek];
}

- (void)pressedBackButton {
    if (_mediaPlayer.currentPlaybackTime > kThresholdTimeToPlayPreviousSong) {
        [self playPeek];
        return;
    }
    [self playPreviousSong];
}

- (void)playPreviousSong {
    if ([_fifo isEmpty]) {
        return;
    }
    [_queue putToFront:[_fifo pick]];
    [self playPeek];
}

- (void)enque:(TTSongData *)songData {
    [_queue enque:songData];
}

- (void)flush {
    [_queue flush];
    [_fifo flush];
}

- (void)playPeek {
    TTSongData *data = [_queue peek];
    [_delegate onChangedCurrentPlayingSong:data];
    [self play:data.location];
    [self setLockScreenInfo:data.image audioTitle:data.name albumTitle:data.albumName artist:data.artistName];
#ifdef DEBUG_OUT
    NSLog(@"Start playing %@", data.toString);
    NSLog(@"song duration %d", [self getCurrentPlaybackDuration]);
#endif
}

- (void)playAtIndex:(int)index {
    [self getToIndex:index];
    [self playPeek];
}

- (void)getToIndex:(int)index {
    while (![_fifo isEmpty]) {
        [_queue putToFront:[_fifo pick]];
    }
    for (int i = 0; i < index; i++) {
        if (![_queue hasNext]) {
            return;
        }
        [_fifo put:[_queue deque]];
    }
}

- (void)play:(NSString*)urlStr {
    if (_mediaPlayer != NULL) {
        _mediaPlayer = NULL;
    }
    [_delegate seeking];
    _mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString: urlStr]];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerLoadStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changedLoadState:)
                                                 name:MPMoviePlayerLoadStateDidChangeNotification
                                               object:nil];
    
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    NSError* error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    [audioSession setActive:YES error:&error];
 
    [_mediaPlayer setShouldAutoplay:NO];
    [_mediaPlayer setControlStyle:MPMovieControlStyleNone];
    [_mediaPlayer play];
    _currentPlayingUrl = urlStr;
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:[NSBlockOperation blockOperationWithBlock:^{
        int time = _mediaPlayer.currentPlaybackTime;
        [_delegate updateCurrentPlaybackTime:time withSongDuration:[self getCurrentPlaybackDuration]];
    }] selector:@selector(main) userInfo:nil repeats:YES];
}

- (void)setMode:(TTAudioEngineMode)mode {
    _mode = mode;
}

- (int)getCurrentPlaybackDuration {
    if (_mediaPlayer.playbackState != MPMoviePlaybackStatePlaying
        && _mediaPlayer.playbackState != MPMoviePlaybackStatePaused) {
        return 0;
    }
    return _mediaPlayer.duration;
}

- (void)seek:(int)time {
    if (_mediaPlayer.playbackState != MPMoviePlaybackStatePlaying
        && _mediaPlayer.playbackState != MPMoviePlaybackStatePaused) {
        return;
    }
    if (time > [self getCurrentPlaybackDuration] || time <= 0) {
#ifdef DEBUG_OUT
        NSLog(@"Seeking without duration");
#endif
        return;
    }
    [_mediaPlayer setCurrentPlaybackTime:time];
}

- (void)setLockScreenInfo:(UIImage*)art
               audioTitle:(NSString*)audioTitle
               albumTitle:(NSString*)albumTitle
                   artist:(NSString*)artist {
    NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
    if (audioTitle != NULL) {
        [songInfo setObject:audioTitle forKey:MPMediaItemPropertyTitle];
    }
    if (artist != NULL) {
        [songInfo setObject:artist forKey:MPMediaItemPropertyArtist];
    }
    if (albumTitle != NULL) {
        [songInfo setObject:albumTitle forKey:MPMediaItemPropertyAlbumTitle];
    }
    if (art != NULL) {
        MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:art];
        [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
    }
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = songInfo;
}

- (void) changedLoadState:(NSNotification*)notification
{
    MPMoviePlayerController *mediaPlayer = [notification object];
    
    if ([mediaPlayer loadState] != MPMovieLoadStateUnknown) {

        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerLoadStateDidChangeNotification
                                                      object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerPlaybackDidFinishNotification
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(finishedPlay:)
                                                     name:MPMoviePlayerPlaybackDidFinishNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:MPMoviePlayerNowPlayingMovieDidChangeNotification
                                                      object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(changedState:)
                                                     name:MPMoviePlayerNowPlayingMovieDidChangeNotification
                                                   object:mediaPlayer];
        [_delegate readyPlaying];
    }
}

- (void)changedState:(NSNotification*)notificaiton {
    //MPMoviePlayerController *mediaPlayer = [notificaiton object];
}

- (void)finishedPlay:(NSNotification*)notification {
#ifdef DEBUG_OUT
    NSLog(@"play finished");
#endif
    switch (_mode) {
        case kAudioDoNotRepeat:
            [_fifo put:[_queue deque]];
            [self playPeek];
            break;
        case kAudioSongRepeat:
            [self playPeek];
            break;
        case kAudioAlbumRepeat:
            [_fifo put:[_queue deque]];
            if ([_queue isQueueEmpty]) {
                [_queue enqueArray:[_fifo getReverseList]];
            }
            [self playPeek];
            break;
        case kAudioShffle:
            //for debug
            [self playPeek];
            break;
        default:
            @throw @"Unclassified mode";
            break;
    }
}

@end
