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
            if (cmps.hour >= 1) { // 至少是一个小时前发的
                return [NSString stringWithFormat:@"%lu小时前",cmps.hour];
            }
            else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%lu分钟前",cmps.minute];
            }
            else {
                // 1分钟前发的
                return @"刚刚";
            }
        }
        else if (createDate.isYesterday) {
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }
        else {
            fmt.dateFormat = @"yyyy-MM-dd";
            return [fmt stringFromDate:createDate];
        }
    }
    else {
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
    

}


- (void)setSource:(NSString *)source
{
    if (source.length == 0) {
        return;
    }
  
    // 截取范围
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location - range.location;
    

    // 开始截取
    NSString *subsource = [source substringWithRange:range];
    
    
    _source = [NSString stringWithFormat:@"来自%@",subsource];
}

@end
