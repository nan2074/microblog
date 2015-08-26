//
//  WMMenuViewController.h
//  QQSlideMenu
//
//  Created by wamaker on 15/6/12.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SNMenuViewControllerDelegate <NSObject>
@optional
- (void)didSelectItem:(NSString *)title;

@end

@interface SNMenuViewController : UIViewController
@property (weak, nonatomic) id<SNMenuViewControllerDelegate> delegate;

@end
