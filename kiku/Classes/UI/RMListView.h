//
//  RMListView.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/11.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#import "RMViewBase.h"
#import "RMArticleContentsLarge.h"
#import "RMArticleContentsList.h"
#import "RMLoadingAnimation2.h"
#import "RMRefreshLoadingAnimation.h"

@protocol RMListViewDelegate
- (void) songSelected:(NSString*)urlStr;
- (void) scrollViewReachedThreshold;
@end

typedef enum {
    kNotRefreshing = 0,
    kRefreshing = 1,
} ListViewRefresh;

@interface RMListView : RMViewBase<UIScrollViewDelegate, RMArticleContentsDelegate>

@property (nonatomic, strong) id<RMListViewDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *array;;
@property (nonatomic, strong) UIScrollView *sv;
@property (nonatomic, strong) RMViewBase *bg;
@property (nonatomic, strong) RMLoadingAnimation2 *autoLoadAnim;

- (void)recieveContentsArray:(NSArray*)songs;
- (void)recieveErrorGettingContents;
- (void)clearList;
- (void)setContentHeight:(float)height;
- (void)setAutoLoadAnimation;
- (void)unsetAutoLoadAnimation;

@end
