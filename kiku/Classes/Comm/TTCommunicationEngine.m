//
//  TTCommunicationEngine.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTCommunicationEngine.h"
#import "AFJSONRequestOperation.h"
#import "TTSongData.h"
#import "Endpoints.h"
//#import "Macro.h"

#define TIMEOUT 10

@implementation TTCommunicationEngine

@synthesize delegate = _delegate;
@synthesize state = _state;
@synthesize type = _type;

-(id) init {
    self = [super init];
    _state = kCommAvaialble;
    _type = kRequestTypeNotClassified;
    return self;
}

- (bool) trySearch:(NSString*)word withPage:(int)page {
    NSString *encodedWord = [word stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *query = [[NSString alloc]initWithFormat:kSearchEndPoint, encodedWord, page];
    return [self tryEnqueRequest:query withType:kRequestTypeSearch];
}

- (bool) tryGetSong:(NSString*)songId {
    NSString *query = [[NSString alloc]initWithFormat:kSongEndPoint, songId];
    return [self tryEnqueRequest:query withType:kRequestTypeSong];
}

- (bool) tryGetAlbum:(NSString*)albumId {
    NSString *query = [[NSString alloc]initWithFormat:kAlbumEndPoint, albumId];
    return [self tryEnqueRequest:query withType:kRequestTypeAlbum];
}

- (bool) tryGetArtistTop:(NSString*)artistId {
    NSString *query = [[NSString alloc]initWithFormat:kArtistTopEndPoint, artistId];
    return [self tryEnqueRequest:query withType:kRequestTypeArtistTop];
}

- (bool) tryEnqueRequest:(NSString*)urlStr withType:(TTCommunicationEngineRequestType)type {
    if (_state != kCommAvaialble) {
        return false;
    }
    
    _type = type;
    _state = kCommBusy;
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:TIMEOUT];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request,
                                                   NSHTTPURLResponse *response,
                                                   id JSON) {
                                             [self successOperation:JSON withType:_type];
                                         }
                                         failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
                                             [self errorOperation:error];
                                         }];
    [operation start];
    return true;
}

- (void) errorOperation:(NSError*) error {
#ifdef DEBUG_OUT
    NSLog(@"%@", error);
#endif
    [_delegate errorReceived];
    _state = kCommAvaialble;
    _type = kRequestTypeNotClassified;
}

- (void) successOperation:(id)JSON withType:(TTCommunicationEngineRequestType) type {
    NSString *status = [JSON objectForKey:@"status"];
    if (![status isEqualToString:@"ok"]) {
        @throw @"status is not ok";
    }
    
    switch (type) {
        case kRequestTypeNotClassified:
            @throw @"type not clas";
            break;
        case kRequestTypeSearch:
            [self processSearchResult:JSON];
            break;
        case kRequestTypeSong:
            @throw @"song api process is not implemented";
            break;
        case kRequestTypeAlbum:
            [self processAlbumResult:JSON];
            break;
        case kRequestTypeArtistTop:
            NSLog(@"process artist top data");
            break;
        default:
            break;
    }

    _state = kCommAvaialble;
    _type = kRequestTypeNotClassified;
}

- (void) processSearchResult:(id)JSON {
    NSMutableArray* result = [NSMutableArray array];
    NSArray *data = [JSON objectForKey:@"data"];
    for(NSDictionary *content in data){
        TTSongData *songData = [[TTSongData alloc]init];
        [songData load:content];
        [result addObject:songData];
#ifdef DEBUG_OUT
        NSLog(@"%@", [songData toString]);
#endif
    }
    [_delegate recievedSongData:result];
}

- (void) processAlbumResult:(id)JSON {
    NSMutableArray* result = [NSMutableArray array];
    NSDictionary *albumData = [JSON objectForKey:@"album"];
    NSString *albumName = [albumData objectForKey:@"title"];
    NSString *image = [albumData objectForKey:@"album_logo"];
    NSDictionary *songData = [albumData objectForKey:@"songs"];
    for(NSDictionary *content in songData){
        TTSongData *songData = [[TTSongData alloc]init];
        [songData load:content];
        [songData setAlbumName:albumName];
        [songData setImageUrl:image];
        [result addObject:songData];
#ifdef DEBUG_OUT
        NSLog(@"%@", [songData toString]);
#endif
    }
    [_delegate recievedSongData:result];
}

@end
