//
//  TTMainView.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "RMViewBase.h"
#import "RMHeaderView.h"
#import "RMListView.h"
#import "RMToolBar.h"
#import "RMErrorView.h"

@protocol TTMainViewDelegate
-(void)search:(NSString*)word;
@end

@interface TTMainView : RMViewBase<
RMHeaderViewDelegate,
RMListViewDelegate,
RMToolBarDelegate,
RMErrorViewDelegate
>

@property (nonatomic, strong) id<TTMainViewDelegate> delegate;
@property (nonatomic, strong) RMHeaderView *headerView;;
@property (nonatomic, strong) RMListView *listView;
@property (nonatomic, strong) RMToolBar *toolBar;
@property (nonatomic, strong) RMErrorView *errorView;

- (void)recieveContentsArray:(NSArray*)songs;
- (void)recieveErrorGettingContents;
- (void)clearList;

@end
