//
//  TTDataSearchResult.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTData.h"

@interface TTDataSearchResult : TTData

@property (nonatomic, strong) NSString* content_id;
@property (nonatomic, strong) NSString* album_id;
@property (nonatomic, strong) NSString* album_name;
@property (nonatomic, strong) NSString* artist_id;
@property (nonatomic, strong) NSString* artist_name;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* logo;
@property (nonatomic, strong) NSString* lyric;
@property (nonatomic, strong) NSString* name;

- (void)load:(NSDictionary*)content;
- (NSString*)toString;

@end
