//
//  SNStatusTool.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseTool.h"
#import "SNHomeStatusesParam.h"
#import "SNHomeStatusesResult.h"
#import "SNSendStatusParam.h"
#import "SNSendStatusResult.h"



@interface SNStatusTool : SNBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParam:(SNHomeStatusesParam *)param success:(void(^)(SNHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发没有图片的微博
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)sendStatusWithParam:(SNSendStatusParam *)param success:(void (^)(SNSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
