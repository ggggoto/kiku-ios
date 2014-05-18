//
//  RMErrorView.m
//  Yom-News-
//
//  Created by TsuzukiTomoaki on 2014/01/03.
//  Copyright (c) 2014年 ramuh. All rights reserved.
//

#import "RMErrorView.h"
#import "ViewConstants.h"

@implementation RMErrorView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame withBlurLevel:0];
    if (self) {
        // Initialization code
        
        UIImage *image = [UIImage imageNamed:@"errorSign.png"];
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        iv.frame = CGRectMake(SCREEN_FRAME.size.width / 2 - image.size.width / 4,
                              SCREEN_FRAME.size.height / 2 - image.size.height / 4,
                              image.size.width / 2,
                               image.size.height / 2);
        [self addSubview:iv];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(30,
                                                                  50,
                                                                  self.frame.size.width - 60,
                                                                  self.frame.size.height)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setNumberOfLines:2];
        [label setFont:[UIFont fontWithName:HIRAKAKU size:16]];
        [label setTextColor:[UIColor whiteColor]];
        //label.text = [RMMasterData sharedInstance].errorViewText; //TODO Set Text
        [self addSubview:label];
        
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                            SCREEN_FRAME.size.height + STATUS_BAR_HEIGHT - 44,
                                                            SCREEN_FRAME.size.width,
                                                             44)];
        [bg setBackgroundColor:[UIColor blackColor]];
        [bg setAlpha:0.1];
        [self addSubview:bg];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(30, SCREEN_FRAME.size.height + STATUS_BAR_HEIGHT - 44, self.frame.size.width - 60, 44)];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [label2 setNumberOfLines:2];
        [label2 setFont:[UIFont fontWithName:HELVETICA size:17]];
        [label2 setTextColor:[UIColor whiteColor]];
        label2.text = @"Tap to cancel";
        [self addSubview:label2];
    }
    return self;
}

- (void)singleTapAction {
    [self hideAnimation];
    [_delegate errorViewTapped];
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
