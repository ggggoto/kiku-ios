//
//  TTFifo.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTFifo.h"

@implementation TTFifo

@synthesize fifo = _fifo;

- (id)init {
    self = [super init];
    _fifo = [NSMutableArray array];
    return self;
}

- (void)put:(TTSongData*)songData {
    [_fifo insertObject:songData atIndex:0];
}

- (TTSongData*)pick {
    if ([_fifo count] == 0) {
        return NULL;
    }
    TTSongData *songData = [[_fifo objectAtIndex:0] copy];
    [_fifo removeObjectAtIndex:0];
    return songData;
}

- (TTSongData*)peek {
    if ([_fifo count] == 0) {
        return NULL;
    }
    return [_fifo objectAtIndex:0];
}

- (NSMutableArray*)getReverseList {
    NSMutableArray *result= [NSMutableArray array];
    for (TTSongData* songData in [_fifo reverseObjectEnumerator])
    {
        [result addObject:songData];
    }
    return result;
}

- (void)flush {
    [_fifo removeAllObjects];
}

- (bool)isEmpty {
    return [_fifo count] == 0;
}

@end
