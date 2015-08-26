//
//  SNStatusRetweetedFrame.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SNStatusRetweetedFrame.h"
#import "SNStatus.h"
#import "SNUser.h"

@implementation SNStatusRetweetedFrame

- (void)setRetweetedStatus:(SNStatus *)retweetedStatus
{
    _retweetedStatus = retweetedStatus;
    
    // 1.昵称
    CGFloat nameX = SNStatusCellInset;
    CGFloat nameY = SNStatusCellInset * 0.5;
    NSString *name = [NSString stringWithFormat:@"@%@", retweetedStatus.user.name];
    CGSize nameSize = [name sizeWithFont:SNStatusRetweetedNameFont];
    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    // 2.正文
    CGFloat textX = nameX;
    CGFloat textY = CGRectGetMaxY(self.nameFrame) + SNStatusCellInset * 0.5;
    CGFloat maxW = SNScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [retweetedStatus.text sizeWithFont:SNStatusRetweetedTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = SNScreenW;
    CGFloat h = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
    self.frame = CGRectMake(x, y, w, h);
}

@end
