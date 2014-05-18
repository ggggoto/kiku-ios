//
//  RMArticleContentsLarge.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/09.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMArticleContentsLarge.h"
#import "RMLabel.h"
#import "ViewConstants.h"
#import "RMImageCachePool.h"
#import "NSString+util.h"
#import "RMLoadingCommon.h"
#import "TTSongData.h"

#define LOADING_IMAGE_TAG 1000
#define ICON_TAG 1001
#define PLACE_HOLDER_IMG @"list_blankL.png"

@implementation RMArticleContentsLarge

@synthesize iconView = _iconView;
@synthesize delegate = _delegate;
@synthesize entry = _entry;

- (id)initWithFrame:(CGRect)frame withEntry:(TTSongData*)entry{
    self = [super initWithFrame:frame withBlurLevel:0];
    if (self) {
        // Initialization code
        [self.originalImageView setFrame:CGRectMake(0, 0, LLIST_IMAGE_WIDTH, LLIST_IMAGE_HEIGHT)];
        [self.originalImageView setContentMode:UIViewContentModeRedraw];
        [self.bgView setBackgroundColor:[UIColor grayColor]];
        
        _entry = entry;
        
        if (![_entry.imageUrl isEqualToString:NOIMAGE]) {
            RMLoadingCommon *loading = [[RMLoadingCommon alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
            loading.center = CGPointMake(LLIST_IMAGE_WIDTH / 2, LLIST_IMAGE_HEIGHT / 2);
            loading.tag = LOADING_IMAGE_TAG;
            [self addSubview:loading];
            
            [RMImageCachePool downloadImage:_entry.imageUrl];
            [self tryLoadingImage];
        } else {
            [self.originalImageView setBackgroundColor:[UIColor whiteColor]];
            [self setOriginalImage:[UIImage imageNamed:PLACE_HOLDER_IMG]];
        }
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:_entry.name];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:4];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [_entry.name length])];
        
        RMLabel *labelView = [[RMLabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 4,
                                                                       self.bounds.origin.y + self.bounds.size.height - 50,
                                                                       self.bounds.size.width - 8,
                                                                       35)];
        [labelView setBackgroundColor:[UIColor clearColor]];
        [labelView setNumberOfLines:2];
        [labelView setTextAlignment:NSTextAlignmentCenter];
        [labelView setTextColor:[UIColor blackColor]];
        [labelView setFont:[UIFont fontWithName:HIRAKAKU size:12]];
        [labelView setAttributedText:attributedString];
        [labelView setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:labelView];
        
        NSString *postedTime = _entry.albumName; //TODO Rename
        UILabel *timeLabelView = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.origin.x + 15,
                                                                           self.bounds.origin.y + self.bounds.size.height - 22.5,
                                                                           120,
                                                                           20)];
        [timeLabelView setFont:[UIFont fontWithName:HIRAKAKU size:10]];
        [timeLabelView setText:postedTime];
        [self addSubview:timeLabelView];

        [self.bgView setAlpha:0];
        [self setAlpha:0.3];
        
    }
    return self;
}

- (void)showAnimation {
    float alpha1 = 0.8f;
    float alpha2 = 1.0f;

    CGPoint point = self.center;
    self.bgView.alpha = 0;
    self.alpha = 0.3;
    self.center = CGPointMake(point.x, point.y - 30);
    [UIView animateWithDuration:kAnimDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.bgView.alpha = alpha1;
                         self.alpha = alpha1;
                         self.center = CGPointMake(point.x, point.y + 10);
                     }
                     completion:^(BOOL finished){
                         //Completion
                         [UIView animateWithDuration:kAnimDuration
                                               delay:0.0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              //Animation
                                              self.bgView.alpha = alpha2;
                                              self.alpha = alpha2;
                                              self.center = CGPointMake(point.x, point.y);
                                          }
                                          completion:^(BOOL finished){
                                          }];
                     }];
}

- (void)hideAnimation {
    
}

- (void)singleTapAction {
    [UIView animateWithDuration:kAnimDuration / 3
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.bgView.alpha = 0.5f;
                     }
                     completion:^(BOOL finished){
                         //Completion
                         self.bgView.alpha = 1.0f;
                     }];
}

- (void)tryLoadingImage {
    __block bool isLoaded = false;
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2f target:[NSBlockOperation blockOperationWithBlock:^{
        if (isLoaded) {
            [timer invalidate];
        }
        UIImage *image = [RMImageCachePool returnImage:_entry.imageUrl];
        if(image != NULL) {
            [self setOriginalImage:image];
            isLoaded = true;
            [RMImageCachePool removeImage:_entry.imageUrl];
            for (UIView *view in [self subviews]) {
                if (view.tag == LOADING_IMAGE_TAG) {
                    [view removeFromSuperview];
                }
            }
        }
    }] selector:@selector(main) userInfo:nil repeats:YES];
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
