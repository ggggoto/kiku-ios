//
//  RMButton.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/09.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "TTViewBase.h"


@protocol TTButtonDelegate
- (void) tapped:(int)buttonTag;
@end

@interface TTButton : TTViewBase

- (id)initWithFrame:(CGRect)frame withButtonSize:(CGSize)size withImage:(UIImage*)image;
- (void)setButtonTag:(int)buttonTag;
- (void)tapAnimation;

@property (nonatomic, strong) id<TTButtonDelegate>delegate;
@property (nonatomic, assign) int buttonTag;

- (void)enable;
- (void)disable;

@end
