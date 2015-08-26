//
//  SNStatusTool.m
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusTool.h"

@implementation SNStatusTool


+ (void)homeStatusesWithParam:(SNHomeStatusesParam *)param success:(void (^)(SNHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [[NSString alloc] init];
    url = @"https://api.weibo.com/2/statuses/home_timeline.json";
    [self getWithUrl:url param:param resultClass:[SNHomeStatusesResult class] success:success failure:failure];
}

+ (void)sendStatusWithParam:(SNSendStatusParam *)param success:(void (^)(SNSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [[NSString alloc] init];
    url = @"https://api.weibo.com/2/statuses/update.json";
    [self postWithUrl:url param:param resultClass:[SNSendStatusResult class] success:success failure:failure];
}

@end
