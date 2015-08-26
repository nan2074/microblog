//
//  SNTitleBtn.m
//  webd
//
//  Created by 普伴 on 15/8/14.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNTitleBtn.h"
#import "UIView+Extension.h"


@implementation SNTitleBtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 内部图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字对齐
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        // 文字颜色
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //字体
        self.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        // 高亮的适合不需要调整内部的图片为灰色
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

// 设置内部图标的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = self.height;
    CGFloat imageH = imageW;
    CGFloat imageX = self.width - imageW;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

// 设置内部文字frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleH = self.height;
    CGFloat titleW = self.width - self.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

// 设置标题
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    
    // 1.计算文字尺寸
    CGSize titleSize = [title sizeWithFont:self.titleLabel.font];
    
    // 2.计算按钮的宽度
    self.width = titleSize.width + self.height +10;

}

@end
