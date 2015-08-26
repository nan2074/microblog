//
//  SNNavigationViewController.h
//  网贷
//
//  Created by 普伴 on 15/8/10.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SNNavigationViewControllerDelegate <NSObject>

@optional
- (void)myAccountBtnclk;

@end

@interface SNNavigationViewController : UINavigationController

@property (weak, nonatomic) id<SNNavigationViewControllerDelegate> SNNavDelegate;
@end





