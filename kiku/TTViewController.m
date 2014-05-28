//
//  TTViewController.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewController.h"
#import "TTMasterData.h"
#import "TTUserData.h"
#import "TTViewConstants.h"

@interface TTViewController ()

@end

@implementation TTViewController

@synthesize comEngine = _comEngine;
@synthesize audioEngine = _audioEngine;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //for debug
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 100, 100, 50);
    [btn setTitle:@"早送り" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hoge:)forControlEvents:UIControlEventTouchDown];
    //[self.view addSubview:btn];
    
    [self initializeCommEngine];
    [self initializeAudioEngine];
    
    [self initializeMainView];
    
}

//for debug
-(void)hoge:(UIButton*)button{
    [_audioEngine seek:[_audioEngine getCurrentPlaybackDuration] - 5];
}

- (void)initializeCommEngine {
    _comEngine = [[TTCommunicationEngine alloc]init];
    _comEngine.delegate = self;
    //[_comEngine trySearch:@"Rage against the machine" withPage:1];
    //[_comEngine tryGetAlbum:@"180252"];
}

- (void)initializeAudioEngine {
    _audioEngine = [[TTAudioEngine alloc] init];
    [_audioEngine setMode:kAudioAlbumRepeat];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
}

- (void)initializeMainView {
    _mainView = [[TTMainView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, SCREEN_FRAME.size.height)];
    _mainView.delegate = self;
    [self.view addSubview:_mainView];
}

- (void)showAlertView {
    UIAlertView *alert =
    [[UIAlertView alloc] initWithTitle:[[TTMasterData sharedInstance].text objectForKey:COMM_ALERT_TITLE_KEY]
                               message:[[TTMasterData sharedInstance].text objectForKey:COMM_ALERT_KEY]
                              delegate:nil
                     cancelButtonTitle:[[TTMasterData sharedInstance].text objectForKey:COMM_ALERT_CONFIRMATION_KEY]
                     otherButtonTitles:nil];
    [alert show];
}

- (void)recievedSongData:(NSMutableArray *)data {
    for (TTSongData* songData in data) {
        if (_mainView.listContentView != NULL) {
            return;
        }
        [_mainView initializeListContentView:songData];
    }
    //TODO Update list here
    
    /*
    for (TTSongData* songData in data) {
        NSLog(songData.name);
        [_audioEngine enque:songData];
    }
    [_audioEngine playPeek];
    */
}

- (void)errorReceived {
    [self showAlertView];
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

#pragma mark Header
- (void)headerSearchPressed:(NSString *)word {
    if ([_comEngine trySearch:word withPage:1]) {
        [[TTUserData sharedInstance] setNewWord:word];
        [TTUserData sharedInstance].page = 1;
    } else {
        [self showAlertView];
    }
}

@end
