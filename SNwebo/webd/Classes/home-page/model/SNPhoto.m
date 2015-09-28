//
//  SNPhoto.m
//  webd
//
//  Created by 邓世楠 on 15/8/18.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNPhoto.h"

@implementation SNPhoto


- (void)setThumbnail_pic:(NSString *)thumbnail_pic
{
    _bmiddle_pic = [thumbnail_pic copy];
    self.bmiddle_pic = [thumbnail_pic stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bniddle"];
}
@end
