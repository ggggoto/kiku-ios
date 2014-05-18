//
//  RMButton.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/09.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMButton.h"
#import "ViewConstants.h"

@implementation RMButton

@synthesize buttonTag = _buttonTag;
@synthesize state = _state;

- (id)initWithFrame:(CGRect)frame withButtonSize:(CGSize)size withImage:(UIImage*)image {
    self = [super initWithFrame:frame withBlurLevel:0];
    if (self) {
        // Initialization code
        [self.originalImageView setFrame:CGRectMake((self.frame.size.width - size.width) / 2 + OFF_CENTER,
                                                    (self.frame.size.height - size.height) / 2,
                                                    size.width,
                                                    size.height)];
        [self.originalImageView setContentMode:UIViewContentModeRedraw];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setOriginalImage:image];
        [self setInteraction:true];
        _state = kButtonEnble;
    }
    return self;
}

- (void)setButtonTag:(int)buttonTag {
    _buttonTag = buttonTag;
}

- (void)singleTapAction {
    [_delegate tapped:_buttonTag];
}

- (void)tapAnimation {
    [UIView animateWithDuration:kAnimDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 0.5;
                     }
                     completion:^(BOOL finished){
                         //Completion
                         [UIView animateWithDuration:kAnimDuration
                                               delay:0.0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              //Animation
                                              switch (_state) {
                                                  case kButtonEnble:
                                                      self.alpha = 1.0;
                                                      break;
                                                  case kButtonDisable:
                                                      self.alpha = 0.5;
                                                      break;
                                                  default:
                                                      break;
                                              }
                                          }
                                          completion:^(BOOL finished){
                                              //Completion
                                              
                                          }];
                     }];
}

- (void)setInteraction:(bool)enable {
    if (enable) {
        [self setAlpha:1.0];
        [self setUserInteractionEnabled:YES];
        _state = kButtonEnble;
    } else {
        [self setAlpha:0.5];
        [self setUserInteractionEnabled:NO];
        _state = kButtonDisable;
    }
}

@end
