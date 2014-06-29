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
#import "TTSongData.h"
#import "TTQueue.h"
#import "TTFifo.h"

@protocol TTAudioEngineDelegate
-(void)seeking;
-(void)readyPlaying;
-(void)updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration;
-(void)onChangedCurrentPlayingSong:(TTSongData*)songData;
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
@property (nonatomic, strong) TTQueue *queue;
@property (nonatomic, strong) TTFifo *fifo;

- (MPMoviePlaybackState)getPlaybackState;
- (void)setMode:(TTAudioEngineMode)mode;
- (void)playPeek;
- (void)playAtIndex:(int)index;
- (void)resumePlay;
- (void)pausePlay;
- (void)playNextSong;
- (void)pressedBackButton;
- (void)playPreviousSong;
- (int)getCurrentPlaybackDuration;
- (void)seek:(int)time;
- (void)enque:(TTSongData*)songData;
- (void)flush;

@end
