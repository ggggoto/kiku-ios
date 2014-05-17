//
//  TTDataSearchResult.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTData.h"

@protocol TTSongDataDelegate
-(void)loadedImage:(UIImage*)image;
@end

@interface TTSongData : TTData<NSCopying>

@property (nonatomic, strong) id<TTSongDataDelegate>delegate;
@property (nonatomic, strong) NSString* albumId;
@property (nonatomic, strong) NSString* albumName;
@property (nonatomic, strong) NSString* artistId;
@property (nonatomic, strong) NSString* artistName;
@property (nonatomic, strong) NSString* location;
@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, strong) NSString* lyric;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) UIImage* image;
@property (nonatomic, assign) bool isImageLoaded;

- (void)load:(NSDictionary*)content;
- (NSString*)toString;
- (void)setAlbumName:(NSString*)albumName;
- (void)setImageUrl:(NSString *)image;

@end
