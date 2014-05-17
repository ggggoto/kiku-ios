//
//  RMImageCachePool.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/10.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMImageCachePool : NSObject

+ (UIImage*)returnImage:(NSString*)key;
+ (void)removeImage:(NSString*)key;
+ (void)downloadImage:(NSString*)url;

@end
