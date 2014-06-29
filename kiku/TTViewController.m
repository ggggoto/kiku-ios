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
    _audioEngine.delegate = self;
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
    [[TTUserData sharedInstance]addSongsToArray:data];
    [_mainView recievedSongData:data];
    [self enqueAllSongs:data];
}

- (void)enqueAllSongs:(NSArray*)songs {
    for (TTSongData* songData in songs) {
        [_audioEngine enque:songData];
    }
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

#pragma mark audio engine
-(void)seeking {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)readyPlaying {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration
{
    [_mainView updateCurrentPlaybackTime:currentPlaybackTime withSongDuration:songDuration];
}

-(void)onChangedCurrentPlayingSong:(TTSongData *)songData
{
    [_mainView onChangedCurrentPlayingSong:songData];
}

- (int)getCurrentPlaybackDuration
{
    return [_audioEngine getCurrentPlaybackDuration];
}


#pragma mark Header
- (void)headerSearchPressed:(NSString *)word {
    if ([_comEngine trySearch:word withPage:1]) {
        [_audioEngine flush];
        [_mainView clearSongs];
        [[TTUserData sharedInstance] clearSongs];
        [[TTUserData sharedInstance] setNewWord:word];
        [TTUserData sharedInstance].page = 1;
    } else {
        [self showAlertView];
    }
}

- (void)headerMenuTapped {
    //TODO
    if (_blurView == NULL || _blurView.alpha <= 0.0f) {
        [self makeBlur:[UIColor clearColor] withBlurLevel:10.0f];
    } else {
        [self makeClear];
    }
}

#pragma mark mainview
-(void)listTapped:(int)tag {
    [_audioEngine playAtIndex:tag];
    _mainView.playView.alpha = 1.0f;
}

#pragma mark mainview
-(void)playOrStop{
    [self respondPlayPauseEvent];
}

-(void)playingBack
{
    [_audioEngine pressedBackButton];
}

-(void)playingForward
{
    [_audioEngine playNextSong];
}

#pragma mark blur
- (void)makeBlur:(UIColor*)color withBlurLevel:(float)blurLevel {
    if (_blurView == NULL) {
        _blurView = [[FXBlurView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kHeaderHeight, self.view.frame.size.width, self.view.frame.size.height - kHeaderHeight - kToolbarHeight - kStatusBarHeight)];
        [_blurView setBackgroundColor:[UIColor clearColor]];
        [self.view addSubview:_blurView];
        _blurView.blurRadius = blurLevel;
        _blurView.alpha = 0.f;
        _blurView.tintColor = color;
        _blurView.dynamic = NO;
        _blurView.iterations = 10;
        [_blurView setNeedsDisplay];
    }
    
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[NSBlockOperation blockOperationWithBlock:^{
        _blurView.alpha += 0.2;
        if (_blurView.alpha >= 1.0) {
            [timer invalidate];
            //_viewState = kScrollViewBlur;
        }
    }] selector:@selector(main) userInfo:nil repeats:YES];
}

- (void)makeClear {
    if (_blurView != NULL) {
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[NSBlockOperation blockOperationWithBlock:^{
            _blurView.alpha -= 0.2;
            if (_blurView.alpha <= 0.0) {
                [timer invalidate];
                [_blurView removeFromSuperview];
                _blurView = NULL;
            }
        }] selector:@selector(main) userInfo:nil repeats:YES];
    }
}

@end
