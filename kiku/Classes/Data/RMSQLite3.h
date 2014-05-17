//
//  RMSQLite3.h
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2013/12/31.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "TTSongData.h"

@interface RMSQLite3 : NSObject

+ (RMSQLite3*)sharedInstance;

@property (nonatomic, assign)sqlite3 *database;

- (void)openDatabase;
- (void)closeDatabase;
- (void)insertPlaylistIfNotExist:(NSString*)playListName;
- (BOOL)insertSongIfNotExist:(TTSongData*)songData;

@end
