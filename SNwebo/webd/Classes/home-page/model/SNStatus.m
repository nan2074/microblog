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
#import "NSDate+Extension.h"

@implementation SNStatus

- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls":[SNPhoto class]};
}

- (NSString *)created_at
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    
    // 获得微博发布的具体时间
    NSDate *createDate = [fmt dateFromString:_created_at];
    
    // 判断是否为今年
    if (createDate.isThisYear) {
        if (createDate.isToday) {
            

            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) {
                return [NSString stringWithFormat:@"%d小时前",cmps.hour];
            }
        }
    }
    
    return 0;
}


- (void)setSource:(NSString *)source
{
    // 截取范围
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    
    // 开始截取
    NSString *subsource = [source substringWithRange:range];
    
    _source = [NSString stringWithFormat:@"来自%@",subsource];
}

@end
