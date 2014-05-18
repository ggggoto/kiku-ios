//
//  TTViewController.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewController.h"
#import "ViewConstants.h"

@interface TTViewController ()

@end

@implementation TTViewController

@synthesize comEngine = _comEngine;
@synthesize audioEngine = _audioEngine;
@synthesize mainView = _mainView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initializeEngine];
    [self initializeMainView];
}

- (void)initializeMainView {
    _mainView = [[TTMainView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, SCREEN_FRAME.size.height)];
    [_mainView setDelegate:self];
    self.view = _mainView;
}

- (void)initializeEngine {
    _comEngine = [[TTCommunicationEngine alloc]init];
    _comEngine.delegate = self;
    
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

#pragma mark communication engine
- (void)recievedSongData:(NSMutableArray *)data {
    [_mainView recieveContentsArray:data];
    
    [_audioEngine flush];
    for (TTSongData* songData in data) {
        [_audioEngine enque:songData];
    }
    [_audioEngine playPeek];
}

#pragma mark audio engine
- (void)readyPlaying {
    
}

- (void)updateCurrentPlaybackTime:(int)currentPlaybackTime {
    
}

#pragma mark background play
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

#pragma mark mainview
-(void)search:(NSString *)word {
    [_mainView clearList];
    [_comEngine trySearch:word withPage:1];
}

@end
