//
//  ViewConstants.h
//  Yom-News-
//
//  Created by 都筑 友昭 on 2013/12/07.
//  Copyright (c) 2013年 ramuh. All rights reserved.
//

#ifndef Yom_News__ViewConstants_h
#define Yom_News__ViewConstants_h

#define SCREEN_FRAME [[UIScreen mainScreen] applicationFrame]
#define STATUS_BAR_HEIGHT 20
#define CH_HEADER_HEIGHT 64

#pragma mark Channel Json
#define JSON_CH_NEWS @"NEWS"

#pragma mark image file name
#define channel_logo @"channel_ramuhLogo.png"
#define LIST_BG @"bg.png"

#define tag_header_button 1000

#pragma mark Channels
#define CH_SIZE 77
#define CH_MARGIN_LEFT 3
#define CH_MARGIN 2
#define CH_MARGIN_HEIGHT_TOP 190 / 2
#define OFF_CENTER 5

#pragma mark List
#define LLIST_IMAGE_WIDTH 153
#define LLIST_IMAGE_HEIGHT 98
#define SLIST_IMAGE_WIDTH 70
#define SLIST_IMAGE_HEIGHT 70
#define MARGIN_TOP_OFFSET 69
#define MARGIN_TOP_LIST_OFFSET 226
#define MARGIN_LEFT 5
#define MARGIN_BETWEEN 4
#define LCONTENT_WIDTH 153
#define LCONTENT_HEIGHT 153
#define SCONTENT_WIDTH 310
#define SCONTENT_HEIGHT 70

#pragma mark webview
#define GAP 5
#define TOOLBAR_HEIGHT 44

#pragma mark socialview
#define SOCIAL_VIEW_WIDHT 310
#define SOCIAL_VIEW_HEIGHT 315

#pragma mark ad
#define AD_HEIGHT 50
#define AD_WIDTH 320

#pragma mark animation
#define kAnimDuration 0.3
#define kChAnimDuration 0.3

#pragma mark alpha
#define STATUS_BAR_ALPHA 0.15
#define HEADER_ALPHA 0.1

#pragma font
#define HIRAKAKU @"HiraKakuProN-W3"
#define HIRAKAKUBOLD @"HiraKakuProN-W6"
#define HELVETICA @"Helvetica"
#define HELVETICABOLD @"Helvetica-Bold"
#define NEW_FONT @"Verdana-Bold"

#pragma mark data
#define NOIMAGE @"NoLink"

#endif
