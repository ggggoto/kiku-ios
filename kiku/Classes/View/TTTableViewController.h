//
//  TTTableViewController.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/06/12.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

- (id)initWithFrame:(CGRect)frame;

@end
