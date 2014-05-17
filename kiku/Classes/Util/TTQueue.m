//
//  TTQueue.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTQueue.h"

@implementation TTQueue

- (id)init {
    self = [super init];
    _queue = [NSMutableArray array];
    return self;
}

- (void)enqueArray:(NSMutableArray*)array {
    for (TTSongData* songData in array) {
        [self enque:songData];
    }
}

- (void)enque:(TTSongData *)songData {
    [_queue addObject:songData];
}

- (void)putToFront:(TTSongData *)songData {
    [_queue insertObject:songData atIndex:0];
}

- (TTSongData*)deque {
    if ([_queue count] == 0) {
        return NULL;
    }
    TTSongData* songData = [_queue objectAtIndex:0];
    [_queue removeObjectAtIndex:0];
    return songData;
}

- (TTSongData*)peek {
    if ([_queue count] == 0) {
        return NULL;
    }
    return [_queue objectAtIndex:0];
}

- (void)flush {
    [_queue removeAllObjects];
}

- (bool)isQueueEmpty {
    return [_queue count] == 0;
}

- (bool)hasNext {
    return [_queue objectAtIndex:0] != NULL;
}

@end
