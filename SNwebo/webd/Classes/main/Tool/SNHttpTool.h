//
//  SNHttpTool.h
//  webd
//
//  Created by 普伴 on 15/8/21.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHttpTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请求成功后将功能写入到block中）
 *  @param failure 请求失败后的回调（将处理方式写入block中）
 */
+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id))success failure:(void(^)(NSError *))failure;

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *))failure;
@end
