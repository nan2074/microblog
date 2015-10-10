//
//  SNStatusDetailView.m
//  webd
//
//  Created by 普伴 on 15/8/25.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNStatusDetailView.h"
#import "SNStatusRetweetedView.h"
#import "SNStatusOriginalView.h"
#import "SNStatusDetailFrame.h"

@interface SNStatusDetailView ()

@property (weak, nonatomic) SNStatusOriginalView *originalView;
@property (weak, nonatomic) SNStatusRetweetedView *retweetedView;
@end


@implementation SNStatusDetailView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImage:@"timeline_card_top_background"];
        
        // 1.添加原创微博
        SNStatusOriginalView *originalView = [[SNStatusOriginalView alloc] init];
        [self addSubview:originalView];
        self.originalView = originalView;
        
        // 2.添加转发微博
        SNStatusRetweetedView *retweetedView = [[SNStatusRetweetedView alloc] init];
        [self addSubview:retweetedView];
        self.retweetedView = retweetedView;
    }
    return self;
}

- (void)setDetailFrame:(SNStatusDetailFrame *)detailFrame
{
    _detailFrame = detailFrame;
    self.frame = detailFrame.frame;
    
    // 1.原创微博的frame数据
    self.originalView.originalFrame = detailFrame.originalFrame;
    
    // 2.原创转发的frame数据
    self.retweetedView.retWeetedFrame = detailFrame.retweetedFrame;
}
@end
