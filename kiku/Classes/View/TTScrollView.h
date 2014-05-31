//
//  TTScrollView.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/29.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewBase.h"
#import "TTListContentView.h"
#import "TTSongData.h"
#import "FXBlurView.h"

@protocol TTScrollViewDelegate
-(void)listTapped:(int)tag;
@end

@interface TTScrollView : TTViewBase<UIScrollViewDelegate, TTListContentViewDelegate>

@property (nonatomic, strong) id<TTScrollViewDelegate>delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *songCache;

- (void)recieveContentsArray:(NSArray*)songs;
- (void)clearContent;

@end
