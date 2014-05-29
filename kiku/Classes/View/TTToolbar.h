//
//  TTToolbar.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/30.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewBase.h"
#import "TTButton.h"

typedef enum toolbarButtonTypes {
    kToolbaButtonTag1 = 1001,
    kToolbaButtonTag2 = 1002,
    kToolbaButtonTag3 = 1003,
} TOOLBAR_TYPE;

@interface TTToolbar : TTViewBase

@property (nonatomic, strong) TTButton* button1;
@property (nonatomic, strong) TTButton* button2;
@property (nonatomic, strong) TTButton* button3;

@end
