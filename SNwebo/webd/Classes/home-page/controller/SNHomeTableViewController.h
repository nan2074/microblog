//
//  SNHomeTableViewController.h
//  网贷
//
//  Created by 普伴 on 15/8/10.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SNHomeTableViewControllerDelegate <NSObject>
@optional
- (void)myAccountBtnclk;

@end

@interface SNHomeTableViewController : UITableViewController

@property (weak, nonatomic) id<SNHomeTableViewControllerDelegate> SNHomeDelegate;

- (void)refresh:(BOOL)fromSelf;

@end

