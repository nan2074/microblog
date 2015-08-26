//
//  SNTabBarViewController.h
//  网贷
//
//  Created by 普伴 on 15/8/10.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SNTabBarViewControllerDelegate <NSObject>
@optional
- (void)myAccountBtnclk;

@end


@interface SNTabBarViewController : UITabBarController


@property (weak, nonatomic) id<SNTabBarViewControllerDelegate> SNTabBarDelegate;

@end
