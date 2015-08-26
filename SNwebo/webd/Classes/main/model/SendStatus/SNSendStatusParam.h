//
//  SNSendStatusParam.h
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNBaseParam.h"

@interface SNSendStatusParam : SNBaseParam

// 要发布的微博问呗内容，必须做URLlencode，内容不得超过140汉子
@property (copy, nonatomic) NSString *status;

@end
