//
//  SNTabBar.h
//  webd
//
//  Created by 普伴 on 15/8/11.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SNTabBar;

@protocol SNTabBarDelegate <NSObject>

@optional
- (void)tabBarDidClickedPlusButton:(SNTabBar *)tabBar;

@end

@interface SNTabBar : UITabBar
@property (nonatomic, weak) id<SNTabBarDelegate> tabBarDelegate;
@end

