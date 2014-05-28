//
//  TTMainView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/25.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTMainView.h"
#import "TTMasterData.h"

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

//TODO debug
- (void)initializeListContentView:(TTSongData*)songData {
    _listContentView = [[TTListContentView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + kHeaderHeight, SCREEN_FRAME.size.width, kListHeight) withSongData:songData];
    [self addSubview:_listContentView];
    [_listContentView showAnimation];
}

#pragma mark header
-(void)headerMenuPressed {
}

-(void)headerSearchPressed:(NSString *)word {
    [_delegate headerSearchPressed:word];
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
