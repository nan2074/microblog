//
//  SNStatusPhotosView.h
//  webd
//
//  Created by 普伴 on 15/9/6.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNStatusPhotosView : UIView
/**
 *  图片数据（里面都是SNphoto模型）
 */
@property (strong, nonatomic) NSArray *pic_urls;

/**
 *  根据照片格式计算相册的最终尺寸
 */
+ (CGSize)sizeWithPhotoCount:(NSInteger)photoCount;
@end
