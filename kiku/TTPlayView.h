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
    
    
    
    kHideButtonTag = 2007,
} PLAY_VIEW_TYPE;

@protocol TTPlayViewDelegate

-(void)playOrStop;
-(void)playForward;
-(void)playBack;

@end

@interface TTPlayView : TTViewBase<TTButtonDelegate>

-(void)onChangedCurrentPlayingSong:(TTSongData*)data;
-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration;

@property (nonatomic, strong) id<TTPlayViewDelegate> delegate;

@end
