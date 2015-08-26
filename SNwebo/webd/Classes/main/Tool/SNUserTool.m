//
//  SNUserTool.m
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNUserTool.h"
#import "MJExtension.h"
#import "SNHttpTool.h"

@implementation SNUserTool


+ (void)userInfoWithParam:(SNUserInfoParam *)param success:(void (^)(SNUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [[NSString alloc] init];
    url = @"https://api.weibo.com/2/users/show.json";
    [self getWithUrl:url param:param resultClass:[SNUserInfoResult class] success:success failure:failure];
}

+ (void)unreadCountWithParam:(SNUnreadCountParam *)param success:(void (^)(SNUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    
    NSString *url = [[NSString alloc] init];
    url = @"https://rm.api.weibo.com/2/remind/unread_count.json";
    [self getWithUrl:url param:param resultClass:[SNUnreadCountResult class] success:success failure:failure];

}
@end
