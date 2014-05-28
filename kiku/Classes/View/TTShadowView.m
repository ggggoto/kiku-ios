//
//  TTShadowView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/29.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTShadowView.h"

@implementation TTShadowView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.0];
    }
    return self;
}

- (void)showAnimation {
    [UIView animateWithDuration:kAnimShowDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 0.6;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:kAnimShowDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 0.f;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)handleSingleTap {
    [_delegate tappedShadowView];
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
