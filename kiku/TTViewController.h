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
#import "TTMainView.h"

@interface TTViewController : UIViewController<
TTCommunicationEngineDelegate,
TTAudioEngineDelegate,
TTMainViewDelegate
>

@property (nonatomic, strong) TTCommunicationEngine* comEngine;
@property (nonatomic, strong) TTAudioEngine *audioEngine;
@property (nonatomic, strong) TTMainView *mainView;

@end
