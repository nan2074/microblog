//
//  SNStatusOriginalView.m
//  webd
//
//  Created by 普伴 on 15/8/25.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusOriginalView.h"
#import "SNStatusOriginalFrame.h"
#import "SNStatus.h"
#import "SNUser.h"
#import "UIImageView+WebCache.h"
#import "SNStatusPhotosView.h"
@interface SNStatusOriginalView ()

// 昵称
@property (weak, nonatomic) UILabel *nameLabel;

// 正文
@property (weak, nonatomic) UILabel *textlabel;

// 来源
@property (weak, nonatomic) UILabel *sourceLabel;

// 时间
@property (weak, nonatomic) UILabel *timeLabel;

// 头像
@property (weak, nonatomic) UIImageView *iconView;

// 会员图标
@property (weak, nonatomic) UIImageView *vipView;

// 配图相册
@property (weak, nonatomic) SNStatusPhotosView *photosView;

@end



@implementation SNStatusOriginalView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = SNStatusOrginalNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文（内容）
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = SNStatusOrginalTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textlabel = textLabel;
        
        // 3.时间
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.textColor = [UIColor orangeColor];
        timeLabel.font = SNStatusOrginalTimeFont;
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        // 4.来源
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.textColor = [UIColor lightGrayColor];
        sourceLabel.font = SNStatusOrginalSourceFont;
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        // 5.头像
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        // 6.会员图标
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        // 7.配图相册
        SNStatusPhotosView *photosView = [[SNStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    return self;
}

- (void)setOriginalFrame:(SNStatusOriginalFrame *)originalFrame
{
    _originalFrame = originalFrame;
    self.frame = originalFrame.frame;
    
    // 取出微博数据
    SNStatus *status = originalFrame.status;
    
    // 取出用户数据
    SNUser *user = status.user;
    
    // 1.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = originalFrame.nameFrame;
    if (user.isVip) {
        self.nameLabel.textColor = [UIColor orangeColor];
        self.vipView.hidden = NO;
        self.vipView.frame = originalFrame.vipFrame;
        self.vipView.image = [UIImage imageNamed:[NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank]];
    }
    else {
        self.vipView.hidden = YES;
        self.nameLabel.textColor = [UIColor blackColor];
    }
    
    // 2.正文
    self.textlabel.text = status.text;
    self.textlabel.frame = originalFrame.textFrame;
    
    // 3.时间
    NSString *time = status.created_at;
    self.timeLabel.text = time;
    CGFloat timeX = CGRectGetMinX(self.nameLabel.frame);
    CGFloat timeY = CGRectGetMaxY(self.nameLabel.frame) + SNStatusCellInset * 0.5;
    CGSize timeSize = [time sizeWithFont:SNStatusOrginalTimeFont];
    self.timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
   
    
    // 4.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + SNStatusCellInset;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SNStatusOrginalSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    
    // 5.头像
    self.iconView.frame = originalFrame.iconFrame;
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 6.配图相册
    if (status.pic_urls.count) {
        self.photosView.frame = originalFrame.photosFrame;
        self.photosView.pic_urls = status.pic_urls;
        self.photosView.hidden = NO;
       
    }
    else
    {
        self.photosView.hidden = YES;
    }
    
    
}


@end
