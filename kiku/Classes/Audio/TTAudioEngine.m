//
//  TTAudioEngine.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTAudioEngine.h"
#import "Macro.h"

@implementation TTAudioEngine

@synthesize delegate = _delegate;
@synthesize audioPlayer = _audioPlayer;
@synthesize mediaPlayer = _mediaPlayer;
@synthesize mode = _mode;
@synthesize currentPlayingUrl = _currentPlayingUrl;

- (id)init {
    self = [super init];
    _mode = kAudioDoNotRepeat;
    _currentPlayingUrl = NULL;
    return self;
}

- (void)play:(NSString*)urlStr {
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
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
        [_delegate updateCurrentPlaybackTime:time];
    }] selector:@selector(main) userInfo:nil repeats:YES];
}

- (void)setMode:(TTAudioEngineMode)mode {
    _mode = mode;
}

- (int)getCurrentPlaybackDuration {
    if (_mediaPlayer.playbackState != MPMoviePlaybackStatePlaying
        || _mediaPlayer.playbackState != MPMoviePlaybackStatePaused) {
        return 0;
    }
    return _mediaPlayer.duration;
}

- (void)seek:(int)time {
    if (_mediaPlayer.playbackState != MPMoviePlaybackStatePlaying
        || _mediaPlayer.playbackState != MPMoviePlaybackStatePaused) {
        return;
    }
    if (time > [self getCurrentPlaybackDuration] && time > 0) {
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
    MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage:art];
    NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
    [songInfo setObject:@"Audio Title" forKey:MPMediaItemPropertyTitle];
    [songInfo setObject:@"Audio Author" forKey:MPMediaItemPropertyArtist];
    [songInfo setObject:@"Audio Album" forKey:MPMediaItemPropertyAlbumTitle];
    [songInfo setObject:albumArt forKey:MPMediaItemPropertyArtwork];
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
                                                        name:MPMoviePlayerTimedMetadataUpdatedNotification
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
            break;
        case kAudioSongRepeat:
            [self play:_currentPlayingUrl];
            break;
        case kAudioAlbumRepeat:
            break;
        default:
            @throw @"Unclassified mode";
            break;
    }
    
}

@end
