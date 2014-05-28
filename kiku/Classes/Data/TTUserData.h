//
//  TTUserData.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTUserData : NSObject

+ (TTUserData*)sharedInstance;

@property (nonatomic, strong) NSString* currentWord;
@property (nonatomic, assign) int page;

- (void)setNewWord:(NSString*)word;

@end
