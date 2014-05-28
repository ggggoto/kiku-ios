//
//  TTMainView.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/25.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewBase.h"
#import "TTHeaderView.h"
#import "TTListContentView.h"
#import "TTScrollView.h"
#import "TTShadowView.h"

@protocol TTMainViewDelegate
-(void)headerSearchPressed:(NSString*)word;
@end


@interface TTMainView : TTViewBase<
TTHeaderViewDelegate,
TTShadowViewDelegate
>

@property (nonatomic, strong) id<TTMainViewDelegate>delegate;
@property (nonatomic, strong) UIView *statusBarView;
@property (nonatomic, strong) TTHeaderView *headerView;
@property (nonatomic, strong) TTScrollView *scrollView;
@property (nonatomic, strong) TTShadowView *shadowView;
 
- (void)recievedSongData:(NSArray*)songs;
- (void)clearSongs;

@end
