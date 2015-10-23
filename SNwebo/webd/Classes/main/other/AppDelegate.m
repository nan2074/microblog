//
//  AppDelegate.m
//  网贷
//
//  Created by 普伴 on 15/8/10.
//  Copyright (c) 2015年 Puban. All rights reserved.
//

#import "AppDelegate.h"
#import "SNNavigationViewController.h"
#import "SNTabBarViewController.h"
#import "WMCommon.h"
#import "ViewController.h"
#import "SNNewfeatureViewController.h"
#import "SNAccount.h"
#import "SNAccountTool.h"
#import "SNControllerTool.h"
#import "SNOAuthViewController.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
 
    WMCommon *common = [WMCommon getInstance];
    common.screenW = [[UIScreen mainScreen] bounds].size.width;
    common.screenH = [[UIScreen mainScreen] bounds].size.height;
    
    
    // 1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
     // 2.显示窗口(成为主窗口)
    [self.window makeKeyAndVisible];

    // 3。设置跟控制器
    SNAccount *account = [SNAccountTool account];
    if (account) {
        [SNControllerTool chooseRootViewController];
    }
    else
    {
        self.window.rootViewController = [[SNOAuthViewController alloc] init];
    }
    
    // 监控网络
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                SNLog(@"没有网络(断网)");
                [MBProgressHUD showError:@"网络异常，请检查网络设置！"];
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                SNLog(@"手机自带网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                SNLog(@"WIFI");
                break;
            default:break;
        }

    }];

    [mgr startMonitoring];
    [Fabric with:@[[Crashlytics class]]];
    // TODO: Move this to where you establish a user session
    [self logUser];
    
    return YES;
}
- (void) logUser {
    // TODO: Use the current user's information
    // You can call any combination of these three methods
    [CrashlyticsKit setUserIdentifier:@"12345"];
    [CrashlyticsKit setUserEmail:@"user@fabric.io"];
    [CrashlyticsKit setUserName:@"Test User"];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
   

    // 提醒操作系统：当前这个应用程序需要在后台开启一个任务
    // 操作系统会允许这个应用程序在后台保持运行状态（能够持续的时间不确定）
    UIBackgroundTaskIdentifier taskID = [application beginBackgroundTaskWithExpirationHandler:^{
        
        
        [UIApplication sharedApplication].applicationIconBadgeNumber = 100;
        // 后台运行到期时会调用这个应用
        [application endBackgroundTask:taskID];
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// #import "SDWebImageManager.h"
// #import "SDImageCache.h"
// 必须包含这两个头文件
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 赶紧清除所有的内存缓存
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 赶紧停止正在进行的图片下载操作
    [[SDWebImageManager sharedManager] cancelAll];
}



@end
