//
//  TTShadowView.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/29.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewBase.h"

@protocol TTShadowViewDelegate
- (void) tappedShadowView;
@end

@interface TTShadowView : TTViewBase

@property (nonatomic, strong) id<TTShadowViewDelegate>delegate;

- (void)showAnimation;
- (void)hideAnimation;

@end
