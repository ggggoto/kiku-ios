//
//  RMHeaderView.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/08.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMViewBase.h"
#import "RMButton.h"

@protocol RMHeaderViewDelegate
- (void) channelButtonTapped:(NSString*)word;
@end

@interface RMHeaderView : RMViewBase<RMButtonDelegate, UITextFieldDelegate>

@property (nonatomic, strong) id<RMHeaderViewDelegate> delegate;
@property (nonatomic, strong) RMButton *button;
@property (nonatomic, strong) UITextField *textField;

- (id)initWithFrame:(CGRect)frame;

@end
