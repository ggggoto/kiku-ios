//
//  RMLoadingCommon.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/17.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMLoadingCommon.h"

@implementation RMLoadingCommon

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* img1 = [UIImage imageNamed:@"loadingCommon0001.png"];
        UIImage* img2 = [UIImage imageNamed:@"loadingCommon0002.png"];
        UIImage* img3 = [UIImage imageNamed:@"loadingCommon0003.png"];
        UIImage* img4 = [UIImage imageNamed:@"loadingCommon0004.png"];
        UIImage* img5 = [UIImage imageNamed:@"loadingCommon0005.png"];
        UIImage* img6 = [UIImage imageNamed:@"loadingCommon0006.png"];
        UIImage* img7 = [UIImage imageNamed:@"loadingCommon0007.png"];
        UIImage* img8 = [UIImage imageNamed:@"loadingCommon0008.png"];
        UIImage* img9 = [UIImage imageNamed:@"loadingCommon0009.png"];
        UIImage* img10 = [UIImage imageNamed:@"loadingCommon0010.png"];
        UIImage* img11 = [UIImage imageNamed:@"loadingCommon0011.png"];
        UIImage* img12 = [UIImage imageNamed:@"loadingCommon0012.png"];
        UIImage* img13 = [UIImage imageNamed:@"loadingCommon0013.png"];
        UIImage* img14 = [UIImage imageNamed:@"loadingCommon0014.png"];
        UIImage* img15 = [UIImage imageNamed:@"loadingCommon0015.png"];
        UIImage* img16 = [UIImage imageNamed:@"loadingCommon0016.png"];
        UIImage* img17 = [UIImage imageNamed:@"loadingCommon0017.png"];
        UIImage* img18 = [UIImage imageNamed:@"loadingCommon0018.png"];
        UIImage* img19 = [UIImage imageNamed:@"loadingCommon0019.png"];
        UIImage* img20 = [UIImage imageNamed:@"loadingCommon0020.png"];
        UIImage* img21 = [UIImage imageNamed:@"loadingCommon0021.png"];
        UIImage* img22 = [UIImage imageNamed:@"loadingCommon0022.png"];
        UIImage* img23 = [UIImage imageNamed:@"loadingCommon0023.png"];
        UIImage* img24 = [UIImage imageNamed:@"loadingCommon0024.png"];
        UIImage* img25 = [UIImage imageNamed:@"loadingCommon0025.png"];
        UIImage* img26 = [UIImage imageNamed:@"loadingCommon0026.png"];
        UIImage* img27 = [UIImage imageNamed:@"loadingCommon0027.png"];
        UIImage* img28 = [UIImage imageNamed:@"loadingCommon0028.png"];
        UIImage* img29 = [UIImage imageNamed:@"loadingCommon0029.png"];
        UIImage* img30 = [UIImage imageNamed:@"loadingCommon0030.png"];
        UIImage* img31 = [UIImage imageNamed:@"loadingCommon0031.png"];
        UIImage* img32 = [UIImage imageNamed:@"loadingCommon0032.png"];
        UIImage* img33 = [UIImage imageNamed:@"loadingCommon0033.png"];
        UIImage* img34 = [UIImage imageNamed:@"loadingCommon0034.png"];
        UIImage* img35 = [UIImage imageNamed:@"loadingCommon0035.png"];
        UIImage* img36 = [UIImage imageNamed:@"loadingCommon0036.png"];
        UIImage* img37 = [UIImage imageNamed:@"loadingCommon0037.png"];
        UIImage* img38 = [UIImage imageNamed:@"loadingCommon0038.png"];
        UIImage* img39 = [UIImage imageNamed:@"loadingCommon0039.png"];
        UIImage* img40 = [UIImage imageNamed:@"loadingCommon0040.png"];
        UIImage* img41 = [UIImage imageNamed:@"loadingCommon0041.png"];
        UIImage* img42 = [UIImage imageNamed:@"loadingCommon0042.png"];
        UIImage* img43 = [UIImage imageNamed:@"loadingCommon0043.png"];
        UIImage* img44 = [UIImage imageNamed:@"loadingCommon0044.png"];
        UIImage* img45 = [UIImage imageNamed:@"loadingCommon0045.png"];
        
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
        
        [self startAnimating];

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
