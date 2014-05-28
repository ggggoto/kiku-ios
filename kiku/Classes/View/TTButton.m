//
//  RMButton.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/09.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "TTButton.h"

#define kButtonTapDuration 0.1
#define kDisableAlpha 0.6

@implementation TTButton

@synthesize buttonTag = _buttonTag;

- (id)initWithFrame:(CGRect)frame withButtonSize:(CGSize)size withImage:(UIImage*)image {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake((self.frame.size.width - size.width) / 2,
                                                                             (self.frame.size.height - size.height) / 2,
                                                                             size.width,
                                                                             size.height)];
        [imageView setImage:image];
        [self addSubview:imageView];
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)enable {
    [self setUserInteractionEnabled:true];
    [self setAlpha:1.0];
}

- (void)disable {
    [self setUserInteractionEnabled:false];
    [self setAlpha:kDisableAlpha];
}


- (void)setButtonTag:(int)buttonTag {
    _buttonTag = buttonTag;
}

- (void)handleSingleTap {
    [_delegate tapped:_buttonTag];
    [self tapAnimation];
}

- (void)tapAnimation {
    [UIView animateWithDuration:kButtonTapDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 0.2;
                     }
                     completion:^(BOOL finished){
                         //Completion
                         [UIView animateWithDuration:kButtonTapDuration
                                               delay:0.0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              //Animation
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished){
                                              //Completion
                                              
                                          }];
                     }];
}

@end
