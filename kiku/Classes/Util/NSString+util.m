//
//  NSString+urlescape.m
//  BlogCastARC
//
//  Created by 都筑 友昭 on 12/08/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSString+util.h"

@implementation NSString_util

+ (NSString*) getTime:(NSDate*)date {
    
    NSDate *currentTime = [NSDate date];
    NSTimeInterval since;
    since = [currentTime timeIntervalSinceDate:date];
    long intSince;
    
    NSString *postTimeFromNow;
    if(since <=60){
        intSince = (int)since;
        postTimeFromNow = [[NSString alloc]initWithFormat:@"%ldsec", intSince];
    }else if(since >= 60 && since <= 60*60){
        intSince = (int) since / 60;
        postTimeFromNow = [[NSString alloc]initWithFormat:@"%ldmin", intSince];
    }else if(since >= 60 * 60 && since <= 24*60*60){
        intSince = (int)since / (60 * 60);
        if(intSince == 1){
            postTimeFromNow = [[NSString alloc]initWithFormat:@"%ldhour", intSince];
        }else{
            postTimeFromNow = [[NSString alloc]initWithFormat:@"%ldhours", intSince];
        }
    }else if(since >= 24 * 60 * 60){
        intSince = (int)(since / (60 * 60 * 24));
        if(intSince == 1){
            postTimeFromNow = [[NSString alloc]initWithFormat:@"%ldday", intSince];
        }else{
            postTimeFromNow = [[NSString alloc]initWithFormat:@"%lddays", intSince];
        }
    }
    
    return postTimeFromNow;
}

+ (NSString*) removeBrTag:(NSString*)s {
    while ([s hasPrefix:@"<br />"]){
        s = [s substringFromIndex:6];
    }
    return s;
}

+ (NSDate*) stringToDate:(NSString*)s {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    return [inputFormatter dateFromString:s];
}
+ (NSString*)getFilePath:(NSString*)s {
    s = [s stringByReplacingOccurrencesOfString:@"?" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@":" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"/" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@";" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"=" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"." withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"#" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"-" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"_" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"%" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&" withString:@""];
    s = [NSTemporaryDirectory() stringByAppendingString:s];
    s = [s stringByAppendingString:@".html"];
    return s;
}

+ (NSString*)getImageFilePath:(NSString*)s {
    s = [s stringByReplacingOccurrencesOfString:@"?" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@":" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"/" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@";" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"=" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"." withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"#" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"-" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"_" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"%" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&" withString:@""];
    s = [NSTemporaryDirectory() stringByAppendingString:s];
    s = [s stringByAppendingString:@".png"];
    return s;
}

+ (NSString*)getMasterImageFilePath:(NSString*)s {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    documentsDirectory = [documentsDirectory stringByAppendingString:@"/"];
    s = [s stringByReplacingOccurrencesOfString:@"?" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@":" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"/" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@";" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"=" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"." withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"#" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"-" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"_" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"%" withString:@""];
    s = [s stringByReplacingOccurrencesOfString:@"&" withString:@""];
    s = [documentsDirectory stringByAppendingString:s];
    s = [s stringByAppendingString:@".png"];
    return s;
}


@end
