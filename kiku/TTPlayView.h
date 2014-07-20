//
//  TTPlayView.h
//  kiku
//
//  Created by Goto Daisuke on 6/28/14.
//  Copyright (c) 2014 TsuzukiTomoaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTViewBase.h"
#import "TTMasterData.h"
#import "TTSongData.h"
#import "TTButton.h"

typedef enum playViewButtonTypes {
    kPlayButtonTag = 2001,
    kBackButtonTag = 2002,
    kForwardButtonTag = 2003,
    kRepeatButtonTag = 2004,
    kShuffleButtonTag = 2005,
    kTweetButtonTag = 2006,
    kHideButtonTag = 2007,
} PLAY_VIEW_TYPE;

@protocol TTPlayViewDelegate

-(void)onPlayStopButtonPressed;
-(void)onPreviousButtonPressed;
-(void)onNextSongButtonPressed;
-(void)onSeekBarValueChanged:(int)time;
-(void)ontTweetButtonPressed:(NSString*)songName withArtistName:(NSString*)artistName;

@end

@interface TTPlayView : TTViewBase<TTButtonDelegate>

-(void)onChangedCurrentPlayingSong:(TTSongData*)data;
-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration;

@property (nonatomic, strong) id<TTPlayViewDelegate> delegate;

@end
