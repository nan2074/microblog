//
//  SNBaseTool.m
//  webd
//
//  Created by 普伴 on 15/8/21.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseTool.h"
#import "MJExtension.h"
#import "SNHttpTool.h"
@implementation SNBaseTool


+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failute
{
    NSDictionary *params = [param keyValues];
    
    [SNHttpTool get:url params:params success:^(id responseObj) {
        if (success) {
            
            id result = [resultClass objectWithKeyValues:responseObj];
       
            success(result);
        }
    } failure:^(NSError * error) {
        
        if (failute) {
            
            failute(error);
        }
    }];
}

+ (void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failute
{
    NSDictionary *params = [param keyValues];
    
    [SNHttpTool post:url params:params success:^(id responseObj) {
        
        id result = [resultClass objectWithKeyValues:responseObj];
        success(result);
        
    } failure:^(NSError *error) {
        
        if (failute) {
            failute(error);
        }
    }];
}
@end
