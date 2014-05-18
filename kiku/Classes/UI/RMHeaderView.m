//
//  RMHeaderView.m
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/08.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMHeaderView.h"
#import "ViewConstants.h"
#import "RMButton.h"
#import "ViewConstants.h"

@implementation RMHeaderView

@synthesize delegate = _delegate;
@synthesize button = _button;
@synthesize textField = _textField;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame withBlurLevel:0];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self setColor];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 5 + 20, self.frame.size.width - 35 * 2, self.frame.size.height - 20 - 13)];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [_textField setDelegate:self];
    [self addSubview:_textField];
    
    _textField.text = @"サザンオールスターズ"; //TODO debug
    
    UIImage *imageLogo = [UIImage imageNamed:@"list_btnChannel"];
    _button = [[RMButton alloc]initWithFrame:CGRectMake(SCREEN_FRAME.size.width - 50 - OFF_CENTER * 2,
                                                                 15,
                                                                 imageLogo.size.width / 2 + 30,
                                                                 imageLogo.size.height / 2 + 20)
                              withButtonSize:CGSizeMake(imageLogo.size.width / 2,
                                                        imageLogo.size.height / 2)
                                   withImage:imageLogo];
    [_button setButtonTag:tag_header_button];
    _button.delegate = self;
    [self addSubview:_button];
}

- (void)setColor {
    [self setBackgroundColor:[UIColor grayColor]];
}

- (void)showAnimation {
    CGRect rect = self.frame;
    [UIView animateWithDuration:kAnimDuration / 100
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, STATUS_BAR_HEIGHT);
                         self.alpha = 1.0;
                         _button.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:kAnimDuration
                                               delay:0.0
                                             options:UIViewAnimationOptionBeginFromCurrentState
                                          animations:^{
                                              //Animation
                                              self.frame = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, CH_HEADER_HEIGHT);
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished){
                                              _button.alpha = 1.0;
                                          }];
                     }];
}

- (void)hideAnimation {
    [UIView animateWithDuration:kAnimDuration
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         //Animation
                         //self.alpha = 0;
                         //_label.alpha = 0;
                     }
                     completion:^(BOOL finished){
                             //self.frame = CGRectMake(0, 0, SCREEN_FRAME.size.width, 0);
                     }];
}

#pragma mark button delegate
- (void)tapped:(int)buttonTag {
    [_textField resignFirstResponder];
    
    if ((_textField.text == NULL) || [_textField.text isEqualToString:@""]) {
        return;
    }
    [_delegate channelButtonTapped:_textField.text];
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [_textField resignFirstResponder];
    return YES;
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
