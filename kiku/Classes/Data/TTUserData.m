//
//  TTUserData.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTUserData.h"

@implementation TTUserData

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (TTUserData*)sharedInstance {
    static TTUserData* _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TTUserData alloc]
                     initSharedInstance];
    });
    return _instance;
}

- (id)initSharedInstance {
    self = [super init];
    if (self) {
    }
    return self;
}

@end
