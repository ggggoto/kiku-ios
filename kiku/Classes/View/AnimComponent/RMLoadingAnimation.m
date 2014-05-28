//
//  RMLoadingAnimation.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/15.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMLoadingAnimation.h"

@implementation RMLoadingAnimation

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImage* img1 = [UIImage imageNamed:@"loading01.png"];
        UIImage* img2 = [UIImage imageNamed:@"loading02.png"];
        UIImage* img3 = [UIImage imageNamed:@"loading03.png"];
        UIImage* img4 = [UIImage imageNamed:@"loading04.png"];
        UIImage* img5 = [UIImage imageNamed:@"loading05.png"];
        UIImage* img6 = [UIImage imageNamed:@"loading06.png"];
        UIImage* img7 = [UIImage imageNamed:@"loading07.png"];
        UIImage* img8 = [UIImage imageNamed:@"loading08.png"];
        UIImage* img9 = [UIImage imageNamed:@"loading09.png"];
        UIImage* img10 = [UIImage imageNamed:@"loading10.png"];
        UIImage* img11 = [UIImage imageNamed:@"loading11.png"];
        UIImage* img12 = [UIImage imageNamed:@"loading12.png"];
        UIImage* img13 = [UIImage imageNamed:@"loading13.png"];
        UIImage* img14 = [UIImage imageNamed:@"loading14.png"];
        UIImage* img15 = [UIImage imageNamed:@"loading15.png"];
        
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
                              img1,
                              img1,
                              img1,
                              img1,
                              img1,
                              img1,
                              img1,
                              nil];
        
        self.animationImages = imgArray;
        self.animationRepeatCount = 0;
        self.animationDuration = 1.2;
        
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
