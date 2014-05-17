//
//  RMImageCachePool.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/10.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMImageCachePool.h"
#import "NSString+util.h"

@implementation RMImageCachePool

static NSMutableDictionary *imageDictionary;

+ (UIImage*)returnImage:(NSString*)key {
    if ([[imageDictionary allKeys] containsObject:key]) {
        return [imageDictionary objectForKey:key];
    }
    return NULL;
}

+ (void)removeImage:(NSString*)key {
    /*if ([[imageDictionary allKeys] containsObject:key]) {
        [imageDictionary removeObjectForKey:key];
    }*/
}

+ (void)downloadImage:(NSString*)url {
    if (imageDictionary == NULL) {
        imageDictionary = [[NSMutableDictionary alloc]init];
    }
    [self downloadImageWithURL:[NSURL URLWithString:url] completionBlock:^(BOOL succeeded, UIImage *image) {
        if (succeeded) {
            if (image != nil) {
                [imageDictionary setObject:image forKey:url];
                dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
                dispatch_async(globalQueue, ^{
                    NSData *data = UIImagePNGRepresentation(image);
                    NSString *filePath = [NSString_util getImageFilePath:url];
                    if(![data writeToFile:filePath atomically:YES]) {
                        NSLog(@"failed to save image: %@", url);
                    }
                });
            }
        }
    }];
}

+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

@end
