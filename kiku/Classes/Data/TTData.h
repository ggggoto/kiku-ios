//
//  TT.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTData : NSData

- (void)load:(id)JSON;
- (NSString*)toString;

@end
