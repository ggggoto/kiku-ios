//
//  TTViewController.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewController.h"
#import "TTCommunicationEngine.h"

@interface TTViewController ()

@end

@implementation TTViewController

@synthesize comEngine = _comEngine;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
}

- (void)initialize {
    _comEngine = [[TTCommunicationEngine alloc]init];
    [_comEngine readJson];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
