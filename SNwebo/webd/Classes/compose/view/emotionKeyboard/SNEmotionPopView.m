//
//  SNEmotionPopView.m
//  webd
//
//  Created by 普伴 on 15/10/9.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import "SNEmotionPopView.h"
#import "SNEmotionView.h"
@interface SNEmotionPopView ()

@property (weak, nonatomic) IBOutlet SNEmotionView *emotionView;

@end


@implementation SNEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"SNEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)showFromEmotionView:(SNEmotionView *)fromEmotionView
{
    if (fromEmotionView == nil) {
        return;
    }
    
    // 1.显示表情
    self.emotionView.emotion = fromEmotionView.emotion;
    
    // 2.添加到窗口上
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    // 3.设置位置
    CGFloat centerX = fromEmotionView.centerX;
    CGFloat centerY = fromEmotionView.centerY - self.height * 0.5;
    CGPoint center = CGPointMake(centerX, centerY);
    self.center = [window convertPoint:center fromView:fromEmotionView.superview];
}


- (void)dismiss
{
    [self removeFromSuperview];
}


- (void)drawRect:(CGRect)rect
{
    [[UIImage imageNamed:@"emoticon_keyboard_magnifier"] drawInRect:rect];
}
@end
