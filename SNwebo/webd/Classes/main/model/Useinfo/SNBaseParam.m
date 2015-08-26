//
//  SNBaseParam.m
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseParam.h"
#import "SNAccount.h"
#import "SNAccountTool.h"


@implementation SNBaseParam


- (instancetype)init
{
    if (self = [super init]) {
        self.access_token = [SNAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end
