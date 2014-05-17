//
//  TTCommunicationEngine.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TTCommunicationEngineDelegate
-(void)recievedSongData:(NSMutableArray*)data;
@end

@interface TTCommunicationEngine : NSObject

typedef enum {
    kCommAvaialble,
    kCommBusy,
} TTCommunicationEngineState;

typedef enum {
    kRequestTypeNotClassified,
    kRequestTypeSearch,
    kRequestTypeSong,
    kRequestTypeAlbum,
    kRequestTypeArtistTop,
} TTCommunicationEngineRequestType;

@property (nonatomic, strong) id<TTCommunicationEngineDelegate> delegate;
@property (nonatomic, assign) TTCommunicationEngineState state;
@property (nonatomic, assign) TTCommunicationEngineRequestType type;

- (bool) trySearch:(NSString*)word withPage:(int)page;
- (bool) tryGetSong:(NSString*)songId;
- (bool) tryGetAlbum:(NSString*)albumId;
- (bool) tryGetArtistTop:(NSString*)artistId;

@end
