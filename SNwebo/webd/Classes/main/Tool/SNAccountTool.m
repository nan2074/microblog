//
//  SNAccountTool.m
//  webd
//
//  Created by 普伴 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNAccountTool.h"
#import "SNAccount.h"

@implementation SNAccountTool


#define SNAccountFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]



+ (void)save:(SNAccount *)account
{
    // 归档
    // 确定账号的过期时间：账号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];

    [NSKeyedArchiver archiveRootObject:account toFile:SNAccountFilepath];
}

+ (SNAccount *)account
{
    // 读取帐号
    SNAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SNAccountFilepath];
    
    // 判断帐号是否已经过期
    NSDate *now = [NSDate date];
    
    if ([now compare:account.expires_time] != NSOrderedAscending) { // 过期
        account = nil;
    }
    return account;
}

/**
 NSOrderedAscending = -1L,  升序，越往右边越大
 NSOrderedSame, 相等，一样
 NSOrderedDescending 降序，越往右边越小
 */

+ (void)accessTokenWithParam:(SNAccessTokenParam *)param success:(void (^)(SNAccount *))success failure:(void (^)(NSError *))failure
{
    NSString *url = [[NSString alloc] init];
    url = @"https://api.weibo.com/oauth2/access_token";
    [self postWithUrl:url param:param resultClass:[SNAccount class] success:success failure:failure];
}
@end
