//
//  TTListContentView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/26.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTListContentView.h"
#import "RMLoadingCommon.h"
#import "TTMasterData.h"

#define kThumbnailSize 60
#define kThumbnailGap 6
#define kPlayButtonSize 10

@implementation TTListContentView

@synthesize thumbnail = _thumbnail;
@synthesize artistName = _artistName;
@synthesize title = _title;
@synthesize playButton = _playButton;

- (id)initWithFrame:(CGRect)frame withSongData:(TTSongData*)songData {
    self = [super initWithFrame:frame];
    if (self) {
        [songData setDelegate:self];
        // Initialization code
        [self initializeViews:songData];
        [self setAlpha:0.f];
    }
    return self;
}

- (void)initializeViews:(TTSongData*)songData {
    _thumbnail = [[UIImageView alloc]initWithFrame:CGRectMake(kThumbnailGap, kThumbnailGap, kThumbnailSize, kThumbnailSize)];
    if (songData.image != NULL) {
        [_thumbnail setImage:songData.image];
    } else {
        _loadingCommon = [[RMLoadingCommon alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _loadingCommon.center = CGPointMake(kThumbnailSize / 2, kThumbnailSize / 2);
        [_thumbnail addSubview:_loadingCommon];
    }
    [self addSubview:_thumbnail];
    
    _artistName = [[UILabel alloc]initWithFrame:CGRectMake(kThumbnailGap + kThumbnailSize + kThumbnailGap,
                                                           kThumbnailGap,
                                                           SCREEN_FRAME.size.width - (kThumbnailGap * 2) - kThumbnailSize - kPlayButtonSize,
                                                           kThumbnailSize / 2)];
    [_artistName setFont:[UIFont fontWithName:kFontHirakaku size:12]];
    [_artistName setText:songData.artistName];
    [self addSubview:_artistName];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(kThumbnailGap + kThumbnailSize + kThumbnailGap,
                                                      kThumbnailGap + kThumbnailSize / 2,
                                                      SCREEN_FRAME.size.width - (kThumbnailGap * 2) - kThumbnailSize - kPlayButtonSize,
                                                      kThumbnailSize / 2)];
    [_title setFont:[UIFont fontWithName:kFontHirakaku size:12]];
    [_title setText:songData.name];
    [self addSubview:_title];
    
    UIImage *image = [UIImage imageNamed:kResourceListPlayButton];
    _playButton = [[UIImageView alloc]initWithFrame:CGRectMake(0,
                                                               0,
                                                               image.size.width / 2,
                                                               image.size.height / 2)];
    [_playButton setImage:image];
    [_playButton setCenter:CGPointMake(SCREEN_FRAME.size.width - image.size.width, kListHeight / 2)];
    [self addSubview:_playButton];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(kThumbnailGap, kListHeight, SCREEN_FRAME.size.width - kThumbnailGap * 2, 1)];
    [line setBackgroundColor:[[TTMasterData sharedInstance].color objectForKey:COLOR_LIST_SEPARATION]];
    [self addSubview:line];
}

- (void)loadedImage:(UIImage *)image {
    if (image != NULL) {
        [_thumbnail setImage:image];
        for (UIView *loading in [_thumbnail subviews]) {
            if (loading == _loadingCommon) {
                [loading removeFromSuperview];
            }
        }
    }
}

- (void)showAnimation {
    CGPoint point = self.center;
    self.center = CGPointMake(point.x, point.y - 30);
    [UIView animateWithDuration:kAnimDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.center = CGPointMake(point.x, point.y + 10);
                     }
                     completion:^(BOOL finished){
                         //Completion
                         [UIView animateWithDuration:kAnimDuration
                                               delay:0.0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              //Animation
                                              self.alpha = 1.0;
                                              self.center = CGPointMake(point.x, point.y);
                                          }
                                          completion:^(BOOL finished){
                                          }];
                     }];
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
