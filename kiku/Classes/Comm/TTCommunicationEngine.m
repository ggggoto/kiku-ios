//
//  TTCommunicationEngine.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTCommunicationEngine.h"
#import "AFJSONRequestOperation.h"
#import "TTDataSearchResult.h"

#define TIMEOUT 10

@implementation TTCommunicationEngine
@synthesize state = _state;
@synthesize type = _type;

-(id) init {
    self = [super init];
    _state = kCommAvaialble;
    _type = kRequestTypeNotClassified;
    return self;
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
                                             _state = kCommAvaialble;
                                         }
                                         failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
                                             [self errorOperation:error];
                                             _state = kCommAvaialble;
                                         }];
    [operation start];
    return true;
}

- (void) successOperation:(id)JSON withType:(TTCommunicationEngineRequestType) type {
    NSLog(@"%@", JSON);
    
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
            @throw @"process song data";
            break;
        case kRequestTypeAlbum:
            @throw @"process album data";
            break;
        case kRequestTypeArtistTop:
            @throw @"process artist top";
            break;
        default:
            break;
    }
}

- (void) processSearchResult:(id)JSON {
    NSArray *data = [JSON objectForKey:@"data"];
    for(NSDictionary *content in data){
        TTDataSearchResult *result = [[TTDataSearchResult alloc]init];
        [result load:content];
        NSLog([result toString]);
    }
}

- (void) errorOperation:(NSError*) error {
    NSLog(@"%@", error);
}

@end
