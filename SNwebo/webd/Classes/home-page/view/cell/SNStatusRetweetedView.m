//
//  SNStatusRetweetedView.m
//  webd
//
//  Created by 普伴 on 15/8/25.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusRetweetedView.h"
#import "SNStatusRetweetedFrame.h"
#import "SNStatus.h"
#import "SNUser.h"
#import "SNStatusPhotosView.h"
@interface SNStatusRetweetedView ()

// 昵称
@property (weak, nonatomic) UILabel *nameLabel;

// 正文
@property (weak, nonatomic) UILabel *textLabel;

// 配图
@property (weak, nonatomic) SNStatusPhotosView *photosView;
@end

@implementation SNStatusRetweetedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_retweet_background"];
        
        // 1.昵称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.textColor = SNColor(74, 102, 105);
        nameLabel.font = SNStatusRetweetedNameFont;
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 2.正文
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.font = SNStatusRetweetedTextFont;
        textLabel.numberOfLines = 0;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        // 3.配图
        SNStatusPhotosView *photosView = [[SNStatusPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
    }
    
    return self;
}

- (void)setRetWeetedFrame:(SNStatusRetweetedFrame *)retWeetedFrame
{
    _retWeetedFrame = retWeetedFrame;
    
    self.frame = retWeetedFrame.frame;
    
    // 取出微博数据
    SNStatus *retweetedStatus = retWeetedFrame.retweetedStatus;
    
    // 取出用户数据
    SNUser *user = retweetedStatus.user;
    
    // 1.昵称
    self.nameLabel.text = [NSString stringWithFormat:@"@%@",user.name];
    self.nameLabel.frame = retWeetedFrame.nameFrame;
    
    // 2.正文
    self.textLabel.text = retweetedStatus.text;
    self.textLabel.frame = retWeetedFrame.textFrame;
    
    // 3.配图相册
    if (retweetedStatus.pic_urls.count) {
        self.photosView.frame = retWeetedFrame.photosFrame;
        self.photosView.pic_urls = retweetedStatus.pic_urls;
        self.photosView.hidden = NO;
    }
    else
    {
        self.photosView.hidden = YES;
    }
}


@end
