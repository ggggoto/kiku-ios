//
//  RMButton.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/09.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMViewBase.h"

typedef enum {
    kButtonEnble = 0,
    kButtonDisable = 1
} ButtonState;

@protocol RMButtonDelegate
- (void) tapped:(int)buttonTag;
@end

@interface RMButton : RMViewBase

- (id)initWithFrame:(CGRect)frame withButtonSize:(CGSize)size withImage:(UIImage*)image;
- (void)setButtonTag:(int)buttonTag;
- (void)tapAnimation;
- (void)setInteraction:(bool)enable;

@property (nonatomic, strong) id<RMButtonDelegate>delegate;
@property (nonatomic, assign) int buttonTag;
@property (nonatomic, assign) ButtonState state;

@end
