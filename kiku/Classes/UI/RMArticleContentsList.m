//
//  RMArticleContentsList.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/11.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMArticleContentsList.h"
#import "RMLabel.h"
#import "NSString+util.h"
#import "RMImageCachePool.h"
#import "ViewConstants.h"
#import "RMLoadingCommon.h"

#define LOADING_IMAGE_TAG 1000
#define PLACE_HOLDER_IMG @"list_blank.png"

@implementation RMArticleContentsList

- (id)initWithFrame:(CGRect)frame withEntry:(TTSongData *)entry {
    self = [super initWithFrame:frame withBlurLevel:0];
    if (self) {
        // Initialization code
        [self.originalImageView setFrame:CGRectMake(0, 0, SLIST_IMAGE_WIDTH, SLIST_IMAGE_HEIGHT)];
        [self.originalImageView setContentMode:UIViewContentModeRedraw];
        [self.bgView setBackgroundColor:[UIColor grayColor]];
        
        self.entry = entry;
        
        if (![self.entry.imageUrl isEqualToString:NOIMAGE]) {
            RMLoadingCommon *loading = [[RMLoadingCommon alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            loading.center = CGPointMake(SLIST_IMAGE_WIDTH / 2, SLIST_IMAGE_HEIGHT / 2);
            loading.tag = LOADING_IMAGE_TAG;
            [self addSubview:loading];
            
            [RMImageCachePool downloadImage:self.entry.imageUrl];
            [self tryLoadingImage];
        } else {
            [self.originalImageView setBackgroundColor:[UIColor whiteColor]];
            [self setOriginalImage:[UIImage imageNamed:PLACE_HOLDER_IMG]];
        }
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.entry.name];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.entry.name length])];
        
        RMLabel *labelView = [[RMLabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + SLIST_IMAGE_WIDTH + 8,
                                                                       self.bounds.origin.y + self.bounds.size.height - 62,
                                                                       self.bounds.size.width - 85,
                                                                       45)];
        [labelView setNumberOfLines:2];
        [labelView setTextAlignment:NSTextAlignmentCenter];
        [labelView setBackgroundColor:[UIColor clearColor]];
        [labelView setTextColor:[UIColor blackColor]];
        [labelView setFont:[UIFont fontWithName:HIRAKAKU size:14]];
        [labelView setAttributedText:attributedString];
        [labelView setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:labelView];
        
        NSString *postedTime = self.entry.albumName; //TODO Rename
        UILabel *timeLabelView = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + SLIST_IMAGE_WIDTH + 20,
                                                                           self.bounds.origin.y + self.bounds.size.height - 24.5,
                                                                           120,
                                                                           20)];
        [timeLabelView setFont:[UIFont fontWithName:HIRAKAKU size:10]];
        [timeLabelView setText:postedTime];
        [self addSubview:timeLabelView];
        
        [self.bgView setAlpha:0];
        [self setAlpha:0];
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
