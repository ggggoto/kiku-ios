//
//  TTToolbar.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/30.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTToolbar.h"

@implementation TTToolbar

@synthesize button1 = _button1;
@synthesize button2 = _button2;
@synthesize button3 = _button3;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initializeViews];
    }
    return self;
}

- (void)initializeViews {
    [self setBackgroundColor:[UIColor colorWithRed:0.784 green:0.784 blue:0.784 alpha:1.0]];
    
    UIImage *buttonImage1 = [UIImage imageNamed:kResourceToolbarButton1];
    _button1 = [[TTButton alloc]initWithFrame:CGRectMake(0,
                                                         0,
                                                         buttonImage1.size.width / 2,
                                                         buttonImage1.size.height / 2)
                               withButtonSize:CGSizeMake(buttonImage1.size.width / 2,
                                                         buttonImage1.size.height / 2)
                                    withImage:buttonImage1];
    [_button1 setButtonTag:kToolbaButtonTag1];
    [self addSubview:_button1];
    
    UIImage *buttonImage2 = [UIImage imageNamed:kResourceToolbarButton2];
    _button2 = [[TTButton alloc]initWithFrame:CGRectMake(buttonImage1.size.width / 2,
                                                         0,
                                                         buttonImage1.size.width / 2,
                                                         buttonImage1.size.height / 2)
                               withButtonSize:CGSizeMake(buttonImage1.size.width / 2,
                                                         buttonImage1.size.height / 2)
                                    withImage:buttonImage2];
    [_button2 setButtonTag:kToolbaButtonTag2];
    [self addSubview:_button2];
    
    UIImage *buttonImage3 = [UIImage imageNamed:kResourceToolbarButton3];
    _button3 = [[TTButton alloc]initWithFrame:CGRectMake(buttonImage1.size.width / 2 * 2,
                                                         0,
                                                         buttonImage1.size.width / 2,
                                                         buttonImage1.size.height / 2)
                               withButtonSize:CGSizeMake(buttonImage1.size.width / 2,
                                                         buttonImage1.size.height / 2)
                                    withImage:buttonImage3];
    [_button3 setButtonTag:kToolbaButtonTag3];
    [self addSubview:_button3];
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
