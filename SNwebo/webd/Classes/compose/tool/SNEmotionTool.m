//
//  SNEmotionTool.m
//  webd
//
//  Created by 普伴 on 15/10/9.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import "SNEmotionTool.h"
#import "SNEmotion.h"
#import "MJExtension.h"

#define SNRecentFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"recent_emotions.data"]


@implementation SNEmotionTool

/** 默认表情 */
static NSArray *_defaultEmotions;
/** emoji表情 */
static NSArray *_emojiEmotions;
/** 浪小花表情 */
static NSArray *_lxhEmotions;
/** 最近表情 */
static NSMutableArray *_recentEmotions;

+ (NSArray *)defaultEmotions
{
    if (!_defaultEmotions) {
        NSString *plist = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defaultEmotions = [SNEmotion objectArrayWithFile:plist];
        [_defaultEmotions makeObjectsPerformSelector:@selector(setDirection:) withObject:@"EmotionIcons/default"];
    }
    return _defaultEmotions;
}
@end
