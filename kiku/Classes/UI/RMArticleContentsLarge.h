//
//  RMArticleContentsLarge.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/09.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMViewBase.h"
#import "TTSongData.h"

@protocol RMArticleContentsDelegate
- (void) songSelected:(NSString*)urlStr;
@end

@interface RMArticleContentsLarge : RMViewBase

- (id)initWithFrame:(CGRect)frame withEntry:(TTSongData*)entry;
- (void)showAnimation;
- (void)hideAnimation;
- (void)singleTapAction;
- (void)tryLoadingImage;

@property (nonatomic, strong) id<RMArticleContentsDelegate> delegate;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) TTSongData *entry;

@end