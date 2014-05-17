//
//  TTCommunicationEngine.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@property (nonatomic, assign) TTCommunicationEngineState state;
@property (nonatomic, assign) TTCommunicationEngineRequestType type;

- (bool) tryEnqueRequest:(NSString*)urlStr withType:(TTCommunicationEngineRequestType)type;

@end
