//
//  TTQueue.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSongData.h"

@interface TTQueue : NSObject

@property (nonatomic, strong) NSMutableArray *queue;

- (void)enqueArray:(NSMutableArray*)array;
- (void)enque:(TTSongData*)songData;
- (void)putToFront:(TTSongData*)songData;
- (TTSongData*)deque;
- (TTSongData*)peek;
- (void)flush;
- (bool)isQueueEmpty;
- (bool)hasNext;

@end
