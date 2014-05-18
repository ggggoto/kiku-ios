//
//  RMLabel.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/11.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface RMLabel : UILabel

@property (nonatomic, readwrite) VerticalAlignment verticalAlignment;


@end