//
//  TTDataSearchResult.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTSongData.h"
#import "RMImageCachePool.h"

@implementation TTSongData

@synthesize delegate = _delegate;
@synthesize albumId = _albumId;
@synthesize albumName = _albumName;
@synthesize artistId = _artistId;
@synthesize artistName = _artistName;
@synthesize location = _location;
@synthesize imageUrl = _imageUrl;
@synthesize lyric = _lyric;
@synthesize name = _name;
@synthesize image = _image;
@synthesize isImageLoaded = _isImageLoaded;

- (id)init {
    self = [super init];
    return self;
}

- (void)load:(NSDictionary*)content {
    _albumId = [content objectForKey:@"album_id"];
    _albumName = [content objectForKey:@"album_name"];
    _artistId = [content objectForKey:@"artist_id"];
    _artistName = [content objectForKey:@"artist_name"];
    _location = [content objectForKey:@"location"];
    _imageUrl = [content objectForKey:@"logo"];
    _lyric = [content objectForKey:@"lyric"];
    _name = [content objectForKey:@"name"];
    _image = NULL;
    _isImageLoaded = false;
    
    [RMImageCachePool downloadImage:_imageUrl];
    [self tryLoadingImage];
}

- (void)tryLoadingImage {
    __block bool isLoaded = false;
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.f target:[NSBlockOperation blockOperationWithBlock:^{
        if (_isImageLoaded) {
            [timer invalidate];
        }
        UIImage *image = [RMImageCachePool returnImage:_imageUrl];
        if(image != NULL) {
            _image = image;
            isLoaded = true;
            [_delegate loadedImage:_image];
        }
    }] selector:@selector(main) userInfo:nil repeats:YES];
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
                                    _imageUrl,
                                    _lyric,
                                    _name];
}

- (void)setAlbumName:(NSString *)albumName {
    _albumName = albumName;
}

- (void)setImageUrl:(NSString *)image {
    _imageUrl = image;
}

- (id)copyWithZone:(NSZone*)zone {
    TTSongData *copy = [[[self class] allocWithZone:zone] init];
    if (copy) {
        copy->_albumId = [_albumId copyWithZone:zone];
        copy->_albumName = [_albumName copyWithZone:zone];
        copy->_artistId = [_artistId copyWithZone:zone];
        copy->_artistName = [_artistName copyWithZone:zone];
        copy->_location = [_location copyWithZone:zone];
        copy->_imageUrl = [_imageUrl copyWithZone:zone];
        copy->_lyric = [_lyric copyWithZone:zone];
        copy->_name = [_name copyWithZone:zone];
        copy->_image = [_image copy];
    }
    return copy;
}

@end
