//
//  CustomNavigationController.m
//  Peri
//
//  Created by fitfun on 15/11/9.
//  Copyright © 2015年 miao. All rights reserved.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    self.navigationBar.barTintColor = kMainProjColor;//导航条的颜色
    self.navigationBar.tintColor = [UIColor whiteColor];//左侧返回按钮，文字的颜色
    self.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: kMainBlackColor};
    self.navigationBar.barTintColor = [UIColor whiteColor];//导航条的颜色
    self.navigationBar.tintColor = kMainProjColor;//左侧返回按钮，文字的颜色
    self.navigationBar.barStyle = UIBarStyleDefault;
}

#pragma mark - UINavigationControllerDelegate methods
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //if ([viewController isKindOfClass:[HomeViewController class]])
    //{
        self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        self.navigationBar.barTintColor = kMainProjColor;//导航条的颜色
        self.navigationBar.tintColor = [UIColor whiteColor];//左侧返回按钮，文字的颜色
        self.navigationBar.barStyle = UIStatusBarStyleLightContent;
    //}
}

@end
