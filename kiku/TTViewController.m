//
//  TTViewController.m
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/16.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import "TTViewController.h"

@interface TTViewController ()

@end

@implementation TTViewController

@synthesize comEngine = _comEngine;
@synthesize audioEngine = _audioEngine;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self initialize];
}

- (void)initialize {
    _comEngine = [[TTCommunicationEngine alloc]init];
    _audioEngine = [[TTAudioEngine alloc] init];
    //[_comEngine trySearch:@"Mr Children" withPage:1];
    //[_comEngine tryGetAlbum:@"180252"];
    [_audioEngine play:@"http://m5.file.xiami.com/906/6906/180252/2213480_4149968_l.mp3?auth_key=80d893afaf20070d1a8ef242d038d573-1400457600-0-null"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
