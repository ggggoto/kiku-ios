//
//  RMToolBar.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/19.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMToolBar.h"
#import "RMButton.h"
#import "ViewConstants.h"

#define GAP_LEFT 16
#define GAP_MIDDLE 17
#define BUTTON_SIZE 44
#define BUTTON_OUTER_MARGIN 16
#define BUTTON_TAG_BASE 1000

@implementation RMToolBar

@synthesize delegate = _delegate;
@synthesize isShown = _isShown;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor blackColor]];
        [self setAlpha:0.0];
        
        NSMutableArray *buttonArray = [[NSMutableArray alloc]init];
        [buttonArray addObject:[UIImage imageNamed:@"toolbarBtn_back.png"]];
        [buttonArray addObject:[UIImage imageNamed:@"toolbarBtn_forward.png"]];
        [buttonArray addObject:[UIImage imageNamed:@"toolbarBtn_twitter.png"]];
        [buttonArray addObject:[UIImage imageNamed:@"toolbarBtn_facebook.png"]];
        [buttonArray addObject:[UIImage imageNamed:@"toolbarBtn_share.png"]];
        int i = 0;
        for (UIImage *image in buttonArray) {
            RMButton *button = [[RMButton alloc]initWithFrame:CGRectMake(GAP_LEFT + BUTTON_SIZE  * i + GAP_MIDDLE * i - 12,
                                                                         - BUTTON_OUTER_MARGIN / 2,
                                                                         image.size.width / 2 + BUTTON_OUTER_MARGIN,
                                                                         image.size.height / 2 + BUTTON_OUTER_MARGIN)
                                               withButtonSize:CGSizeMake(image.size.width / 2,
                                                                         image.size.height / 2)
                                                    withImage:image];
            [button setButtonTag:BUTTON_TAG_BASE + i];
            button.backgroundColor = [UIColor clearColor];
            [self addSubview:button];
            button.delegate = self;
            i++;
        }
        _isShown = NO;
    }
    return self;
}

- (void)showAnimation {
    if (!_isShown) {
        _isShown = YES;
        CGPoint point = self.center;
        [UIView animateWithDuration:kAnimDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             //Animation
                             self.alpha = 0.85;
                             self.center = CGPointMake(point.x, point.y - TOOLBAR_HEIGHT);
                         }
                         completion:^(BOOL finished){
                             //Completion
                         }];
    }
}

- (void)hideAnimation {
    if (_isShown) {
        _isShown = NO;
        CGPoint point = self.center;
        [UIView animateWithDuration:kAnimDuration
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             //Animation
                             self.center = CGPointMake(point.x, point.y + TOOLBAR_HEIGHT);
                         }
                         completion:^(BOOL finished){
                             //Completion
                         }];
    }
}

- (void)tapAnimation:(int)tag {
    for (RMButton *view in [self subviews]) {
        if (view.buttonTag == tag) {
            [view tapAnimation];
        }
    }
}

- (void)tapped:(int)buttonTag {
    [self tapAnimation:buttonTag];
    [_delegate toolbarTapped:buttonTag];
}

- (void) setForwardButtonInteraction:(bool)enable {
    for (RMButton *view in [self subviews]) {
        if (view.buttonTag == BUTTON_TAG_BASE + 1) {
            [view setInteraction:enable];
        }
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
