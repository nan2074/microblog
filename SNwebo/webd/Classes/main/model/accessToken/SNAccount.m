//
//  SNAccount.m
//  webd
//
//  Created by 普伴 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNAccount.h"

@implementation SNAccount



+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    SNAccount *account = [[self alloc] init];
    
    account.access_token = dict[@"access_token"];
    account.expires_in   = dict[@"expires_in"];
    account.expires_time = dict[@"uid"];
    
    // 确定账号的过期时间：账号创建时间 + 有效期
    NSDate *now = [NSDate date];
    account.expires_time = [now dateByAddingTimeInterval:account.expires_in.doubleValue];
    return account;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in   = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid         = [aDecoder decodeObjectForKey:@"uid"];
        self.expires_time = [aDecoder decodeObjectForKey:@"expires_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in   forKey:@"expires_in"];
    [aCoder encodeObject:self.uid         forKey:@"uid"];
    [aCoder encodeObject:self.expires_time forKey:@"expires_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}
@end
