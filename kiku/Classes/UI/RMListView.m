//
//  RMListView.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/11.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMListView.h"
#import "ViewConstants.h"
#import "RMArticleContentsLarge.h"
#import "RMArticleContentsList.h"
#import "TTSongData.h"
#import "RMLoadingAnimation.h"
#import "FXBlurView.h"
#import "RMLoadingAnimation2.h"
#import "RMRefreshLoadingAnimation.h"

#define LOAD_ICON_TAG 1000
#define LOAD_ANIM_TAG 1001

#define AUTOLOAD_OFFSET 300

@implementation RMListView

@synthesize delegate = _delegate;
@synthesize array = _array;
@synthesize sv = _sv;
@synthesize bg = _bg;
@synthesize autoLoadAnim = _autoLoadAnim;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame withBlurLevel:0];
    if (self) {
        _sv = [[UIScrollView alloc] initWithFrame:CGRectMake(self.bounds.origin.x,
                                                             self.bounds.origin.y,
                                                             self.bounds.size.width,
                                                             SCREEN_FRAME.size.height + STATUS_BAR_HEIGHT)];
        _sv.delegate = self;
        [self setContentHeight:SCREEN_FRAME.size.height + STATUS_BAR_HEIGHT + 1];
        [_sv setBackgroundColor:[UIColor clearColor]];
        
        _autoLoadAnim = [[RMLoadingAnimation2 alloc]initWithFrame:CGRectMake(frame.size.width / 2 - 11,
                                                                             frame.size.height - 20.f,
                                                                             22.0f,
                                                                             22.0f)];
        [_autoLoadAnim setAlpha:0];
        
        [self addSubview:_autoLoadAnim];
        [self addSubview:_sv];
        
        _array = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)changeBackground {
    //[self changeBackGround:[[RMMasterData sharedInstance].listBg objectAtIndex:[RMUserData sharedInstance].channel_tag]];
}

- (void)changeBackGround:(NSString *)imageName {
    if (_bg != NULL) {
        [_bg removeFromSuperview];
        _bg = NULL;
    }
    _bg = [[RMViewBase alloc]initWithFrame:CGRectMake(0, 0, SCREEN_FRAME.size.width, SCREEN_FRAME.size.height + STATUS_BAR_HEIGHT) withBlurLevel:0.9f];
    [_bg setBackgroundColor:[UIColor clearColor]];
    UIImage *image = [UIImage imageNamed:imageName];
    [_bg setOriginalImage:image];
    [self addSubview:_bg];
}

- (void)makeBackgroundBlur {
     [_bg makeBlur:[UIColor clearColor] withBlurLevel:5.0f];
}

- (void)removeLoadinAnimation {
    for (UIView *subview in [self subviews]) {
        if (subview.tag == LOAD_ICON_TAG || subview.tag == LOAD_ANIM_TAG) {
            [subview removeFromSuperview];
        }
    }
}

- (void)recieveContentsArray:(NSArray*)songs {
    for (TTSongData *song in songs) {
        [self addContents:song];
    }
    [self removeLoadinAnimation];
    [self makeBackgroundBlur];
}

- (void)recieveErrorGettingContents {
    [self removeLoadinAnimation];
    [self makeBackgroundBlur];
}

- (void)addContents:(TTSongData*) entry {
    int index = (int)[_array count];
    if (index < 2) {
        RMArticleContentsLarge *contents = [[RMArticleContentsLarge alloc]
                                            initWithFrame:CGRectMake(MARGIN_LEFT + (LCONTENT_WIDTH + MARGIN_BETWEEN) * index,
                                                                     MARGIN_TOP_OFFSET,
                                                                     LCONTENT_WIDTH,
                                                                     LCONTENT_HEIGHT)
                                            withEntry:entry];
        contents.delegate = self;
        [_sv addSubview:contents];
        
        // Show animation
        [NSTimer scheduledTimerWithTimeInterval:0 target:[NSBlockOperation blockOperationWithBlock:^{
            [contents showAnimation];
        }] selector:@selector(main) userInfo:nil repeats:NO];
        
    } else {
        RMArticleContentsList *contents = [[RMArticleContentsList alloc]
                                           initWithFrame:CGRectMake(MARGIN_LEFT ,
                                                                    MARGIN_TOP_LIST_OFFSET + (SCONTENT_HEIGHT + MARGIN_BETWEEN) * (index - 2),
                                                                    SCONTENT_WIDTH,
                                                                    SCONTENT_HEIGHT)
                                           withEntry:entry];
        contents.delegate = self;
        [_sv addSubview:contents];
        _sv.delegate = self;
        
        // Animation wait time. Initial 10 article has animation wait time
        float waitTime = 0;
        if ([_array count] <= 9) {
            waitTime = index * 0.075;
        }
        
        [NSTimer scheduledTimerWithTimeInterval:waitTime target:[NSBlockOperation blockOperationWithBlock:^{
            [contents showAnimation];
        }] selector:@selector(main) userInfo:nil repeats:NO];
    }
    [_array addObject:entry];
}

- (void)showAnimationFinished {
    if ([_array count] % 10 == 0) {
        [self setHeight];
    }
}

- (void)setHeight {
    [self setContentHeight:MARGIN_TOP_LIST_OFFSET + (SCONTENT_HEIGHT + MARGIN_BETWEEN) * ([_array count] - 2)];
}

- (void)clearList {
    [_sv scrollsToTop];
    for (UIView *view in [_sv subviews]) {
        if (!(view == _sv || view == _bg)) {
            [view removeFromSuperview];
        }
    }
    [_array removeAllObjects];
    // disable scroll
    [_sv setContentSize:CGSizeMake(self.bounds.size.width, 0)];
    _sv.scrollEnabled = YES;
    _sv.userInteractionEnabled = YES;
}

- (void)setContentHeight:(float)height {
    [UIView animateWithDuration:.3f animations:^ {
        [_sv setContentSize:CGSizeMake(self.bounds.size.width, height)];
    }completion:^(BOOL finished){
        if (finished) {
            // enable scroll
            _sv.userInteractionEnabled = YES;
            _sv.scrollEnabled = YES;
        }
    }];
}

- (void) loadAnimation {
    [self removeLoadinAnimation];
    [self changeBackground];

    //TODO loading image
    /*
    UIImage *image = [UIImage imageNamed:[[RMMasterData sharedInstance].iconLoad objectAtIndex:[RMUserData sharedInstance].channel_tag]];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [iv setBackgroundColor:[UIColor clearColor]];
    iv.frame = CGRectMake(0, 0, image.size.width / 2, image.size.height / 2);
    iv.center = CGPointMake(SCREEN_FRAME.size.width / 2, SCREEN_FRAME.size.height / 2);
    iv.tag = LOAD_ICON_TAG;
    [self addSubview:iv];
    */
    
    RMLoadingAnimation *loadingAnimation = [[RMLoadingAnimation alloc]initWithFrame:CGRectMake(0, 0, 43, 10)];
    loadingAnimation.center = CGPointMake(SCREEN_FRAME.size.width / 2, SCREEN_FRAME.size.height / 2);
    
    loadingAnimation.tag = LOAD_ANIM_TAG;
    [self addSubview:loadingAnimation];
}

#pragma mark article contents delegate
- (void)songSelected:(NSString *)urlStr {
    [_delegate songSelected:urlStr];
}

#pragma mark scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(_sv.contentOffset.y >= (_sv.contentSize.height - _sv.bounds.size.height) - AUTOLOAD_OFFSET) {
        [_delegate scrollViewReachedThreshold];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
}

- (void)setAutoLoadAnimation {
    [_autoLoadAnim showAnimation];
}

- (void)unsetAutoLoadAnimation {
    [_autoLoadAnim hideAnimation];
}

@end
