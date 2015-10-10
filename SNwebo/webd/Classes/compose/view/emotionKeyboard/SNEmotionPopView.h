//
//  SNEmotionPopView.h
//  webd
//
//  Created by 普伴 on 15/10/9.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNEmotionView;
@interface SNEmotionPopView : UIView

+ (instancetype)popView;
// 显示表情弹出控件
- (void)showFromEmotionView:(SNEmotionView *)fromEmotionView;
- (void)dismiss;

@end
