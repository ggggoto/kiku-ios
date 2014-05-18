//
//  RMToolBar.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/19.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMViewBase.h"
#import "RMButton.h"

@protocol RMToolBarDelegate
- (void) toolbarTapped:(int)buttonTag;
@end

typedef enum {
    BACK= 1000,
    FORWARD = 1001,
    TWITTER = 1002,
    FB = 1003,
    SOCIAL = 1004
} toolBar;

@interface RMToolBar : RMViewBase<RMButtonDelegate>

@property (nonatomic, strong) id<RMToolBarDelegate> delegate;
@property (nonatomic, assign) BOOL isShown;

- (void) setForwardButtonInteraction:(bool)enable;

@end
