//
//  SNHomeStatusesResult.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNHomeStatusesResult : NSObject


// 微博数组（装着SNStatus模型）
@property (strong, nonatomic) NSArray *statuses;

// 近期的微博总数
@property (assign, nonatomic) int total_number;
@end
