//
//  TTAudioEngine.h
//  kiku
//
//  Created by TsuzukiTomoaki on 2014/05/18.
//  Copyright (c) 2014年 TsuzukiTomoaki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface TTAudioEngine : NSObject<AVAudioPlayerDelegate>

@property (nonatomic, retain) AVAudioPlayer *audioPlayer;
@property (nonatomic, retain) MPMoviePlayerController *mediaPlayer;

- (void)play:(NSString*)urlStr;

@end
