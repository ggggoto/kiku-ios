//
//  TTViewController.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTCommunicationEngine.h"
#import "TTAudioEngine.h"

@interface TTViewController : UIViewController

@property (nonatomic, strong) TTCommunicationEngine* comEngine;
@property (nonatomic, strong) TTAudioEngine *audioEngine;

@end
