//
//  SNTabBarViewController.m
//  网贷
//
//  Created by 普伴 on 15/8/10.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "SNTabBarViewController.h"
#import "SNHomeTableViewController.h"
#import "SNDiscoverTableViewController.h"
#import "SNMessageTableViewController.h"
#import "SNNavigationViewController.h"
#import "SNTabBar.h"
#import "SNProfileViewController.h"
#import "SNComposeController.h"
#import "SNUserTool.h"
#import "SNAccount.h"
#import "SNAccountTool.h"


@interface SNTabBarViewController () <SNHomeTableViewControllerDelegate,SNTabBarDelegate,UITabBarControllerDelegate>


@property (nonatomic, weak) SNHomeTableViewController *home;
@property (nonatomic, weak) SNMessageTableViewController *message;
@property (nonatomic, weak) SNDiscoverTableViewController *discover;
@property (nonatomic, weak) SNProfileViewController *profile;
@property (weak, nonatomic) UIViewController *lastSelectedViewController;




@end

@implementation SNTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = self;
    // 添加所有子控制器
    [self addAllChildVcs];
    
    // 创建自定义tabbar
    [self addCustomTabBar];
    
    // 利用定时器获得用户的未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(getUnreadCount) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    SNLog(@"加载SNTabBarViewController");
    
    

    
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    

}
- (int)notfic
{
    return 10;
}

/**
 *  获取未读消息数
 */
- (void)getUnreadCount
{
    // 1.请求参数
    SNUnreadCountParam *param = [SNUnreadCountParam param];
    param.uid = [SNAccountTool account].uid;
    
    // 2.获得未读数
    [SNUserTool unreadCountWithParam:param success:^(SNUnreadCountResult *result) {
        
        // 显示微博未读数
        if (result.status == 0) {
            self.home.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.status];
        }
        
        // 显示未读消息数
        if (result.messageCount == 0) {
            self.message.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.messageCount];
        }
        
        // 显示新粉丝数
        if (result.follower == 0) {
            self.profile.tabBarItem.badgeValue = nil;
        }
        else
        {
            self.profile.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d",result.follower];
        }
        
        //显示总的未读数
        if (result.totalCount == 0) {
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        else
        {
            [UIApplication sharedApplication].applicationIconBadgeNumber = result.totalCount;
            SNLog(@"result.totalCount = %d",[UIApplication sharedApplication].applicationIconBadgeNumber );
        }

        
    } failure:^(NSError *error) {
        
         SNLog(@"获得未读数失败---%@", error);
    }];
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UINavigationController *)viewController
{
    UIViewController *vc = [viewController.viewControllers firstObject];
    if ([vc isKindOfClass:[SNHomeTableViewController class]]) {
        if (self.lastSelectedViewController == vc) {
            [self.home refresh:YES];
        }
        else {
            [self.home refresh:NO];
        }
    }
    self.lastSelectedViewController = vc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addAllChildVcs
{
    SNHomeTableViewController *home = [[SNHomeTableViewController alloc] init];
   
    [self addOneChlildVc:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    home.SNHomeDelegate = self;

    
    SNMessageTableViewController *message = [[SNMessageTableViewController alloc] init];
    [self addOneChlildVc:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    SNDiscoverTableViewController *discover = [[SNDiscoverTableViewController alloc] init];
    [self addOneChlildVc:discover title:@"发现" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    
    
   SNProfileViewController *profile = [[SNProfileViewController alloc] init];
    [self addOneChlildVc:profile title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.profile = profile;
    
}


/**
 *  添加一个子控制器
 *
 *  @param childVc           子控制器对象
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)addOneChlildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 设置标题
    childVc.title = title;
    
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageNamed:imageName];
    
    // 设置tabBarItem的普通文字颜色
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[UITextAttributeTextColor] = [UIColor blackColor];
    textAttrs[UITextAttributeFont] = [UIFont systemFontOfSize:10];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    // 设置tabBarItem的选中文字颜色
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    selectedTextAttrs[UITextAttributeTextColor] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];

    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
 
    childVc.tabBarItem.selectedImage = selectedImage;
    
    SNNavigationViewController *nav = [[SNNavigationViewController alloc] initWithRootViewController:childVc];
    
    [self addChildViewController:nav];
    

}

- (void)myAccountBtnclk
{
    if ([self.SNTabBarDelegate respondsToSelector:@selector(myAccountBtnclk)]) {
        [self.SNTabBarDelegate myAccountBtnclk];
    }
}

/**
 *  创建自定义tabbar
 */
- (void)addCustomTabBar
{
    // 创建自定义tabbar
    SNTabBar *customTabBar = [[SNTabBar alloc] init];
    customTabBar.tabBarDelegate = self;
    // 更换系统自带的tabbar
    [self setValue:customTabBar forKeyPath:@"tabBar"];
}

- (void)tabBarDidClickedPlusButton:(SNTabBar *)tabBar
{
    SNComposeController *compose = [[SNComposeController alloc] init];
    SNNavigationViewController *nav = [[SNNavigationViewController alloc] initWithRootViewController:compose];
  

    [self presentViewController:nav animated:YES completion:nil];
}
@end
