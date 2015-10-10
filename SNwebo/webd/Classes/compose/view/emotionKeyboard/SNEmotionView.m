//
//  SNEmotionView.m
//  webd
//
//  Created by 普伴 on 15/10/9.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import "SNEmotionView.h"
#import "SNEmotion.h"


@implementation SNEmotionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.adjustsImageWhenHighlighted = NO;
    }
    return self;
}

- (void)setEmotion:(SNEmotion *)emotion
{
    _emotion = emotion;
    if (emotion.code) {
        // 取消动画效果
        [UIView setAnimationsEnabled:NO];
        
        // 设置emoji表情
        self.titleLabel.font = [UIFont systemFontOfSize:32];
        [self setTitle:emotion.emoji forState:UIControlStateNormal];
        [self setImage:nil forState:UIControlStateNormal];
        
        // 再次开启动画
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView setAnimationsEnabled:YES];
            
        });
    }
    else {
        NSString *icon = [NSString stringWithFormat:@"%@/%@",emotion.directory,emotion.png];
        UIImage *image = [UIImage imageNamed:icon];
        
        [self setImage:image forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

@end
