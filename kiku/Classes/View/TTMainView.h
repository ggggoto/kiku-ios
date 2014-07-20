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
#import "TTToolbar.h"
#import "TTPlayView.h"

@protocol TTMainViewDelegate
-(void)headerSearchPressed:(NSString*)word;
-(void)listTapped:(int)tag;
-(void)headerMenuTapped;
-(void)onPlayStopButtonPressed;
-(void)onPreviousButtonPressed;
-(void)onNextSongButtonPressed;
-(void)onSeekBarValueChanged:(int)time;
-(void)ontTweetButtonPressed:(NSString*)songName withArtistName:(NSString*)artistName;
@end

@interface TTMainView : TTViewBase<
TTHeaderViewDelegate,
TTShadowViewDelegate,
TTScrollViewDelegate,
TTPlayViewDelegate
>

@property (nonatomic, strong) id<TTMainViewDelegate>delegate;
@property (nonatomic, strong) UIView *statusBarView;
@property (nonatomic, strong) TTHeaderView *headerView;
@property (nonatomic, strong) TTScrollView *scrollView;
@property (nonatomic, strong) TTShadowView *shadowView;
@property (nonatomic, strong) TTToolbar *toolBar;
@property (nonatomic, strong) TTPlayView *playView;

- (void)recievedSongData:(NSArray*)songs;
- (void)clearSongs;
-(void)onChangedCurrentPlayingSong:(TTSongData*)data;
-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration;

@end
