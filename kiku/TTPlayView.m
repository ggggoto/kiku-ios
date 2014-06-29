//
//  TTPlayView.m
//  kiku
//
//  Created by Goto Daisuke on 6/28/14.
//  Copyright (c) 2014 TsuzukiTomoaki. All rights reserved.
//

#import "TTPlayView.h"
#import "TTButton.h"

@interface TTPlayView()
{
    TTButton *playAndStopButton;
    TTButton *playRepeatButton;
    TTButton *playShuffleButton;
    UISlider *timeSlider;
    UILabel *pastTimeLabel;
    UILabel *remainingTimeLabel;
    
    UIImageView *coverImageView;
    UILabel *songTitleLabel;
    UILabel *artistNameLabel;
    int currentSongDuration;
    
    int curPlaybackTime;
}

@end

@implementation TTPlayView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.65]];
        [self initializeSubParts];
        [self initializeMainParts];
        
        self.alpha = 0.0;
    }
    return self;
}

- (void) onChangedCurrentPlayingSong:(TTSongData *)data
{
    artistNameLabel.text = data.artistName;
    songTitleLabel.text = data.name;
    coverImageView.image = data.image;
    
}

- (void) updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration
{
//    curPlaybackTime = currentPlaybackTime;
//    currentSongDuration = songDuration;
//    NSLog(@"duration %d past %d",currentPlaybackTime,songDuration);
    
    pastTimeLabel.text = [self timeString:currentPlaybackTime];
    remainingTimeLabel.text = [self timeString:currentPlaybackTime - songDuration];
}

- (NSString*)timeString:(int)time
{
    if (time == 0) {
        return @"0:00";
    }
    
    int ss = abs(time % 60);
    int mm = time / 60;
    
    NSString *timeLabelString = [NSString stringWithFormat:@"%d:%02d",mm,ss];
    
    return timeLabelString;
}


- (void) initializeMainParts
{
    
    coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 100, 200, 200)];
    coverImageView.backgroundColor = [UIColor clearColor];
    
    
    songTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(51, 360, 217, 50)];
    songTitleLabel.font = [UIFont fontWithName:kFontHirakaku_Bold size:19];
    songTitleLabel.textColor = [UIColor whiteColor];
    songTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    artistNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(51, 390, 217, 30)];
    artistNameLabel.font = [UIFont fontWithName:kFontHirakaku size:15];
    artistNameLabel.textColor = [UIColor whiteColor];
    artistNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:coverImageView];
    [self addSubview:songTitleLabel];
    [self addSubview:artistNameLabel];
}

- (void) initializeSubParts
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 5, self.bounds.size.width, 40)];
    NSString *titleName = [[TTMasterData sharedInstance] getText:PlAY_TITLE_KEY];
    titleLabel.text = titleName;
    titleLabel.font = [UIFont fontWithName:kFontHirakaku size:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:titleLabel];

    UIImage *image1 = [UIImage imageNamed:kResourcePlayButton];
    playAndStopButton = [[TTButton alloc]initWithFrame:CGRectMake(130,
                                                                  410,
                                                                  image1.size.width / 2,
                                                                  image1.size.height / 2)
                                        withButtonSize:CGSizeMake(image1.size.width / 2,
                                                                  image1.size.height / 2)
                                             withImage:image1];
    [playAndStopButton setButtonTag:kPlayButtonTag];
    playAndStopButton.delegate = self;

    UIImage *image2 = [UIImage imageNamed:kResourceBackButton];
    TTButton *playBackButton = [[TTButton alloc]initWithFrame:CGRectMake(46,
                                                                         410,
                                                                         image2.size.width / 2,
                                                                         image2.size.height / 2)
                                               withButtonSize:CGSizeMake(image2.size.width / 2,
                                                                         image2.size.height / 2)
                                                    withImage:image2];
    [playBackButton setButtonTag:kBackButtonTag];
    playBackButton.delegate = self;

    UIImage *image3 = [UIImage imageNamed:kResourceForwardButton];
    TTButton *playForwardButton = [[TTButton alloc]initWithFrame:CGRectMake(214,
                                                                            410,
                                                                            image3.size.width / 2,
                                                                            image3.size.height / 2)
                                                  withButtonSize:CGSizeMake(image3.size.width / 2,
                                                                            image3.size.height / 2)
                                                       withImage:image3];
    [playForwardButton setButtonTag:kForwardButtonTag];
    playForwardButton.delegate = self;
    
    UIImage *image4 = [UIImage imageNamed:kResourceRepeatButton];
    playRepeatButton = [[TTButton alloc]initWithFrame:CGRectMake(0,
                                                                           334,
                                                                           image4.size.width / 2,
                                                                           image4.size.height / 2)
                                                 withButtonSize:CGSizeMake(image4.size.width / 2,
                                                                           image4.size.height / 2)
                                                      withImage:image4];

    UIImage *image5 = [UIImage imageNamed:kResourceShuffleButton];
    playShuffleButton = [[TTButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - image5.size.width / 2,
                                                                            334,
                                                                            image5.size.width / 2,
                                                                            image5.size.height / 2)
                                                  withButtonSize:CGSizeMake(image5.size.width / 2,
                                                                            image5.size.height / 2)
                                                      withImage:image5];

    UIImage *image6 = [UIImage imageNamed:kResourceHeaderTweetButton];
    TTButton *tweetButton = [[TTButton alloc]initWithFrame:CGRectMake(0,
                                                                      kStatusBarHeight,
                                                                      image6.size.width / 2,
                                                                      image6.size.height / 2)
                                            withButtonSize:CGSizeMake(image6.size.width / 2,
                                                                      image6.size.height / 2)
                                                       withImage:image6];

    UIImage *image7 = [UIImage imageNamed:kResourceHeaderCloseButton];
    TTButton *hideButton = [[TTButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - image7.size.width / 2,
                                                                       kStatusBarHeight,
                                                                       image7.size.width / 2,
                                                                       image7.size.height / 2)
                                             withButtonSize:CGSizeMake(image7.size.width / 2,
                                                                       image7.size.height / 2)
                                                 withImage:image7];
    [hideButton setButtonTag:kHideButtonTag];
    hideButton.delegate = self;
    
    [self addSubview:tweetButton];
    [self addSubview:hideButton];
    [self addSubview:playRepeatButton];
    [self addSubview:playShuffleButton];
    [self addSubview:playAndStopButton];
    [self addSubview:playBackButton];
    [self addSubview:playForwardButton];
    
    timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(51, 325, 217, 18)];
    UIImage *image8 = [UIImage imageNamed:kResourceSliderThumb];
    UIImage *image9 = [UIImage imageNamed:kResourceSliderMaxBackground];
    UIImage *image10 = [UIImage imageNamed:kResourceSliderMinBackground];
    
    [timeSlider setThumbImage:image8 forState:UIControlStateNormal];
    [timeSlider setMaximumTrackImage:image9 forState:UIControlStateNormal];
    [timeSlider setMinimumTrackImage:image10 forState:UIControlStateNormal];
    
    [timeSlider addTarget:self action:@selector(seekBarValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    pastTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 324, 40, 20)];
    pastTimeLabel.font = [UIFont fontWithName:kFontHelvetica size:10];
    pastTimeLabel.textColor = [UIColor whiteColor];

    remainingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(273, 324, 40, 20)];
    remainingTimeLabel.font = [UIFont fontWithName:kFontHelvetica size:10];
    remainingTimeLabel.textColor = [UIColor whiteColor];
    
    //for initial
    pastTimeLabel.text = @"0:00";
    remainingTimeLabel.text = @"0:00";
    
    [self addSubview:timeSlider];
    [self addSubview:pastTimeLabel];
    [self addSubview:remainingTimeLabel];


}

- (void)seekBarValueChanged:(UISlider *)slider
{
    float val = slider.value;
//    float duration = [];
//    float time = val * duration / timeSlider.maximumValue;
    
//    [_movieView seekToSeconds:time];
}

- (void)tapped:(int)buttonTag
{
    switch (buttonTag) {
        case kPlayButtonTag:
            [_delegate playOrStop];
            break;

        case kBackButtonTag:
            [_delegate playBack];
            break;
            
        case kForwardButtonTag:
            [_delegate playForward];
            break;

        case kHideButtonTag:
            self.alpha = 0.0;
            break;
            
        default:
            break;
    }
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
