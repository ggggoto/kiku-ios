//
//  NSString+urlescape.h
//  BlogCastARC
//
//  Created by 都筑 友昭 on 12/08/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString_util : NSString

+ (NSString*) getTime:(NSDate*)date;
+ (NSDate*) stringToDate:(NSString*)s;
+ (NSString*) removeBrTag:(NSString*)s;
+ (NSString*)getFilePath:(NSString*)s;
+ (NSString*)getImageFilePath:(NSString*)s;
+ (NSString*)getMasterImageFilePath:(NSString*)s;

@end
