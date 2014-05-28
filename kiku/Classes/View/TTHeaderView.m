//
//  TTHeaderView.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/25.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTHeaderView.h"
#import "HTAutocompleteManager.h"
#import "TTMasterData.h"
#import "NSString+util.h"

#define kButtonSize 44
#define kTextFieldVerticalGap 7
#define kTextFieldVerticalGapToLeft 8
#define kSearchIconGapToLeft 5

#define kMenuButtonTag 1000

@implementation TTHeaderView

@synthesize delegate = _delegate;
@synthesize textField = _textField;
@synthesize button = _button;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != NULL) {
        //To something for initialization
        [self setBackgroundColor:[[TTMasterData sharedInstance].color objectForKey:COLOR_HEADER]];
        
        [self initializeButton];
        [self initializeTextfield];
    }
    return self;
}

- (void)initializeTextfield {
    _textField = [[HTAutocompleteTextField alloc]initWithFrame:CGRectMake(kButtonSize,
                                                                          kTextFieldVerticalGap,
                                                                          SCREEN_FRAME.size.width - kButtonSize - kTextFieldVerticalGapToLeft,
                                                                          kHeaderHeight - kTextFieldVerticalGap * 2)];
    
    _textField.autocompleteDataSource = [HTAutocompleteManager sharedManager];
    _textField.autocompleteType = HTAutocompleteTypeEmail;
    
    [_textField setFont:[UIFont fontWithName:kFontHirakaku size:14]];
    [_textField setTextColor:[[TTMasterData sharedInstance].color objectForKey:COLOR_HEADER]];
    [_textField setReturnKeyType:UIReturnKeySearch];
    [_textField setClearButtonMode:UITextFieldViewModeAlways];
    [_textField setBorderStyle:UITextBorderStyleRoundedRect];
    [_textField setBackgroundColor:[[TTMasterData sharedInstance].color objectForKey:COLOR_SEARCH_INSIDE]];
    
    [_textField setLeftViewMode:UITextFieldViewModeAlways];
    UIImage *image = [UIImage imageNamed:kResourceSearchIcon];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(kSearchIconGapToLeft,
                                                                          0,
                                                                          image.size.width / 2,
                                                                          image.size.height / 2)];
    [imageView setImage:image];
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                               0,
                                                               image.size.width / 2 + kSearchIconGapToLeft,
                                                               image.size.height / 2)];
    [leftView addSubview:imageView];
    [_textField setLeftView:leftView];
    
    NSString *placeHolder = [[TTMasterData sharedInstance] getText:SEARCH_PLACEHOLDER_KEY];
    UIColor *color = [[TTMasterData sharedInstance].color objectForKey:COLOR_HEADER];
    _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder
                                                                       attributes:@{NSForegroundColorAttributeName: color}];
    
    _textField.delegate = self;
    [self addSubview:_textField];
}

- (void)initializeButton {
    UIImage *buttonImage = [UIImage imageNamed:kResourceHeaderButton];
    _button = [[TTButton alloc]initWithFrame:CGRectMake(0,
                                                        0,
                                                        kButtonSize,
                                                        kButtonSize)
                              withButtonSize:CGSizeMake(buttonImage.size.width / 2,
                                                        buttonImage.size.height / 2)
                                   withImage:buttonImage];
    [_button setButtonTag:kMenuButtonTag];
    [_button setDelegate:self];
    [self addSubview:_button];
}

#pragma mark textfield
-(BOOL)textFieldShouldClear:(UITextField*)textField {
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [_textField resignFirstResponder];
    if (![NSString_util stringIsNilOrEmpty:textField.text]) {
        [_delegate headerSearchPressed:textField.text];
    }
    return YES;
}

#pragma mark button
- (void)tapped:(int)buttonTag {
    if (buttonTag != kMenuButtonTag) {
        return;
    }
    [_delegate headerMenuPressed];
}

@end
