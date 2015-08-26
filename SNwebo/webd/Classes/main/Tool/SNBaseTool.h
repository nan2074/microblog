//
//  SNBaseTool.h
//  webd
//
//  Created by 普伴 on 15/8/21.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNBaseTool : NSObject



+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failute;

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void(^)(id))success failure:(void(^)(NSError *))failute;


@end
