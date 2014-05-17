//
//  TTDataSearchResult.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTData.h"

@interface TTSongData : TTData<NSCopying>

@property (nonatomic, strong) NSString* albumId;
@property (nonatomic, strong) NSString* albumName;
@property (nonatomic, strong) NSString* artistId;
@property (nonatomic, strong) NSString* artistName;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* image;
@property (nonatomic, strong) NSString* lyric;
@property (nonatomic, strong) NSString* name;

- (void)load:(NSDictionary*)content;
- (NSString*)toString;
- (void)setAlbumName:(NSString*)albumName;
- (void)setImage:(NSString *)image;

@end
