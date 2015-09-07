//
//  SNStatusOriginalFrame.m
//  黑马微博
//
//  Created by apple on 14-7-14.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "SNStatusOriginalFrame.h"
#import "SNStatus.h"
#import "SNUser.h"
#import "SNStatusPhotosView.h"
@implementation SNStatusOriginalFrame

- (void)setStatus:(SNStatus *)status
{
    _status = status;

    // 1.头像
    CGFloat iconX = SNStatusCellInset;
    CGFloat iconY = SNStatusCellInset;
    CGFloat iconW = 35;
    CGFloat iconH = 35;
    self.iconFrame = CGRectMake(iconX, iconY, iconW, iconH);
    
    // 2.昵称
    CGFloat nameX = CGRectGetMaxX(self.iconFrame) + SNStatusCellInset;
    CGFloat nameY = iconY;
//    CGSize nameSize = [status.user.name sizeWithFont:SNStatusOrginalNameFont];
    CGSize nameSize = [status.user.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];

    self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
    
    if (status.user.isVip) { // 计算会员图标的位置
        CGFloat vipX = CGRectGetMaxX(self.nameFrame) + SNStatusCellInset;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = vipH;
        self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    // 3.正文
    CGFloat textX = iconX;
    CGFloat textY = CGRectGetMaxY(self.iconFrame) + SNStatusCellInset;
    CGFloat maxW = SNScreenW - 2 * textX;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    CGSize textSize = [status.text sizeWithFont:SNStatusOrginalTextFont constrainedToSize:maxSize];
    self.textFrame = (CGRect){{textX, textY}, textSize};
    
    // 4.配图相册
    CGFloat h = 0;
    if (status.pic_urls.count) {
        CGFloat photosX = textX;
        CGFloat photosY = textY;
        CGSize photoSize = [SNStatusPhotosView sizeWithPhotoCount:status.pic_urls.count];
        self.photosFrame = (CGRect){{photosX,photosY},photoSize};
        h = CGRectGetMaxY(self.photosFrame) + SNStatusCellInset;
    }
    else
    {
        h = CGRectGetMaxY(self.textFrame) + SNStatusCellInset;
    }
    
    // 自己
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = SNScreenW;
  
    self.frame = CGRectMake(x, y, w, h);
}

@end
