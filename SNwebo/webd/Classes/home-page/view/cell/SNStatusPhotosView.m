//
//  SNStatusPhotosView.m
//  webd
//
//  Created by 普伴 on 15/9/6.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusPhotosView.h"
#import "SNStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "SNPhoto.h"

#import "MJPhoto.h"
#import "MJPhotoBrowser.h"



#define SNStatusPhotosMaxCount 9
#define SNStatusPhotosMaxCols(photosCount) ((photosCount==4) ? 2:3)
#define SNStatusPhotoW 70
#define SNStatusPhotoH SNStatusPhotoW
#define SNStatusPhotoMargin 10



@interface SNStatusPhotosView ()


@end

@implementation SNStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 预先创建9个图片控件
        for (int i=0; i<SNStatusPhotosMaxCount; i++) {
            
            SNStatusPhotoView *photoView = [[SNStatusPhotoView alloc] init];
            photoView.tag = i;
            [self addSubview:photoView];
            
            // 添加手势监听器（一个手势监听器只能监听一对应的view）
            UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] init];
            [recognizer addTarget:self action:@selector(tapPhoto:)];
            [photoView addGestureRecognizer:recognizer];
        }
    }
    return self;
}


/**
 *  监听图片点击
 */
- (void)tapPhoto:(UITapGestureRecognizer *)recognizer
{
    // 1.创建图片浏览器
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    // 2.设置图片浏览器显示所有图片
    NSMutableArray *photos = [NSMutableArray array];
    NSInteger count = self.pic_urls.count;
    for (int i=0; i<count; i++) {
        SNPhoto *pic = self.pic_urls[i];
        
        MJPhoto *photo = [[MJPhoto alloc] init];
        // 设置图片的路径
        photo.url = [NSURL URLWithString:pic.bmiddle_pic];
        // 设置来源于哪一个UIIMageView
        photo.srcImageView = self.subviews[i];
        [photos addObject:photo];
    }
    browser.photos = photos;
    
    // 3.设置默认显示的图片索引
    browser.currentPhotoIndex = recognizer.view.tag;
    
    // 4.显示浏览器
    [browser show];
}

- (void)setPic_urls:(NSArray *)pic_urls
{
    _pic_urls = pic_urls;
    
    for (int i=0; i<SNStatusPhotosMaxCount; i++) {
        SNStatusPhotoView *photoView = self.subviews[i];
        
        if (i <pic_urls.count) {
            photoView.photo = pic_urls[i];
            photoView.hidden = NO;
        }
        else
        {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger count = self.pic_urls.count;
    NSInteger maxCols = SNStatusPhotosMaxCols(count);
    for (int i=0 ; i<count; i++) {
        SNStatusPhotoView *photoView = self.subviews[i];
        photoView.width = SNStatusPhotoW;
        photoView.height = SNStatusPhotoH;
        
        photoView.x = (i % maxCols) * (SNStatusPhotoW + SNStatusPhotoMargin);
        photoView.y = (i / maxCols) * (SNStatusPhotoH + SNStatusPhotoMargin);
    }
}

+ (CGSize)sizeWithPhotoCount:(NSInteger)photoCount
{
    NSInteger maxCols = SNStatusPhotosMaxCols(photoCount);
    
    // 总列数
    NSInteger totalCols = photoCount >= maxCols ? maxCols : photoCount;
    
    // 总行数
    NSInteger totalRows = (photoCount + maxCols - 1) / maxCols;
    
    // 计算尺寸
    CGFloat photoW = totalCols * SNStatusPhotoW + (totalCols - 1) * SNStatusPhotoMargin;
    CGFloat photoH = totalRows * SNStatusPhotoH + (totalRows - 1) * SNStatusPhotoMargin;
    
    return CGSizeMake(photoW, photoH);
}

@end
