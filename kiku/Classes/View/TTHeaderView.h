//
//  TTHeaderView.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/25.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTViewBase.h"
#import "TTButton.h"
#import "HTAutocompleteTextField.h"

@protocol TTHeaderViewDelegate
-(void)headerSearchBegin;
-(void)headerSearchPressed:(NSString*)word;
-(void)headerMenuPressed;
@end

@interface TTHeaderView : TTViewBase<
UITextFieldDelegate,
TTButtonDelegate
>

@property (nonatomic, strong) id<TTHeaderViewDelegate> delegate;
@property (nonatomic, strong) HTAutocompleteTextField *textField;
@property (nonatomic, strong) TTButton* button;

- (id)initWithFrame:(CGRect)frame;
- (void)cancelSearchInput;


@end
