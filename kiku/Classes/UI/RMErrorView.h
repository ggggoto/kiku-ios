//
//  RMErrorView.h
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2014/01/03.
//  Copyright (c) 2014年 ramuh. All rights reserved.
//

#import "RMViewBase.h"

@protocol RMErrorViewDelegate
- (void)errorViewTapped;
@end

@interface RMErrorView : RMViewBase

@property (nonatomic, strong) id<RMErrorViewDelegate> delegate;

@end
