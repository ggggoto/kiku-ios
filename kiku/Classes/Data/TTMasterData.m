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
        _autoCompl = [NSMutableArray array];
        [_autoCompl addObject:@"サザンオールスターズ"];
        [_autoCompl addObject:@"Mr Children"];
        
        [self setupText];
        [self setupColor];
    }
    return self;
}

- (NSString*) getText:(NSString*)key {
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *lang = [languages objectAtIndex:0];
    return [[_text objectForKey:lang]objectForKey:key];
}

- (NSString*) getTweetInitialText:(NSString *)songName withArtistName:(NSString *)artsitName {
    NSString *initialText1 = [self getText:TWEET_TEXT1_KEY];
    NSString *initialText2 = [self getText:TWEET_TEXT2_KEY];
    NSString *initialText = [NSString stringWithFormat:@"%@ \"%@ - %@\" %@", initialText1,songName,artsitName,initialText2];
    
    NSLog(@"%@",initialText1);
    
    return initialText;
}

- (void) setupColor {
    _color = [[NSMutableDictionary alloc]init];
    [_color setValue:[UIColor colorWithRed:0.878 green:0.416 blue:0.039 alpha:1.0] forKey:COLOR_HEADER];
    [_color setValue:[UIColor colorWithRed:0.561 green:0.275 blue:0.031 alpha:1.0] forKey:COLOR_SEARCH_INSIDE];
    [_color setValue:[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] forKey:COLOR_LIST_SEPARATION];
}

- (void) setupText {
    _text = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *japanese = [[NSMutableDictionary alloc]init];
    [japanese setValue:SEARCH_PLACEHOLDER_JA forKey:SEARCH_PLACEHOLDER_KEY];
    [japanese setValue:COMM_ALERT_JA forKey:COMM_ALERT_KEY];
    [japanese setValue:COMM_ALERT_TITLE_JA forKey:COMM_ALERT_TITLE_KEY];
    [japanese setValue:COMM_ALERT_CONFIRMATION_JA forKey:COMM_ALERT_CONFIRMATION_KEY];
    [japanese setValue:PLAY_TITLE_JA forKey:PlAY_TITLE_KEY];
    [japanese setValue:TWEET_TEXT1_JA forKey:TWEET_TEXT1_KEY];
    [japanese setValue:TWEET_TEXT2_JA forKey:TWEET_TEXT2_KEY];
    
    NSMutableDictionary *english = [[NSMutableDictionary alloc]init];
    [english setValue:SEARCH_PLACEHOLDER_EN forKey:SEARCH_PLACEHOLDER_KEY];
    [english setValue:COMM_ALERT_EN forKey:COMM_ALERT_KEY];
    [english setValue:COMM_ALERT_TITLE_EN forKey:COMM_ALERT_TITLE_KEY];
    [english setValue:COMM_ALERT_CONFIRMATION_EN forKey:COMM_ALERT_CONFIRMATION_KEY];
    [english setValue:PLAY_TITLE_EN forKey:PlAY_TITLE_KEY];
    [english setValue:TWEET_TEXT1_EN forKey:TWEET_TEXT1_KEY];
    [english setValue:TWEET_TEXT2_EN forKey:TWEET_TEXT2_KEY];
    
    [_text setObject:japanese forKey:JAPANESE];
    [_text setObject:english forKey:ENGLISH];
}

@end
