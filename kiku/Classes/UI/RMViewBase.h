//
//  RMViewBase.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/06.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#define kDKBlurredBackgroundDefaultLevel 0.9f
#define kDKBlurredBackgroundDefaultGlassLevel 0.2f
#define kDKBlurredBackgroundDefaultGlassColor [UIColor clearColor]

#import <UIKit/UIKit.h>
#import "FXBlurView.h"

@interface RMViewBase : UIView

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *backgroundGlassView;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImageView *originalImageView;
@property (nonatomic, assign) float initialBlurLevel;
@property (nonatomic, assign) float initialGlassLevel;
@property (nonatomic, assign) BOOL isGlassEffectOn;
@property (nonatomic, strong) UIColor *glassColor;
@property (nonatomic, assign) int imageTag;
@property (nonatomic, strong) FXBlurView *blurLayer;
@property (nonatomic, strong) UITapGestureRecognizer *singleFingerTap;
@property (nonatomic, strong) UIView *bgView;

- (id)initWithFrame:(CGRect)frame;
- (id)initWithFrame:(CGRect)frame withBlurLevel:(float)blurLevel;
- (void)makeBlur:(UIColor*)color withBlurLevel:(float)blurLevel;
- (void)makeClear;
- (void)originalBlur;
- (void)moreClear;
- (void)clearFinish;
- (void)blurFinish;
- (void)setOriginalImage:(UIImage *)originalImage;
- (void)handleSingleTap;
- (void)singleTapAction;
- (void)showAnimation;
- (void)hideAnimation;
- (UIImage*)screenshot;

@end
