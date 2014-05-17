//
//  TTAudioEngine.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTAudioEngine.h"

@implementation TTAudioEngine

@synthesize audioPlayer = _audioPlayer;
@synthesize mediaPlayer = _mediaPlayer;

- (void)play:(NSString*)urlStr {
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    _mediaPlayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL URLWithString: urlStr]];
    _mediaPlayer.shouldAutoplay = NO;
    _mediaPlayer.scalingMode= MPMovieScalingModeFill;
    _mediaPlayer.controlStyle =MPMovieControlStyleNone;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(null)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
    
    //MPMediaItemArtwork *albumArt = [[MPMediaItemArtwork alloc] initWithImage: [UIImage imagedNamed:@"AlbumArt"]];
    
    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
    NSError* error = nil;
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
    [audioSession setActive:YES error:&error];
    
    NSMutableDictionary *songInfo = [[NSMutableDictionary alloc] init];
    [songInfo setObject:@"Audio Title" forKey:MPMediaItemPropertyTitle];
    [songInfo setObject:@"Audio Author" forKey:MPMediaItemPropertyArtist];
    [songInfo setObject:@"Audio Album" forKey:MPMediaItemPropertyAlbumTitle];
    [MPNowPlayingInfoCenter defaultCenter].nowPlayingInfo = songInfo;
    
    [_mediaPlayer play];
    /*
    dispatch_queue_t dispatchQueue =
    dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void){
        NSString *_mp3file = urlStr;
        NSData   *_mp3Data = [NSData dataWithContentsOfURL:[NSURL URLWithString: _mp3file]];
        NSError  *_error   = nil;
        
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        
        _audioPlayer = [[AVAudioPlayer alloc] initWithData:_mp3Data error:&_error];

        AVAudioSession* audioSession = [AVAudioSession sharedInstance];
        NSError* error = nil;
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:&error];
        [audioSession setActive:YES error:&error];
        
        if (_audioPlayer != nil)
        {
            if ([_audioPlayer prepareToPlay] && [_audioPlayer play])
            {
                NSLog(@"Successfully started playing");
            } else {
                NSLog(@"Failed to play");
            }
        } else {
            NSLog(@"Failed to instanciate player");
        }
    });
     */
}

@end
