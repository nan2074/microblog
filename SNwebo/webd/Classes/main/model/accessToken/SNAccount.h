//
//  SNAccount.h
//  webd
//
//  Created by 普伴 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNAccount : NSObject<NSCoding>

/**
 *  用于调用access_token，借款获得授权后的access_token
 */
@property (copy, nonatomic) NSString *access_token;

/**
 *  用于存放access_token的生命周期
 */
@property (copy, nonatomic) NSString *expires_in;

/**
 *  过期时间
 */
@property (strong, nonatomic) NSDate *expires_time;

/**
 *  当前授权UID
 */
@property (copy, nonatomic) NSString *uid;

/**
 *  用户昵称
 */
@property (copy, nonatomic) NSString *name;


+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
