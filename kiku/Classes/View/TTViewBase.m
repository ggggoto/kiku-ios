//
//  TTViewBase.m
//  Marble
//
//  Created by TsuzukiTomoaki on 2014/01/15.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewBase.h"

@implementation TTViewBase

@synthesize btn = _btn;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self registerGesture];
    }
    return self;
}

// Override this in subclass
- (void)handleSingleTap
{
}

- (void)showAnimation {
    [UIView animateWithDuration:kAnimShowDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 1.f;
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

// Override
- (void)blurFinish {
}
- (void)clearFinish {
}

- (void)unregisterGesture {
    _btn = NULL;
}

- (void)registerGesture {
    _btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [_btn addTarget:self
            action:@selector(handleSingleTap) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
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
