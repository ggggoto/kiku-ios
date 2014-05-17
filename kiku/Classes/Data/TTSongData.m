//
//  TTDataSearchResult.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTSongData.h"

@implementation TTSongData

@synthesize albumId = _albumId;
@synthesize albumName = _albumName;
@synthesize artistId = _artistId;
@synthesize artistName = _artistName;
@synthesize location = _location;
@synthesize image = _image;
@synthesize lyric = _lyric;
@synthesize name = _name;

- (void)load:(NSDictionary*)content {
    _albumId = [content objectForKey:@"album_id"];
    _albumName = [content objectForKey:@"album_name"];
    _artistId = [content objectForKey:@"artist_id"];
    _artistName = [content objectForKey:@"artist_name"];
    _location = [content objectForKey:@"location"];
    _image = [content objectForKey:@"logo"];
    _lyric = [content objectForKey:@"lyric"];
    _name = [content objectForKey:@"name"];
}

- (NSString*) toString {
    return [NSString stringWithFormat:@"\nalbum_id: %@\n"
                           "album_name: %@\n"
                            "artist_id: %@\n"
                          "artist_name: %@\n"
                             "location: %@\n"
                                "image: %@\n"
                                "lyric: %@\n"
                                 "name: %@",
                                    _albumId,
                                    _albumName,
                                    _artistId,
                                    _artistName,
                                    _location,
                                    _image,
                                    _lyric,
                                    _name];
}

- (void)setAlbumName:(NSString *)albumName {
    _albumName = albumName;
}

- (void)setImage:(NSString *)image {
    _image = image;
}

- (id)copyWithZone:(NSZone*)zone {
    TTSongData *copy = [[[self class] allocWithZone:zone] init];
    if (copy) {
        copy->_albumId = [_albumId copyWithZone:zone];
        copy->_albumName = [_albumName copyWithZone:zone];
        copy->_artistId = [_artistId copyWithZone:zone];
        copy->_artistName = [_artistName copyWithZone:zone];
        copy->_location = [_location copyWithZone:zone];
        copy->_image = [_image copyWithZone:zone];
        copy->_lyric = [_lyric copyWithZone:zone];
        copy->_name = [_name copyWithZone:zone];
    }
    return copy;
}

@end
