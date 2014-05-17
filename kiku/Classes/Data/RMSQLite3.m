//
//  RMSQLite3.m
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2013/12/31.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMSQLite3.h"
#import <sqlite3.h>

#define DBNAME @"RSS.db"
#define TABLE_NAME_PLAYLIST @"playrlist"
#define TABLE_NAME_SONG @"song"

@implementation RMSQLite3

@synthesize database = _database;

- (id)init {
    [self doesNotRecognizeSelector:_cmd];
    return nil;
}

+ (RMSQLite3*)sharedInstance {
    static RMSQLite3* _instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RMSQLite3 alloc]
                     initSharedInstance];
    });
    return _instance;
}

- (id)initSharedInstance {
    self = [super init];
    if (self) {
        // do something
        [self openDatabase];
    }
    return self;
}

- (NSString *) dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    NSString *databasePath = [[NSString alloc] initWithString: [dir stringByAppendingPathComponent: DBNAME]];
    return databasePath;
}

- (void) openDatabase {
    if(sqlite3_open([[self dataFilePath] UTF8String], &_database)!=SQLITE_OK){
        sqlite3_close(_database);
        NSLog(@"Faild to open database");
    }else{
        //Limit cache size
        if (sqlite3_exec(_database, "PRAGMA CACHE_SIZE=10;", NULL, NULL, NULL) != SQLITE_OK) {
            NSAssert1(0, @"Error: failed to set cache size with message '%s'.", sqlite3_errmsg(_database));
        }
        [self createTable:TABLE_NAME_PLAYLIST];
        [self createTable:TABLE_NAME_SONG];
    }
}

- (void) closeDatabase {
    //[self deleteOldHistory];
    sqlite3_close(_database);
}

- (void) createTable:(NSString*)tableName {
    char *errorMsg;
    NSString *createSQL = [[NSString alloc]initWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (_id INTEGER PRIMARY KEY, url TEXT, created int);", tableName];
    if(sqlite3_exec(_database, [createSQL UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){
        NSLog(@"Failed to create table: %@", tableName);
        sqlite3_close(_database);
    }else{
    }
}
/*
- (void)insertHistoryIfNotExist:(NSString*)url {
    int created = [self getCurrentUnixTime];
    int _id = [self returnMaximumId:TABLE_NAME_HISTORY];
        
    char *update = "INSERT OR REPLACE INTO history (_id, url, created) VALUES (?, ?, ?);";
    sqlite3_stmt *stmt;
    if(sqlite3_prepare_v2(_database, update, -1, &stmt, nil)==SQLITE_OK){
        sqlite3_bind_int(stmt, 1, _id);
        sqlite3_bind_text(stmt, 2, [url UTF8String], -1, NULL);
        sqlite3_bind_int(stmt, 3, created);
    }
    if(sqlite3_step(stmt) != SQLITE_DONE){
        NSLog(@"Failed to insert data");
    }else{
            
    }
    sqlite3_finalize(stmt);
}

- (BOOL) isInHistory:(NSString*)url {
    BOOL result = NO;
    NSString *query = [NSString stringWithFormat: @"SELECT _id FROM '%@' WHERE url = '%@' ORDER BY _id", TABLE_NAME_HISTORY, url];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            result = YES;
        }
    } else {
        NSLog(@"read failed");
    }
    
    sqlite3_finalize(statement);
    return result;
}

- (void)deleteOldHistory {
    int threshold = [self getCurrentUnixTime] - 604800; // 1 week
    char *errorMsg;
    NSString *strQuery = [[NSString alloc]initWithFormat:@"DELETE from '%@' WHERE created < %d", TABLE_NAME_HISTORY, threshold];
    
    if(sqlite3_exec(_database, [strQuery UTF8String], NULL, NULL, &errorMsg)!=SQLITE_OK){
        //sqlite3_close(database);
    }else{
    }
}
*/
- (int)returnMaximumId:(NSString*)tableName {
    int resultId = 0;
    NSMutableArray *idList = [NSMutableArray array];
    NSString *query = [NSString stringWithFormat: @"SELECT _id FROM '%@' ORDER BY _id", tableName];
    sqlite3_stmt *statement;
    if (sqlite3_prepare_v2(_database, [query UTF8String], -1, &statement, nil)==SQLITE_OK) {
        while (sqlite3_step(statement)==SQLITE_ROW) {
            resultId = sqlite3_column_int(statement, 0);
            [idList addObject:[[NSNumber numberWithUnsignedInt:resultId] stringValue]];
        }
    } else {
        NSLog(@"read failed");
    }
    
    sqlite3_finalize(statement);
    return resultId + 1;
}

- (int) getCurrentUnixTime {
    return (int)[[NSDate date] timeIntervalSince1970];
}

@end
