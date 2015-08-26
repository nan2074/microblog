//
//  SNPopMenu.m
//  webd
//
//  Created by 普伴 on 15/8/17.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNPopMenu.h"

@interface SNPopMenu ()

@property (strong, nonatomic) UIView *contentView;

/**
 *  最底部的遮盖：屏蔽除菜单意外的控件事件
 */
@property (weak, nonatomic) UIButton *cover;

/**
 *  容器：容纳具体要显示内容contentView
 */
@property (weak, nonatomic) UIImageView *container;

@end



@implementation SNPopMenu


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /**
         *  添加才难内部的2个子空间
         */
        
        //添加一个遮盖按钮
        UIButton *cover = [[UIButton alloc] init];
        cover.backgroundColor = [UIColor clearColor];
        
        [cover addTarget:self action:@selector(coverClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cover];
        self.cover = cover;
        
        // 添加带箭头的菜单图片
        UIImageView *container = [[UIImageView alloc] init];
        container.userInteractionEnabled = YES;
        [self addSubview:container];
        self.container = container;
        
        // 默认箭头指向中间
        self.arrowPosition = SNPopMenuArrowPositionCenter;
    }
    return self;
}

- (instancetype)initWithContentView:(UIView *)contentView
{
    if (self = [super init]) {
        self.contentView = contentView;
    }
    return self;
}

+ (instancetype)popMenWithContentView:(UIView *)contentView
{
    return [[self alloc] initWithContentView:contentView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.cover.frame = self.bounds;
}

- (void)coverClick
{
   
    [self dismiss];
}


- (void)setDimBackground:(BOOL)dimBackground
{
    _dimBackground = dimBackground;
    if (dimBackground) {
        self.cover.backgroundColor = [UIColor blackColor];
        self.cover.alpha = 0.3;
    }
    else {
    
        self.cover.backgroundColor = [UIColor clearColor];
        self.cover.alpha = 1.0;
        
    }
}

- (void)setArrowPosition:(SNPopMenuArrowPosition)arrowPosition
{
    _arrowPosition = arrowPosition;
    switch (arrowPosition) {
        case SNPopMenuArrowPositionCenter:
            self.container.image = [UIImage resizedImage:@"popover_background"];
            break;
        case SNPopMenuArrowPositionLeft:
            self.container.image = [UIImage resizedImage:@"popover_background_left"];
            break;
        case SNPopMenuArrowPositionRight:
            self.container.image = [UIImage resizedImage:@"popover_background_right"];
            break;
        default:
            break;
    }
}

- (void)setBackground:(UIImage *)background
{
    self.container.image = background;
}

- (void)showInRect:(CGRect)rect
{

    
    // 添加菜单整体到窗口身上
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.frame = window.bounds;

    [window addSubview:self];
    
    // 设置容器的frame
    self.container.frame = rect;
    [self.container addSubview:self.contentView];
    
    // 设置容器里面内容的frame
    CGFloat topMargin = 12;
    CGFloat leftMargin = 5;
    CGFloat rightMargin = 5;
    CGFloat bottomMargin = 8;
    
    CGFloat width = self.container.width - leftMargin - rightMargin;
    CGFloat height = self.container.frame.size.height - topMargin - bottomMargin;
    self.contentView.frame = CGRectMake(leftMargin, topMargin, width, height);
}

- (void)dismiss
{
    if ([self.delegate respondsToSelector:@selector(popMenuDidDismissed:)]) {
        [self.delegate popMenuDidDismissed:self];
    }
    
    [self removeFromSuperview];
}


@end
