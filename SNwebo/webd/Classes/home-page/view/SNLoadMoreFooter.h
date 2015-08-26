//
//  SNLoadMoreFooter.h
//  webd
//
//  Created by 普伴 on 15/8/19.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNLoadMoreFooter : UIView



//+ (instancetype)footer;

- (void)beginRefreshing;
- (void)endRefreshing;

@property (assign, nonatomic, getter=isRefreshing) BOOL refreshing;
@end
