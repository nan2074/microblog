//
//  HMEmotionToolbar.h
//  webd
//
//  Created by 普伴 on 15/10/8.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SNEmotionToolbar;
typedef enum {
    SNEmotionTypeRecent, // 最近
    SNEmotionTypeDefault, // 默认
    SNEmotionTypeEmoji, // Emoji
    SNEmotionTypeLxh // 浪小花

}SNEmotionType;


@protocol SNEmotionToolbarDelegate <NSObject>

@optional
- (void)emtionToolbar:(SNEmotionToolbar *)toolbar didSelectedButton:(SNEmotionType)emotionType;

@end
@interface SNEmotionToolbar : UIView

@property (weak, nonatomic) id<SNEmotionToolbarDelegate> emotionToolbarDelegate;
@end
