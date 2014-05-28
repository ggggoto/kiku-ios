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
#define SEARCH_PLACEHOLDER_JA @"Webから検索"
#define SEARCH_PLACEHOLDER_EN @"Search from web"

#define COMM_ALERT_TITLE_KEY @"CommAlertTitle"
#define COMM_ALERT_TITLE_JA @"アラート"
#define COMM_ALERT_TITLE_EN @"Alert"
#define COMM_ALERT_KEY @"CommAlertKey"
#define COMM_ALERT_JA @"サーチ出来ませんでした。"
#define COMM_ALERT_EN @"Sorry... Could not search"
#define COMM_ALERT_CONFIRMATION_KEY @"CommAlertConfirmation"
#define COMM_ALERT_CONFIRMATION_JA @"確認"
#define COMM_ALERT_CONFIRMATION_EN @"OK"

#define COLOR_HEADER @"ColorHeader"
#define COLOR_SEARCH_INSIDE @"ColorSearchInside"
#define COLOR_LIST_SEPARATION @"ListSeparationLine"

@interface TTMasterData : NSData

+ (TTMasterData*)sharedInstance;
- (NSString*) getText:(NSString*)key;

@property (nonatomic, strong) NSMutableDictionary *text;
@property (nonatomic, strong) NSMutableDictionary *color;
@property (nonatomic, strong) NSMutableArray *autoCompl;

@end
