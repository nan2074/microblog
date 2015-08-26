//
//  SNPopMenu.h
//  webd
//
//  Created by 普伴 on 15/8/17.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    SNPopMenuArrowPositionCenter = 0,
    SNPopMenuArrowPositionLeft,
    SNPopMenuArrowPositionRight

}SNPopMenuArrowPosition;

@class SNPopMenu;

@protocol SNPopMenuDelegate <NSObject>

@optional
- (void)popMenuDidDismissed:(SNPopMenu *)popMenu;

@end


@interface SNPopMenu : UIView

@property (assign, nonatomic, getter=isDimBackground) BOOL dimBackground;
@property (assign, nonatomic) SNPopMenuArrowPosition arrowPosition;
@property (weak, nonatomic) id<SNPopMenuDelegate> delegate;


/**
 *  初始化方法
 */
- (instancetype)initWithContentView:(UIView *)contentView;
+ (instancetype)popMenWithContentView:(UIView *)contentView;


/**
 *  设置菜单的背景图片
 */
- (void)setBackground:(UIImage *)background;

/**
 *  显示菜单
 */
- (void)showInRect:(CGRect)rect;

/**
 *  关闭菜单
 */
- (void)dismiss;
@end
