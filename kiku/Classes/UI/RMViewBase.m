//
//  RMViewBase.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/06.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMViewBase.h"
#import "FXBlurView.h"
#import "ViewConstants.h"
#import <Accelerate/Accelerate.h>

@implementation RMViewBase

@synthesize originalImage = _originalImage;
@synthesize originalImageView = _originalImageView;
@synthesize backgroundImageView = _backgroundImageView;
@synthesize initialBlurLevel = _initialBlurLevel;
@synthesize backgroundGlassView = _backgroundGlassView;
@synthesize initialGlassLevel = _initialGlassLevel;
@synthesize isGlassEffectOn = _isGlassEffectOn;
@synthesize glassColor = _glassColor;
@synthesize imageTag = _imageTag;
@synthesize blurLayer = _blurLayer;
@synthesize singleFingerTap = _singleFingerTap;
@synthesize bgView = _bgView;

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withBlurLevel:0];
}

- (id)initWithFrame:(CGRect)frame withBlurLevel:(float)blurLevel {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        // Initialization code
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [_bgView setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_bgView];
        
        _initialBlurLevel = (blurLevel == 0) ? 0.1 : blurLevel;
        _initialGlassLevel = kDKBlurredBackgroundDefaultGlassLevel;
        _glassColor = kDKBlurredBackgroundDefaultGlassColor;
        
        _originalImageView = [[UIImageView alloc] initWithFrame: self.bounds];
        _originalImageView.alpha = 1.0;
        
        _backgroundImageView = [[UIImageView alloc] initWithFrame: self.bounds];
        _backgroundImageView.alpha = 0.0;
        _backgroundImageView.contentMode = UIViewContentModeScaleToFill;
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        _backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        _backgroundGlassView = [[UIView alloc] initWithFrame: self.bounds];
        _backgroundGlassView.alpha = 0.0;
        _backgroundGlassView.backgroundColor = kDKBlurredBackgroundDefaultGlassColor;
        _backgroundGlassView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:_originalImageView];
        [self addSubview: _backgroundImageView];
        [self addSubview: _backgroundGlassView];
        
        _singleFingerTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                action:@selector(handleSingleTap)];
        [self addGestureRecognizer:_singleFingerTap];
        
    }
    return self;
}

- (void)setGlassColor:(UIColor *)glassColor {
    _glassColor = glassColor;
    _backgroundGlassView.backgroundColor = glassColor;
}

- (void)setOriginalImage:(UIImage *)originalImage {
    _originalImage = originalImage;
    _originalImageView.image = originalImage;
}

// Override
- (void)blurFinish {
}

// Override
- (void)clearFinish {
    if (_blurLayer != NULL) {
        [_blurLayer removeFromSuperview];
        _blurLayer = NULL;
    }
}

//TODO: Control duration to become blur
- (void)makeBlur:(UIColor*)color withBlurLevel:(float)blurLevel {
    if (_blurLayer == NULL) {
        _blurLayer = [[FXBlurView alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.frame.size.width, self.frame.size.height)];
        [_blurLayer setBackgroundColor:[UIColor clearColor]];
        [self addSubview:_blurLayer];
        _blurLayer.blurRadius = blurLevel;
        _blurLayer.alpha = 0.0;
        _blurLayer.tintColor = color;
        _blurLayer.dynamic = NO;
    }
    
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[NSBlockOperation blockOperationWithBlock:^{
        _blurLayer.alpha += 0.2;
        if (_blurLayer.alpha >= 1.0) {
            [timer invalidate];
            [self blurFinish];
        }
    }] selector:@selector(main) userInfo:nil repeats:YES];
}

//TODO: Control duration to become clear
- (void)makeClear {
    if (_blurLayer != NULL) {
        __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[NSBlockOperation blockOperationWithBlock:^{
            _blurLayer.alpha -= 0.2;
            if (_blurLayer.alpha <= 0.0) {
                [timer invalidate];
                [self clearFinish];
            }
        }] selector:@selector(main) userInfo:nil repeats:YES];
    }
}

#pragma mark blur
- (void)originalBlur {
    __block NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:[NSBlockOperation blockOperationWithBlock:^{
        _blurLayer.alpha += 0.2;
        if (_blurLayer.alpha >= 1.0) {
            [timer invalidate];
            [self blurFinish];
        }
    }] selector:@selector(main) userInfo:nil repeats:YES];
}

- (void)moreClear {
    //float alpha = self.blurLayer.alpha;
    //self.blurLayer.alpha = alpha - 0.002;
}

- (void)handleSingleTap
{
    [self singleTapAction];
}

#pragma mark override
- (void)singleTapAction {
}

- (void)showAnimation {
    [UIView animateWithDuration:kAnimDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 1;
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:kAnimDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                     }];
}

// http://araking56.blog134.fc2.com/blog-entry-184.html
- (UIImage*)screenshot {
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor blackColor] set];
    CGContextFillRect(context, screenRect);
    [self.layer renderInContext:context];
    UIImage *screenImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenImage;
}


@end
