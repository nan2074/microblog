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
#import "SNStatusPhotosView.h"

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
    
    // 3.配图相册
    CGFloat h = 0;
    if (retweetedStatus.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
        CGSize photoSize = [SNStatusPhotosView sizeWithPhotoCount:retweetedStatus.pic_urls.count];
        self.photosFrame = (CGRect){{photosX,photosY},photoSize};
        h = CGRectGetMaxY(self.photosFrame) + SNStatusCellInset;
    }
    else
    {
        h = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
    }

    // 自己
    CGFloat x = 0;
    CGFloat y = 0; // 高度 = 原创微博最大的Y值
    CGFloat w = SNScreenW;

    self.frame = CGRectMake(x, y, w, h);
}

@end
