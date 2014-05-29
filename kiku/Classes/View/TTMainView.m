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

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeStatusBarView];
        [self initializeScrollView];
        [self initializeShadowView];
        [self initializeHeaderView];
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
                                                                SCREEN_FRAME.size.height - kHeaderHeight)];
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
