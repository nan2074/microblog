//
//  SNUserTool.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseTool.h"
#import "SNUserInfoParam.h"
#import "SNUserInfoResult.h"
#import "SNUnreadCountParam.h"
#import "SNUnreadCountResult.h"

@interface SNUserTool : SNBaseTool
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调（请求成功后将要做的事情写在block中）
 *  @param failure 请求失败后的回调（请求成功后将要做的事情写在block中）
 */
+ (void)userInfoWithParam:(SNUserInfoParam *)param success:(void (^)(SNUserInfoResult *result))success failure:(void(^)(NSError *error))failure;

+ (void)unreadCountWithParam:(SNUnreadCountParam *)param success:(void(^)(SNUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
