//
//  WMOtherViewController.m
//  QQSlideMenu
//
//  Created by wamaker on 15/6/14.
//  Copyright (c) 2015年 wamaker. All rights reserved.
//

#import "SNOtherViewController.h"

@interface SNOtherViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation SNOtherViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.label.text = self.navTitle;
    self.navigationItem.title = self.navTitle;
}

@end
