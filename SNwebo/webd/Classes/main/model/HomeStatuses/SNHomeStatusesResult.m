//
//  SNHomeStatusesResult.m
//  webd
//
//  Created by 普伴 on 15/8/24.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNHomeStatusesResult.h"
#import "MJExtension.h"
#import "SNStatus.h"


@implementation SNHomeStatusesResult

- (NSDictionary *)objectClassInArray
{
    return @{@"statuses":[SNStatus class]};
}

@end
