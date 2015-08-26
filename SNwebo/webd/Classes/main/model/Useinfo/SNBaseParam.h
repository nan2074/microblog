//
//  SNBaseParam.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNBaseParam : NSObject

// 采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得
@property (copy, nonatomic) NSString *access_token;

+(instancetype)param;
@end
