//
//  TTMasterData.m
//  Marble
//
//  Created by TsuzukiTomoaki on 2014/03/09.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTMasterData.h"

@implementation TTMasterData

@synthesize autoCompl = _autoCompl;

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (TTMasterData*)sharedInstance {
    static TTMasterData* _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[TTMasterData alloc]
                     initSharedInstance];
    });
    return _instance;
}

- (id)initSharedInstance {
    self = [super init];
    if (self) {
        // do something
        
        _text = [[NSMutableDictionary alloc]init];
        NSMutableDictionary *japanese = [[NSMutableDictionary alloc]init];
        [japanese setValue:SEARCH_PLACEHOLDER_JA forKey:SEARCH_PLACEHOLDER_KEY];
        
        NSMutableDictionary *english = [[NSMutableDictionary alloc]init];
        [english setValue:SEARCH_PLACEHOLDER_EN forKey:SEARCH_PLACEHOLDER_KEY];
        
        [_text setObject:japanese forKey:JAPANESE];
        [_text setObject:english forKey:ENGLISH];
        
        _autoCompl = [NSMutableArray array];
        [_autoCompl addObject:@"サザンオールスターズ"];
        [_autoCompl addObject:@"Mr Children"];
    }
    return self;
}

- (NSString*) getText:(NSString*)key {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *lang = [languages objectAtIndex:0];
    return [[_text objectForKey:lang]objectForKey:key];
}

@end
