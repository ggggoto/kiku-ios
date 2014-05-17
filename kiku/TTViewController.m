//
//  TTViewController.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

@synthesize comEngine = _comEngine;
@synthesize audioEngine = _audioEngine;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
}

- (void)initialize {
    _comEngine = [[TTCommunicationEngine alloc]init];
    _comEngine.delegate = self;
    [_comEngine trySearch:@"Rage against the machine" withPage:1];
    //[_comEngine tryGetAlbum:@"180252"];
    
    _audioEngine = [[TTAudioEngine alloc] init];
    [_audioEngine setMode:kAudioAlbumRepeat];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)recievedSongData:(NSMutableArray *)data {
    for (TTSongData* songData in data) {
        NSLog(songData.name);
        [_audioEngine enque:songData];
    }
    [_audioEngine playPeek];
}

-(void)remoteControlReceivedWithEvent:(UIEvent *)event{
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlPlay:
        case UIEventSubtypeRemoteControlPause:
            [self respondPlayPauseEvent];
            break;
        case UIEventSubtypeRemoteControlNextTrack:
            [_audioEngine playNextSong];
            break;
        case UIEventSubtypeRemoteControlPreviousTrack:
            [_audioEngine pressedBackButton];
            break;
        case UIEventSubtypeRemoteControlEndSeekingForward:
        case UIEventSubtypeRemoteControlEndSeekingBackward:
            break;
        default:
            break;
    }
}

-(void)respondPlayPauseEvent {
    switch ([_audioEngine getPlaybackState]) {
        case MPMoviePlaybackStatePlaying:
            [_audioEngine pausePlay];
            break;
        case MPMoviePlaybackStatePaused:
            [_audioEngine resumePlay];
            break;
        default:
            break;
    }
}


@end
