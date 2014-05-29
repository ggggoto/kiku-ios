//
//  TTUserData.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSongData.h"

@interface TTUserData : NSObject

+ (TTUserData*)sharedInstance;

@property (nonatomic, strong) NSString* currentWord;
@property (nonatomic, assign) int page;
@property (nonatomic, strong) NSMutableArray *songs;

- (void)setNewWord:(NSString*)word;
- (void)addSongsToArray:(NSArray*)data;
- (void)appendSongsToArray:(TTSongData*)data;
- (void)clearSongs;

@end
