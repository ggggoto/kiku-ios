//
//  TTMainView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/25.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTMainView.h"
#import "TTMasterData.h"
#import "NSString+util.h"

@implementation TTMainView

@synthesize delegate = _delegate;
@synthesize statusBarView = _statusBarView;
@synthesize headerView = _headerView;
@synthesize toolBar = _toolBar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeStatusBarView];
        [self initializeScrollView];
        [self initializeShadowView];
        [self initializeHeaderView];
        [self initializeToolbar];
        [self initializePlayView];
    }
    return self;
}

- (void)initializeStatusBarView {
    _statusBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, kStatusBarHeight)];
    [_statusBarView setBackgroundColor:[[TTMasterData sharedInstance].color objectForKey:COLOR_HEADER]];
    [self addSubview:_statusBarView];
}

- (void)initializeHeaderView {
    _headerView = [[TTHeaderView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight, SCREEN_FRAME.size.width, kHeaderHeight)];
    [_headerView setDelegate:self];
    [self addSubview:_headerView];
}

- (void)initializeShadowView {
    _shadowView = [[TTShadowView alloc]initWithFrame:CGRectMake(0, kHeaderHeight, SCREEN_FRAME.size.width, SCREEN_FRAME.size.height)];
    _shadowView.delegate = self;
    [self addSubview:_shadowView];
}

- (void)initializeScrollView {
    _scrollView = [[TTScrollView alloc]initWithFrame:CGRectMake(0,
                                                                kStatusBarHeight + kHeaderHeight,
                                                                SCREEN_FRAME.size.height,
                                                                SCREEN_FRAME.size.height - kHeaderHeight - kToolbarHeight)];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}

- (void)initializeToolbar {
    _toolBar = [[TTToolbar alloc]initWithFrame:CGRectMake(0,
                                                         SCREEN_FRAME.size.height + kStatusBarHeight - kToolbarHeight,
                                                         SCREEN_FRAME.size.width,
                                                          kToolbarHeight)];
    [self addSubview:_toolBar];
}

- (void)initializePlayView {
    _playView = [[TTPlayView alloc]initWithFrame:CGRectMake(0,
                                                            0,
                                                            SCREEN_FRAME.size.width,
                                                            SCREEN_FRAME.size.height + kStatusBarHeight - kToolbarHeight)];
    _playView.delegate = self;
    [self addSubview:_playView];
}

#pragma mark scrollview
- (void)recievedSongData:(NSArray*)songs {
    [_scrollView recieveContentsArray:songs];
}

- (void)clearSongs {
    [_scrollView clearContent];
}

#pragma mark header
-(void)headerMenuPressed {
    [_delegate headerMenuTapped];
}

-(void)headerSearchPressed:(NSString *)word {
    [_shadowView hideAnimation];
    if (![NSString_util stringIsNilOrEmpty:word]) {
        [_delegate headerSearchPressed:word];
    }
}

- (void)headerSearchBegin {
    [_shadowView showAnimation];
}

#pragma shadowview
- (void)tappedShadowView {
    [_shadowView hideAnimation];
    [_headerView cancelSearchInput];
}

#pragma scrollview
-(void)listTapped:(int)tag {
    [_delegate listTapped:tag];
}

#pragma playview
-(void)onChangedCurrentPlayingSong:(TTSongData*)data {
    [_playView onChangedCurrentPlayingSong:data];
}

-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration {
    [_playView updateCurrentPlaybackTime:currentPlaybackTime withSongDuration:songDuration];
}

-(void)onPlayStopButtonPressed {
    [_delegate onPlayStopButtonPressed];
}

-(void)onPreviousButtonPressed {
    [_delegate onPreviousButtonPressed];
}

-(void)onNextSongButtonPressed {
    [_delegate onNextSongButtonPressed];
}

-(void)onSeekBarValueChanged:(int)time {
    [_delegate onSeekBarValueChanged:time];
}

-(void)ontTweetButtonPressed:(NSString *)songName withArtistName:(NSString *)artistName {
    [_delegate ontTweetButtonPressed:songName withArtistName:artistName];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
