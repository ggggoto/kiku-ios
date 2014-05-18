//
//  TTMainView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTMainView.h"
#import "ViewConstants.h"

@implementation TTMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        // Order matters here
        [self initializeListView];
        [self initializeHeader];
        [self initializeStatusBar];
        //[self initializeToolBar];
        [self initializeErrorview];
    }
    return self;
}


- (void)initializeStatusBar {
    UIView * statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, STATUS_BAR_HEIGHT)];
    [statusBar setBackgroundColor:[UIColor blackColor]];
    [statusBar setAlpha:STATUS_BAR_ALPHA];
    [self addSubview:statusBar];
}

- (void)initializeHeader {
    _headerView = [[RMHeaderView alloc]initWithFrame:CGRectMake(0,
                                                                0,
                                                                SCREEN_FRAME.size.width,
                                                                CH_HEADER_HEIGHT)];
    _headerView.delegate = self;
    _headerView.alpha = 0.0f;
    [self addSubview:_headerView];
    [_headerView showAnimation];
}

- (void)initializeListView {
    _listView = [[RMListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, SCREEN_FRAME.size.height)];
    _listView.delegate = self;
    [self addSubview:_listView];
    [_listView showAnimation];
}

- (void)initializeToolBar {
    _toolBar = [[RMToolBar alloc]initWithFrame:CGRectMake(0, SCREEN_FRAME.size.height + STATUS_BAR_HEIGHT, SCREEN_FRAME.size.width, TOOLBAR_HEIGHT)];
    _toolBar.delegate = self;
    [self addSubview:_toolBar];
    [_toolBar showAnimation];
}

- (void)initializeErrorview {
    _errorView = [[RMErrorView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, SCREEN_FRAME.size.height)];
    [_errorView setAlpha:0.0];
    _errorView.delegate = self;
    [self addSubview:_errorView];
}

- (void)recieveContentsArray:(NSArray*)songs {
    [_listView recieveContentsArray:songs];
}

- (void)recieveErrorGettingContents {
    if ([_listView.array count] == 0) {
        [_errorView showAnimation];
    }
    [_listView recieveErrorGettingContents];
}

- (void)clearList {
    [_listView clearList];
}

#pragma mark scroll
-(void)scrollViewReachedThreshold {
    NSLog(@"load further");
}

#pragma mark header
-(void)channelButtonTapped:(NSString *)word {
    [_delegate search:word];
}

#pragma mark listView
- (void)songSelected:(NSString *)urlStr {
    
}

#pragma mark toolbar
- (void)toolbarTapped:(int)buttonTag {
    
}

#pragma mark error
- (void)errorViewTapped {
    
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
