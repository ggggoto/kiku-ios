//
//  RMRefreshLoadingAnimation.h
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2014/02/08.
//  Copyright (c) 2014年 ramuh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMLoadingAnimation2.h"

@interface RMRefreshLoadingAnimation : UIView

@property (nonatomic, strong) RMLoadingAnimation2 *autoLoadAnim;
@property (nonatomic, strong) NSArray* imgArray;
@property (nonatomic, assign) int imageIndex;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) RMLoadingAnimation2 *anim;

- (void) stepAnimation;
- (void) showAnimation;
- (void) hideAnimation;
- (void) hideAnimation2;
- (void) autoStepAnimation;

@end
