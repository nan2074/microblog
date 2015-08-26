//
//  SNComposePhotosView.m
//  webd
//
//  Created by 普伴 on 15/8/20.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNComposePhotosView.h"

@implementation SNComposePhotosView

- (void)addImage:(UIImage *)image
{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.image = image;
    [self addSubview:imageView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger count = self.subviews.count;
    
    // 一行最大列数
    int maxColsPerRow = 4;
    
    // 每个图片之间的距离
    CGFloat margin = 10;
    
    // 每个图片的宽高
    CGFloat imageViewW = (self.width - (maxColsPerRow + 1) * margin) / maxColsPerRow;
    CGFloat imageViewH = imageViewW;
    
    for (int i = 0; i<count; i++) {
        // 行号
        int row = i / maxColsPerRow;
        
        // 列号
        int col = i % maxColsPerRow;
        
        UIImageView *imageView = self.subviews[i];
        imageView.width = imageViewW;
        imageView.height = imageViewH;
        imageView.y = row * (imageViewH + margin);
        imageView.x = col * (imageViewW + margin);
    }
    
}

- (NSArray *)images
{
    NSMutableArray *array = [NSMutableArray array];
    for (UIImageView *imageView in self.subviews) {
        [array addObject:imageView.image];
    }
    
    return array;
}



@end
