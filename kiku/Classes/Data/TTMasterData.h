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

#define PlAY_TITLE_KEY @"PlayViewTitle"
#define PLAY_TITLE_JA @"再生中"
#define PLAY_TITLE_EN @"Now Playing"

#define TWEET_TEXT1_KEY @"TweetText1"
#define TWEET_TEXT1_JA @"Now playing"
#define TWEET_TEXT1_EN @"Now playing"
#define TWEET_TEXT2_KEY @"TweetText2"
#define TWEET_TEXT2_JA @"by kiku"
#define TWEET_TEXT2_EN @"by kiku"

@interface TTMasterData : NSData

+ (TTMasterData*)sharedInstance;
- (NSString*) getText:(NSString*)key;
- (NSString*) getTweetInitialText:(NSString*)songName withArtistName:(NSString*)artsitName;

@property (nonatomic, strong) NSMutableDictionary *text;
@property (nonatomic, strong) NSMutableDictionary *color;
@property (nonatomic, strong) NSMutableArray *autoCompl;

@end
