//
//  SNAccountTool.h
//  webd
//
//  Created by 普伴 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SNAccessTokenParam.h"
#import "SNBaseTool.h"

@class SNAccount;

@interface SNAccountTool : SNBaseTool

/**
 *  存储账号
 */
+ (void)save:(SNAccount *)account;
/**
 *  读取账号
 */
+ (SNAccount *)account;

+ (void)accessTokenWithParam:(SNAccessTokenParam *)param success:(void (^)(SNAccount *account))success failure:(void(^)(NSError *error))failure;
@end
