//
//  SNNewfeatureViewController.m
//  webd
//
//  Created by 普伴 on 15/8/12.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNNewfeatureViewController.h"
#import "SNTabBarViewController.h"
#import "UIView+Extension.h"
#import "ViewController.h"

#define SNNewfeatureImageCount 4


@interface SNNewfeatureViewController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;

@end

@implementation SNNewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 1. 添加scrollView
    [self setupScrollView];
    // 2. 添加pageControl
    [self setupPageControl];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




// 添加scrollView
- (void)setupScrollView
{
    // 1.添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate =self;
    [self.view addSubview:scrollView];
    
    
    // 2.添加图片
    CGFloat imageW = scrollView.width;
    CGFloat imageH = scrollView.height;
    
 
    for (int i=0; i<SNNewfeatureImageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        NSString *imageName = [NSString stringWithFormat:@"new_feature_%d",i+1];
        
        imageView.image = [UIImage imageNamed:imageName];
        [scrollView addSubview:imageView];
        
        // 设置frame
        imageView.y = 0;
        imageView.width = imageW;
        imageView.height = imageH;
        imageView.x = i * imageW;
        
        if (i == SNNewfeatureImageCount-1) {
            [self setupLastImageView:imageView];
        }
    }
    
    // 3.设置其他属性
    scrollView.contentSize = CGSizeMake(SNNewfeatureImageCount*imageW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
//    scrollView.backgroundColor = [UIColor colorWithHue:246/255.0 saturation:246/255.0 brightness:246/255.0 alpha:1.0];
    
    scrollView.backgroundColor = [UIColor redColor];
    
}

// 添加pageControl
- (void)setupPageControl
{
    // 1.添加
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = SNNewfeatureImageCount;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height - 30;
    [self.view addSubview:pageControl];
    
    // 2.设置圆点的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithHue:253/255.0 saturation:98/255.0 brightness:42/255.0 alpha:1.0];
    pageControl.pageIndicatorTintColor = [UIColor colorWithHue:189/255.0 saturation:189/255.0 brightness:189/255.0 alpha:1.0];
    
    self.pageControl = pageControl;

}

// 设置最后一个UIimageView的内容
- (void)setupLastImageView:(UIImageView *)imageView
{
    imageView.userInteractionEnabled = YES;
    
    // 1.添加开始按钮
    [self setupStartButton:imageView];
    // 2。添加分享按钮
    [self setShareButton:imageView];
}

// 添加分享按钮
- (void)setShareButton:(UIImageView *)imageView
{
    // 1.创建分享按钮
    UIButton *shareButton = [[UIButton alloc] init];
    [imageView addSubview:shareButton];
    
    // 2.设置文字和图标
    [shareButton setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareButton setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareButton addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    // 3.设置frame
    shareButton.size = CGSizeMake(150, 35);
    shareButton.centerX = self.view.width * 0.5;
    shareButton.centerY = self.view.height * 0.7;
    
    // 4.设置间距
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}


- (void)share:(UIButton *)shareButton
{
    shareButton.selected = !shareButton.isSelected;
}

// 添加开始按钮
- (void)setupStartButton:(UIImageView *)imageView
{
    // 1.添加开始按钮
    UIButton *startButton = [[UIButton alloc] init];
    [imageView addSubview:startButton];
    
    // 2.设置背景图片
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    
    // 3.设置frame
    startButton.size = startButton.currentBackgroundImage.size;
    startButton.centerX = self.view.width * 0.5;
    startButton.centerY = self.view.height * 0.8;
    
    // 4.设置文字
    [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
    [startButton setTitleColor :[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    
}

// 开始微博
- (void)start
{
    ViewController *vc = [[ViewController alloc] init];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = vc;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat doublePage = scrollView.contentOffset.x / scrollView.width;
    int intPage = (int)(doublePage + 0.5);
    
    self.pageControl.currentPage = intPage;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
