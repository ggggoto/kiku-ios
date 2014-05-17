//
//  TTFifo.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTSongData.h"

@interface TTFifo : NSObject

@property (nonatomic, strong) NSMutableArray *fifo;

- (void)put:(TTSongData*)songData;
- (TTSongData*)pick;
- (TTSongData*)peek;
- (NSMutableArray*)getReverseList;
- (void)flush;
- (bool)isEmpty;

@end
