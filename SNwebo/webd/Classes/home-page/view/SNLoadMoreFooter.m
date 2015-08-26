//
//  SNLoadMoreFooter.m
//  webd
//
//  Created by 普伴 on 15/8/19.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNLoadMoreFooter.h"

@interface SNLoadMoreFooter ()

@property (weak, nonatomic) UILabel *statusLabel;
@property (weak, nonatomic) UIActivityIndicatorView *loadingView;

@end



@implementation SNLoadMoreFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        
      
        
        UILabel *statusLabel = [[UILabel alloc] init];
        statusLabel.textColor = [UIColor blackColor];
        statusLabel.textAlignment = NSTextAlignmentCenter;
        self.statusLabel = statusLabel;
        
        [self addSubview:self.statusLabel];
        
        
        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] init];
        self.loadingView = loadingView;
        [self addSubview:self.loadingView];
      
        self.backgroundColor = [UIColor orangeColor];
        
    }

    
    return self;
    
}
- (void)layoutSubviews
{
    
    [super layoutSubviews];

    
    self.statusLabel.width = self.width;
    self.statusLabel.height = self.height;
    
    
    self.loadingView.x = 280;
    self.loadingView.y = 12;
    self.loadingView.center = CGPointMake(self.width * 0.87, self.height * 0.5);

}

- (void)beginRefreshing
{
    self.statusLabel.text = @"正在拼命加载更多数据...";
    [self.loadingView startAnimating];
    self.refreshing = YES;
}

- (void)endRefreshing
{
    self.statusLabel.text = @"上拉加载更多数据";
    [self.loadingView stopAnimating];
    self.refreshing = NO;
}

@end
