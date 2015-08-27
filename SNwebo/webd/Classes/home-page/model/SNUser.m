//
//  SNUser.m
//  webd
//
//  Created by 邓世楠 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNUser.h"

@implementation SNUser

- (BOOL)isVip
{
    return self.mbtype > 2;
}
@end
