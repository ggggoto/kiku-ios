//
//  TTDataSearchResult.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTDataSearchResult.h"

@implementation TTDataSearchResult

@synthesize content_id = _content_id;
@synthesize album_id = _album_id;
@synthesize album_name = _album_name;
@synthesize artist_id = _artist_id;
@synthesize artist_name = _artist_name;
@synthesize location = _location;
@synthesize logo = _logo;
@synthesize lyric = _lyric;
@synthesize name = _name;

- (void)load:(NSDictionary*)content {
    _content_id = [content objectForKey:@"id"];
    _album_id = [content objectForKey:@"album_id"];
    _album_name = [content objectForKey:@"album_name"];
    _artist_id = [content objectForKey:@"artist_id"];
    _artist_name = [content objectForKey:@"artist_name"];
    _location = [content objectForKey:@"location"];
    _logo = [content objectForKey:@"logo"];
    _lyric = [content objectForKey:@"lyric"];
    _name = [content objectForKey:@"name"];
}

- (NSString*) toString {
    return [NSString stringWithFormat:@"\nid: %@\n"
                             "album_id: %@\n"
                           "album_name: %@\n"
                            "artist_id: %@\n"
                          "artist_name: %@\n"
                             "location: %@\n"
                                 "logo: %@\n"
                                "lyric: %@\n"
                                 "name: %@",
                                    _content_id,
                                    _album_id,
                                    _album_name,
                                    _artist_id,
                                    _artist_name,
                                    _location,
                                    _logo,
                                    _lyric,
                                    _name];
}

@end
