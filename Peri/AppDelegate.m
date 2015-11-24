//
//  AppDelegate.m
//  Peri
//
//  Created by fitfun on 15/11/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "UserInfoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];//设置窗口
    RootViewController *mvc = [[RootViewController alloc] init];
    UINavigationController *rootNav = [[UINavigationController alloc] initWithRootViewController:mvc];
    rootNav.tabBarItem.title = @"图区";
    rootNav.tabBarItem.image = [UIImage imageNamed:@"tuNoSelect.png"];
    //rootNav.tabBarItem.selectedImage = [UIImage imageNamed:@"tuSelect.png"];
    
    UserInfoViewController *user = [[UserInfoViewController alloc]init];
    UINavigationController *userNav = [[UINavigationController alloc]initWithRootViewController:user];
    userNav.tabBarItem.title = @"个人中心";
    userNav.tabBarItem.image = [UIImage imageNamed:@"user.png"];

    
    UITabBarController *rootTab = [[UITabBarController alloc]init];
    rootTab.tabBar.selectedImageTintColor = [UIColor orangeColor];
    NSArray *vc = @[rootNav,userNav];
    rootTab.viewControllers = vc;
    
//    nav.navigationBarHidden = YES;//是否隐藏导航栏
    self.window.rootViewController = rootTab;//进入的首个页面
    [self.window makeKeyAndVisible];//显示
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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

@end
