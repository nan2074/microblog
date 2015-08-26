//
//  UIBarButtonItem+Extension.h
//  webd
//
//  Created by 普伴 on 15/8/12.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:(id)target action:(SEL)action;
@end
