//
//  HMEmotionToolbar.m
//  webd
//
//  Created by 普伴 on 15/10/8.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import "SNEmotionToolbar.h"

@interface SNEmotionToolbar ()

// 记录当前选中按钮
@property (weak, nonatomic) UIButton *selectedButton;
@end


@implementation SNEmotionToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.添加四个按钮
        [self setupButton:@"最近" tag:SNEmotionTypeRecent];
        [self setupButton:@"Emoji" tag:SNEmotionTypeEmoji];
        [self setupButton:@"浪小花" tag:SNEmotionTypeLxh];
        UIButton *defaultButton = [self setupButton:@"默认" tag:SNEmotionTypeDefault];
        
        // 2.默认选中“默认”按钮
        [self buttonClick:defaultButton];
    }
    return self;
}
#define SNEmotionToolbarButtonMaxCount 4
- (UIButton *)setupButton:(NSString *)title tag:(SNEmotionType)tag
{
    UIButton *button = [[UIButton alloc] init];
    button.tag = tag;
    
    // 文字
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:button];
    
    // 设置背景图片
    NSInteger count = self.subviews.count;
    if (count == 1) {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_left_selected"] forState:UIControlStateSelected];
    }
    else if (count == SNEmotionToolbarButtonMaxCount) {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_right_selected"] forState:UIControlStateSelected];
    }
    else
    {
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_normal"] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage resizedImage:@"compose_emotion_table_mid_selected"] forState:UIControlStateSelected];
    }
    
    return button;
}

- (void)buttonClick:(UIButton *)button
{
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    
    if ([self.emotionToolbarDelegate respondsToSelector:@selector(emtionToolbar:didSelectedButton:)]) {
        [self.emotionToolbarDelegate emtionToolbar:self didSelectedButton:button.tag];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat buttonW = self.width / SNEmotionToolbarButtonMaxCount;
    CGFloat buttonH = self.height;
    for (int i = 0; i<SNEmotionToolbarButtonMaxCount; i++) {
        UIButton *button = self.subviews[i];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
    }
}

@end
