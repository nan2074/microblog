//
//  SNHomeStatusesParam.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseParam.h"
@interface SNHomeStatusesParam : SNBaseParam

// 若指定此参数，则返回ID比since_id大的微博(即比since_id时间晚的微博)
@property (strong, nonatomic) NSNumber *since_id;

// 若指定此参数，则返回ID小于或等于max_id的微博
@property (strong, nonatomic) NSNumber *max_id;

// 单页返回的记录条数，最大不超过100，默认20
@property (strong, nonatomic) NSNumber *count;


@end
