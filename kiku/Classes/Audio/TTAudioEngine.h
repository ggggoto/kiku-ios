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

@protocol TTAudioEngineDelegate
-(void)readyPlaying;
-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime;
@end

@interface TTAudioEngine : NSObject<AVAudioPlayerDelegate>

typedef enum {
    kAudioDoNotRepeat,
    kAudioSongRepeat,
    kAudioAlbumRepeat,
} TTAudioEngineMode;

@property (nonatomic, strong) id<TTAudioEngineDelegate> delegate;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) MPMoviePlayerController *mediaPlayer;
@property (nonatomic, assign) TTAudioEngineMode mode;
@property (nonatomic, strong) NSString *currentPlayingUrl;

- (void)setMode:(TTAudioEngineMode)mode;
- (void)play:(NSString*)urlStr;
- (int)getCurrentPlaybackDuration;
- (void)seek:(int)time;
- (void)setLockScreenInfo:(UIImage*)art
               audioTitle:(NSString*)audioTitle
               albumTitle:(NSString*)albumTitle
                   artist:(NSString*)artist;
- (void)enque:(NSString*)urlStr; //Add info too
- (void)deque:(NSString*)urlStr;

@end
