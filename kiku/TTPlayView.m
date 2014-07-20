//
//  TTPlayView.m
//  kiku
//
//  Created by Goto Daisuke on 6/28/14.
//  Copyright (c) 2014 TsuzukiTomoaki. All rights reserved.
//

#import "TTPlayView.h"
#import "TTButton.h"

#define kCoverImageSize 200
#define kSongInfoLabe_X_BASE 51
#define kSongInfoLabe_Y_BASE 360
#define kSongInfoLabeWidth 217
#define kSongInfoLabeHeight 30

#define kMainButton_Y 410
#define kSubButton_Y 334
#define kTimeLabel_Bar_Y 324
#define kTimeLabelWidth 40
#define kTimeLabelHeight 20


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
}

@end

@implementation TTPlayView

@synthesize delegate = _delegate;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor colorWithRed:0.000 green:0.000 blue:0.000 alpha:0.65]];
        [self initializeSubParts];
        [self initializeMainParts];
        
//        self.alpha = 0.0;
    }
    return self;
}

- (void) onChangedCurrentPlayingSong:(TTSongData *)data {
    artistNameLabel.text = data.artistName;
    songTitleLabel.text = data.name;
    coverImageView.image = data.image;
}

- (void) updateCurrentPlaybackTime:(int)currentPlaybackTime withSongDuration:(int)songDuration {
    pastTimeLabel.text = [self timeString:currentPlaybackTime];
    remainingTimeLabel.text = [self timeString:currentPlaybackTime - songDuration];
    timeSlider.maximumValue = songDuration;
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


- (void) initializeMainParts{

    coverImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 100, kCoverImageSize, kCoverImageSize)];
    coverImageView.backgroundColor = [UIColor clearColor];
    
    songTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSongInfoLabe_X_BASE, kSongInfoLabe_Y_BASE, kSongInfoLabeWidth, kSongInfoLabeHeight + 20)];
    songTitleLabel.font = [UIFont fontWithName:kFontHirakaku_Bold size:19];
    songTitleLabel.textColor = [UIColor whiteColor];
    songTitleLabel.textAlignment = NSTextAlignmentCenter;
    
    artistNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(kSongInfoLabe_X_BASE, kSongInfoLabe_Y_BASE, kSongInfoLabeWidth, kSongInfoLabeHeight)];
    artistNameLabel.font = [UIFont fontWithName:kFontHirakaku size:15];
    artistNameLabel.textColor = [UIColor whiteColor];
    artistNameLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:coverImageView];
    [self addSubview:songTitleLabel];
    [self addSubview:artistNameLabel];
}

- (void) initializeSubParts {
    
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 5, self.bounds.size.width, 40)];
    NSString *titleName = [[TTMasterData sharedInstance] getText:PlAY_TITLE_KEY];
    titleLabel.text = titleName;
    titleLabel.font = [UIFont fontWithName:kFontHirakaku size:19];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    
    [self addSubview:titleLabel];

    UIImage *image1 = [UIImage imageNamed:kResourcePlayButton];
    playAndStopButton = [[TTButton alloc]initWithFrame:CGRectMake(130,
                                                                  kMainButton_Y,
                                                                  image1.size.width / 2,
                                                                  image1.size.height / 2)
                                        withButtonSize:CGSizeMake(image1.size.width / 2,
                                                                  image1.size.height / 2)
                                             withImage:image1];
    [playAndStopButton setButtonTag:kPlayButtonTag];
    playAndStopButton.delegate = self;

    UIImage *image2 = [UIImage imageNamed:kResourceBackButton];
    TTButton *playBackButton = [[TTButton alloc]initWithFrame:CGRectMake(46,
                                                                         kMainButton_Y,
                                                                         image2.size.width / 2,
                                                                         image2.size.height / 2)
                                               withButtonSize:CGSizeMake(image2.size.width / 2,
                                                                         image2.size.height / 2)
                                                    withImage:image2];
    [playBackButton setButtonTag:kBackButtonTag];
    playBackButton.delegate = self;

    UIImage *image3 = [UIImage imageNamed:kResourceForwardButton];
    TTButton *playForwardButton = [[TTButton alloc]initWithFrame:CGRectMake(214,
                                                                            kMainButton_Y,
                                                                            image3.size.width / 2,
                                                                            image3.size.height / 2)
                                                  withButtonSize:CGSizeMake(image3.size.width / 2,
                                                                            image3.size.height / 2)
                                                       withImage:image3];
    [playForwardButton setButtonTag:kForwardButtonTag];
    playForwardButton.delegate = self;
    
    UIImage *image4 = [UIImage imageNamed:kResourceRepeatButton];
    playRepeatButton = [[TTButton alloc]initWithFrame:CGRectMake(0,
                                                                 kSubButton_Y,
                                                                 image4.size.width / 2,
                                                                 image4.size.height / 2)
                                       withButtonSize:CGSizeMake(image4.size.width / 2,
                                                                 image4.size.height / 2)
                                            withImage:image4];
    [playRepeatButton setButtonTag:kRepeatButtonTag];
    playRepeatButton.delegate = self;

    UIImage *image5 = [UIImage imageNamed:kResourceShuffleButton];
    playShuffleButton = [[TTButton alloc]initWithFrame:CGRectMake(self.bounds.size.width - image5.size.width / 2,
                                                                  kSubButton_Y,
                                                                  image5.size.width / 2,
                                                                  image5.size.height / 2)
                                        withButtonSize:CGSizeMake(image5.size.width / 2,
                                                                  image5.size.height / 2)
                                             withImage:image5];
    [playShuffleButton setButtonTag:kShuffleButtonTag];
    playShuffleButton.delegate = self;

    UIImage *image6 = [UIImage imageNamed:kResourceHeaderTweetButton];
    TTButton *tweetButton = [[TTButton alloc]initWithFrame:CGRectMake(0,
                                                                      kStatusBarHeight,
                                                                      image6.size.width / 2,
                                                                      image6.size.height / 2)
                                            withButtonSize:CGSizeMake(image6.size.width / 2,
                                                                      image6.size.height / 2)
                                                 withImage:image6];
    [tweetButton setButtonTag:kTweetButtonTag];
    tweetButton.delegate = self;

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
    
    timeSlider = [[UISlider alloc]initWithFrame:CGRectMake(51, kTimeLabel_Bar_Y, 217, 18)];
    UIImage *image8 = [UIImage imageNamed:kResourceSliderThumb];
    UIImage *image9 = [UIImage imageNamed:kResourceSliderMaxBackground];
    UIImage *image10 = [UIImage imageNamed:kResourceSliderMinBackground];
    
    [timeSlider setThumbImage:image8 forState:UIControlStateNormal];
    [timeSlider setMaximumTrackImage:image9 forState:UIControlStateNormal];
    [timeSlider setMinimumTrackImage:image10 forState:UIControlStateNormal];
    
    [timeSlider addTarget:self action:@selector(seekBarVlaueChanged:) forControlEvents:UIControlEventValueChanged];
    
    
    pastTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, kTimeLabel_Bar_Y, kTimeLabelWidth, kTimeLabelHeight)];
    pastTimeLabel.font = [UIFont fontWithName:kFontHelvetica size:10];
    pastTimeLabel.textColor = [UIColor whiteColor];

    remainingTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(273, kTimeLabel_Bar_Y, kTimeLabelWidth, kTimeLabelHeight)];
    remainingTimeLabel.font = [UIFont fontWithName:kFontHelvetica size:10];
    remainingTimeLabel.textColor = [UIColor whiteColor];
    
    //for initial
    pastTimeLabel.text = @"0:00";
    remainingTimeLabel.text = @"0:00";
    
    [self addSubview:timeSlider];
    [self addSubview:pastTimeLabel];
    [self addSubview:remainingTimeLabel];
}

- (void)seekBarVlaueChanged:(UISlider*)slider{
    int time = slider.value;
    [_delegate onSeekBarValueChanged:time];
}

- (void)tapped:(int)buttonTag{
    switch (buttonTag) {
        case kPlayButtonTag:
            [_delegate onPlayStopButtonPressed];
            break;

        case kBackButtonTag:
            [_delegate onPreviousButtonPressed];
            break;
            
        case kForwardButtonTag:
            [_delegate onNextSongButtonPressed];
            break;

        case kTweetButtonTag:
            if (songTitleLabel.text != NULL) {
                [_delegate ontTweetButtonPressed:songTitleLabel.text withArtistName:artistNameLabel.text];
            }
            break;
            
        case kRepeatButtonTag:
            [_delegate onRepeatButtonPressed];
            break;
            
        case kShuffleButtonTag:
            [_delegate onShuffleButtonPressed];
            break;
            
        case kHideButtonTag:
            [self hideAnimation];
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
