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

- (void) readJson {
    NSString *apiUrl = @"http://api.xiami.com/app/android/search-part?key=Kiroro&type=songs&page=1";
    NSString *apiUrl2 =@"http://api.xiami.com/app/android/search-part?key=Atomic&type=albums&page=1";
    NSURL *url = [NSURL URLWithString:apiUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:TIMEOUT];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
                                         JSONRequestOperationWithRequest:request
                                         success:^(NSURLRequest *request,
                                                   NSHTTPURLResponse *response,
                                                   id JSON) {
                                             [self successOperation:JSON];
                                         }
                                         failure:^(NSURLRequest *request , NSURLResponse *response , NSError *error , id JSON) {
                                             [self errorOperation:error];
                                         }];
    [operation start];
}

- (void) successOperation:(id)JSON {
    NSLog(@"%@", JSON);
    
    NSString *status = [JSON objectForKey:@"status"];
    if (![status isEqualToString:@"ok"]) {
        @throw @"status is not ok";
    }
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
