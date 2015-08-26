//
//  SNComposePhotosView.h
//  webd
//
//  Created by 普伴 on 15/8/20.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNComposePhotosView : UIView


/**
 *  添加新的突破
 */
- (void)addImage:(UIImage *)image;
- (NSArray *)images;
@end
