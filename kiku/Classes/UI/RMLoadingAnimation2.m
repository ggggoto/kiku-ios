//
//  RMLoadingAnimation2.m
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2014/01/01.
//  Copyright (c) 2014年 ramuh. All rights reserved.
//

#import "RMLoadingAnimation2.h"
#import "ViewConstants.h"

@implementation RMLoadingAnimation2

@synthesize isShown = _isShown;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* img1 = [UIImage imageNamed:@"lc01.png"];
        UIImage* img2 = [UIImage imageNamed:@"lc02.png"];
        UIImage* img3 = [UIImage imageNamed:@"lc03.png"];
        UIImage* img4 = [UIImage imageNamed:@"lc04.png"];
        UIImage* img5 = [UIImage imageNamed:@"lc05.png"];
        UIImage* img6 = [UIImage imageNamed:@"lc06.png"];
        UIImage* img7 = [UIImage imageNamed:@"lc07.png"];
        UIImage* img8 = [UIImage imageNamed:@"lc08.png"];
        UIImage* img9 = [UIImage imageNamed:@"lc09.png"];
        UIImage* img10 = [UIImage imageNamed:@"lc10.png"];
        UIImage* img11 = [UIImage imageNamed:@"lc11.png"];
        UIImage* img12 = [UIImage imageNamed:@"lc12.png"];
        UIImage* img13 = [UIImage imageNamed:@"lc13.png"];
        UIImage* img14 = [UIImage imageNamed:@"lc14.png"];
        UIImage* img15 = [UIImage imageNamed:@"lc15.png"];
        UIImage* img16 = [UIImage imageNamed:@"lc16.png"];
        UIImage* img17 = [UIImage imageNamed:@"lc17.png"];
        UIImage* img18 = [UIImage imageNamed:@"lc18.png"];
        UIImage* img19 = [UIImage imageNamed:@"lc19.png"];
        UIImage* img20 = [UIImage imageNamed:@"lc20.png"];
        UIImage* img21 = [UIImage imageNamed:@"lc21.png"];
        UIImage* img22 = [UIImage imageNamed:@"lc22.png"];
        UIImage* img23 = [UIImage imageNamed:@"lc23.png"];
        UIImage* img24 = [UIImage imageNamed:@"lc24.png"];
        UIImage* img25 = [UIImage imageNamed:@"lc25.png"];
        UIImage* img26 = [UIImage imageNamed:@"lc26.png"];
        UIImage* img27 = [UIImage imageNamed:@"lc27.png"];
        UIImage* img28 = [UIImage imageNamed:@"lc28.png"];
        UIImage* img29 = [UIImage imageNamed:@"lc29.png"];
        UIImage* img30 = [UIImage imageNamed:@"lc30.png"];
        UIImage* img31 = [UIImage imageNamed:@"lc31.png"];
        UIImage* img32 = [UIImage imageNamed:@"lc32.png"];
        UIImage* img33 = [UIImage imageNamed:@"lc33.png"];
        UIImage* img34 = [UIImage imageNamed:@"lc34.png"];
        UIImage* img35 = [UIImage imageNamed:@"lc35.png"];
        UIImage* img36 = [UIImage imageNamed:@"lc36.png"];
        UIImage* img37 = [UIImage imageNamed:@"lc37.png"];
        UIImage* img38 = [UIImage imageNamed:@"lc38.png"];
        UIImage* img39 = [UIImage imageNamed:@"lc39.png"];
        UIImage* img40 = [UIImage imageNamed:@"lc40.png"];
        UIImage* img41 = [UIImage imageNamed:@"lc41.png"];
        UIImage* img42 = [UIImage imageNamed:@"lc42.png"];
        UIImage* img43 = [UIImage imageNamed:@"lc43.png"];
        UIImage* img44 = [UIImage imageNamed:@"lc44.png"];
        UIImage* img45 = [UIImage imageNamed:@"lc45.png"];
        
        NSArray* imgArray  = [NSArray arrayWithObjects:
                              img1,
                              img2,
                              img3,
                              img4,
                              img5,
                              img6,
                              img7,
                              img8,
                              img9,
                              img10,
                              img11,
                              img12,
                              img13,
                              img14,
                              img15,
                              img16,
                              img17,
                              img18,
                              img19,
                              img20,
                              img21,
                              img22,
                              img23,
                              img24,
                              img25,
                              img26,
                              img27,
                              img28,
                              img29,
                              img30,
                              img31,
                              img32,
                              img33,
                              img34,
                              img35,
                              img36,
                              img37,
                              img38,
                              img39,
                              img40,
                              img41,
                              img42,
                              img43,
                              img44,
                              img45,
                              nil];
        
        self.animationImages = imgArray;
        self.animationRepeatCount = 0;
        self.animationDuration = 2.0;
        
        _isShown = NO;
        self.transform = CGAffineTransformMakeScale(0.0, 0.0);
    }
    return self;
}

- (void)showAnimation {
    if (!_isShown) {
        [self startAnimating];
        _isShown = YES;
        [UIView animateWithDuration:kAnimDuration * 2
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             //Animation
                             [self setAlpha:1.0];
                             self.transform = CGAffineTransformMakeScale(1.0, 1.0);
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void)hideAnimation {
    if (_isShown) {
        [self stopAnimating];
        _isShown = NO;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:kAnimDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             //Animation
                             [self setAlpha:0.0];
                             self.transform = CGAffineTransformMakeScale(0.0, 0.0);
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void)showAnimation2 {
    if (!_isShown) {
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [self startAnimating];
        _isShown = YES;
        [UIView animateWithDuration:kAnimDuration * 2
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             //Animation
                             [self setAlpha:1.0];
                         }
                         completion:^(BOOL finished){
                         }];
    }
}

- (void)hideAnimation2 {
    if (_isShown) {
        [self stopAnimating];
        _isShown = NO;
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:kAnimDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             //Animation
                             [self setAlpha:0.0];
                         }
                         completion:^(BOOL finished){
                         }];
    }
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
