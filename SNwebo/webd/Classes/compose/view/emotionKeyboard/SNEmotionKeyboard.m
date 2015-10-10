//
//  SNEmotionKeyboard.m
//  webd
//
//  Created by 普伴 on 15/10/8.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import "SNEmotionKeyboard.h"
#import "SNEmotionListView.h"
#import "SNEmotionToolbar.h"
#import "MJExtension.h"
#import "SNEmotion.h"

@interface SNEmotionKeyboard ()<SNEmotionToolbarDelegate>


// 表情列表
@property (weak, nonatomic) SNEmotionListView *listView;

// 表情工具条
@property (weak, nonatomic) SNEmotionToolbar *toolbar;

// 默认表情
@property (strong, nonatomic) NSArray *defaultEmotions;

// emoji表情
@property (strong, nonatomic) NSArray *emojiEmotions;

// 浪小花表情
@property (strong, nonatomic) NSArray *lxhEmotions;
@end

@implementation SNEmotionKeyboard


- (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultEmotions = [SNEmotion objectArrayWithFile:plist];
    }
    return _defaultEmotions;
}

- (NSArray *)emojiEmotions
{
    if (!_emojiEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiEmotions = [SNEmotion objectArrayWithFile:plist];
    }
    return _emojiEmotions;

}

- (NSArray *)lxhEmotions
{
    if (!_lxhEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhEmotions = [SNEmotion objectArrayWithFile:plist];
    }
    return _lxhEmotions;

}

+ (instancetype)keyboard
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"emoticon_keyboard_background"]];
        
        // 1.添加表情列表
        SNEmotionListView *listView = [[SNEmotionListView alloc] init];
        [self addSubview:listView];
        self.listView = listView;
        
        // 2.添加表情工具条
        SNEmotionToolbar *toolbar = [[SNEmotionToolbar alloc] init];
        toolbar.emotionToolbarDelegate = self;
        [self addSubview:toolbar];
        self.toolbar = toolbar;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置工具条Frame
    self.toolbar.width = self.width;
    self.toolbar.height = 35;
    self.toolbar.y = self.height - self.toolbar.height;
    
    // 2.设置表情列表的frame
    self.listView.width = self.width;
    self.listView.height = self.toolbar.y;
}

- (void)emtionToolbar:(SNEmotionToolbar *)toolbar didSelectedButton:(SNEmotionType)emotionType
{
    switch (emotionType) {
        case SNEmotionTypeDefault:
            self.listView.emotions = self.defaultEmotions;
            break;
            
        case SNEmotionTypeEmoji:
            self.listView.emotions = self.emojiEmotions;
            break;

            
        case SNEmotionTypeLxh:
            self.listView.emotions = self.lxhEmotions;
            break;
        default:
            break;
    }
}
@end
