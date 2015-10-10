//
//  SNEmotionTool.h
//  webd
//
//  Created by 普伴 on 15/10/9.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SNEmotion;
@interface SNEmotionTool : NSObject

// 默认表情
+ (NSArray *)defaultEmotions;

// emoji表情
+ (NSArray *)emojiEmotions;

// 浪小花表情
+ (NSArray *)lxhEmotions;

// 最近表情
+ (NSArray *)recentEmotions;

// 保存最近使用的表情
+ (void)addRecentEmotion:(SNEmotion *)emotion;
@end
