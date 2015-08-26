//
//  SNUnreadCountResult.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNUnreadCountResult : NSObject


/**
 *  新微博未读数
 */
@property (assign, nonatomic) int status;

/**
 *  新粉丝数
 */
@property (assign, nonatomic) int follower;

/**
 *  新评论数
 */
@property (assign, nonatomic) int comment;

/**
 *  新私信数
 */
@property (assign, nonatomic) int dm;

/**
 *  新提及我的微博数
 */
@property (assign, nonatomic) int mention_cmt;

/**
 *  新提及我的评论数
 */
@property (assign, nonatomic) int mention_status;

/**
 *  消息未读数
 */
- (int)messageCount;

/**
 *  所有未读数
 */
- (int)totalCount;
@end
