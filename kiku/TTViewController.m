//
//  TTViewController.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewController.h"
#import "HTAutocompleteManager.h"
#import "TTMasterData.h"

@interface TTViewController ()

@end

@implementation TTViewController

@synthesize comEngine = _comEngine;
@synthesize audioEngine = _audioEngine;
@synthesize textField = _textField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //for debug
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(10, 100, 100, 50);
    [btn setTitle:@"早送り" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(hoge:)forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:btn];
    
    [self setAutoCompTextField];
    
    [self initialize];
}

//for debug
-(void)hoge:(UIButton*)button{
    [_audioEngine seek:[_audioEngine getCurrentPlaybackDuration] - 5];
}

- (void)setAutoCompTextField {
    _textField = [[HTAutocompleteTextField alloc]initWithFrame:CGRectMake(20,
                                                                          200,
                                                                          200,
                                                                          50)];
    _textField.autocompleteDataSource = [HTAutocompleteManager sharedManager];
    _textField.autocompleteType = HTAutocompleteTypeEmail;
    [_textField setBorderStyle:UITextBorderStyleBezel];
    NSString *placeHolder = [[TTMasterData sharedInstance] getText:SEARCH_PLACEHOLDER_KEY];
    [_textField setPlaceholder:placeHolder];
    //_textField.delegate = self;
    
    [self.view addSubview:_textField];
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
