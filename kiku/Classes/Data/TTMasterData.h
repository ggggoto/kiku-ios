//
//  TTMasterData.h
//  Marble
//
//  Created by TsuzukiTomoaki on 2014/03/09.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ENGLISH @"en"
#define JAPANESE @"ja"

#define SEARCH_PLACEHOLDER_KEY @"SearchKey"
#define SEARCH_PLACEHOLDER_JA @"検索ワードを入れて下さい"
#define SEARCH_PLACEHOLDER_EN @"Keyword"

@interface TTMasterData : NSData

+ (TTMasterData*)sharedInstance;
- (NSString*) getText:(NSString*)key;

@property (nonatomic, strong) NSMutableDictionary *text;
@property (nonatomic, strong) NSMutableArray *autoCompl;

@end
