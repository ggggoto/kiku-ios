//
//  TTListContentView.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/26.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewBase.h"
#import "TTSongData.h"
#import "RMLoadingCommon.h"

@protocol TTListContentViewDelegate
-(void)finishedShowAnimation:(UIView*)content;
-(void)finishedHideAnimation:(UIView*)content;
-(void)contentTapped:(int)index;
@end

@interface TTListContentView : TTViewBase <TTSongDataDelegate>

@property (nonatomic, strong)id<TTListContentViewDelegate>delegate;
@property (nonatomic, strong)UIImageView *thumbnail;
@property (nonatomic, strong)UILabel *artistName;
@property (nonatomic, strong)UILabel *title;
@property (nonatomic, strong)UIImageView *playButton;
@property (nonatomic, strong)RMLoadingCommon *loadingCommon;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, assign)int index;

- (id)initWithFrame:(CGRect)frame withSongData:(TTSongData*)songData withIndex:(int)index;

@end
