//
//  SNStatusPhotoView.m
//  webd
//
//  Created by 普伴 on 15/9/6.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusPhotoView.h"
#import "SNPhoto.h"
#import "UIImageView+WebCache.h"

@interface SNStatusPhotoView ()

@property (weak, nonatomic) UIImageView *gifview;
@end
@implementation SNStatusPhotoView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
        
        // 添加一个gif图标
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        // 这种情况下创建的UIImageView的尺寸跟图片尺寸一样
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifview = gifView;
    }
    
    return self;
}

- (void)setPhoto:(SNPhoto *)photo
{
    _photo = photo;
    
    // 1.下载图片
    [self setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 2.控制gif图标的现实
    NSString *extension = photo.thumbnail_pic.pathExtension.lowercaseString;
    self.gifview.hidden = ![extension isEqualToString:@"gif"];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifview.x = self.width - self.gifview.width;
    self.gifview.y = self.height - self.gifview.height;
}

@end
