//
//  TTViewBase.h
//  Marble
//
//  Created by TsuzukiTomoaki on 2014/01/15.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTResourceName.h"
#import "TTViewConstants.h"

@interface TTViewBase : UIView

@property (nonatomic, strong) UIButton* btn;

- (id)initWithFrame:(CGRect)frame;
- (void)showAnimation;
- (void)hideAnimation;
- (void)handleSingleTap;
- (void)clearFinish;
- (void)unregisterGesture;
- (void)registerGesture;

@end
