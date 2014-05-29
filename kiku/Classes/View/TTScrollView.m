//
//  TTScrollView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/29.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTScrollView.h"

@implementation TTScrollView

@synthesize delegate = _delegate;
@synthesize scrollView = _scrollView;
@synthesize songCache = _songCache;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeVariables];
        [self initializeViews];
    }
    return self;
}

- (void)initializeVariables {
    _songCache = [NSMutableArray array];
}

- (void)initializeViews {
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self addSubview:_scrollView];
}

- (void)recieveContentsArray:(NSArray*)songs {
    for (TTSongData *song in songs) {
        [self addContents:song];
    }
}

- (void)addContents:(TTSongData*)song {
    int index = (int)[_songCache count];
    TTListContentView *content = [[TTListContentView alloc]initWithFrame:CGRectMake(0,
                                                                                    kListHeight * index,
                                                                                    SCREEN_FRAME.size.width,
                                                                                    kListHeight)
                                                             withSongData:song
                                                               withIndex:index];
    content.delegate = self;
    [_scrollView addSubview:content];
    // Animation wait time. Initial 10 article has animation wait time
    float waitTime = 0;
    if (index <= 10) {
        waitTime = index * 0.075;
    }
    
    [_songCache addObject:song];
    [self updateContentSize];
    
    [NSTimer scheduledTimerWithTimeInterval:waitTime target:[NSBlockOperation blockOperationWithBlock:^{
        [content showAnimation];
    }] selector:@selector(main) userInfo:nil repeats:NO];
}

- (void)clearContent {
    [_songCache removeAllObjects];
    for (UIView *view in [_scrollView subviews]) {
        if([view isKindOfClass:[TTListContentView class]]) {
            TTListContentView *listContent = (TTListContentView*)view;
            [listContent hideAnimation];
        }
    }
}

- (void)updateContentSize  {
    int index = (int)[_songCache count];
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width, index * kListHeight)];
}

#pragma mark
-(void) contentTapped:(int)tag {
    [_delegate listTapped:tag];
}

-(void)finishedShowAnimation:(UIView *)content {
    
}

- (void)finishedHideAnimation:content {
    [content removeFromSuperview];
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
