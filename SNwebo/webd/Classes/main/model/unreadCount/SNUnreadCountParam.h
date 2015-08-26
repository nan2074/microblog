//
//  SNUnreadCountParam.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseParam.h"

@interface SNUnreadCountParam : SNBaseParam

// 需要查询的用户ID
@property (copy, nonatomic) NSString *uid;

@end
