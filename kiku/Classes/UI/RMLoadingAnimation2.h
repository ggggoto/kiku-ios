//
//  RMLoadingAnimation2.h
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2014/01/01.
//  Copyright (c) 2014年 ramuh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMLoadingAnimation2 : UIImageView

- (void)showAnimation;
- (void)hideAnimation;

- (void)showAnimation2;
- (void)hideAnimation2;

@property (nonatomic, assign) BOOL isShown;

@end
