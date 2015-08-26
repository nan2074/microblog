//
//  SNStatus.m
//  webd
//
//  Created by 邓世楠 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatus.h"
#import "MJExtension.h"
#import "SNPhoto.h"

@implementation SNStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[SNPhoto class]};
}

@end
