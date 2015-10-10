//
//  SNEmotion.h
//  webd
//
//  Created by 普伴 on 15/10/8.
//  Copyright © 2015年 Puban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNEmotion : NSObject

// 表情文字描述
@property (copy, nonatomic) NSString *chs;

// 表情的png图片名
@property (copy, nonatomic) NSString *png;

// emoji表情编码
@property (copy, nonatomic) NSString *code;


// 表情存放的文件夹\目录
@property (copy, nonatomic) NSString *directory;
// emoji表情的字符
@property (copy, nonatomic) NSString *emoji;
@end
