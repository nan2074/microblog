//
//  HMStatusDetailFrame.h
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNStatus, SNStatusOriginalFrame, SNStatusRetweetedFrame;

@interface SNStatusDetailFrame : NSObject
@property (nonatomic, strong) SNStatusOriginalFrame *originalFrame;
@property (nonatomic, strong) SNStatusRetweetedFrame *retweetedFrame;

/** 微博数据 */
@property (nonatomic, strong) SNStatus *status;

/**
 *  自己的frame
 */
@property (nonatomic, assign) CGRect frame;
@end
