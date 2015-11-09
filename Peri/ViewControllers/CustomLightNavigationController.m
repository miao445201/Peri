//
//  CustomLightNavigationController.m
//  Peri
//
//  Created by fitfun on 15/11/9.
//  Copyright © 2015年 miao. All rights reserved.
//


#import "CustomLightNavigationController.h"

@interface CustomLightNavigationController ()

@end

@implementation CustomLightNavigationController

#pragma mark - UIViewController Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: kMainBlackColor};
    self.navigationBar.barTintColor = [UIColor whiteColor];//导航条的颜色
    self.navigationBar.tintColor = kMainProjColor;//左侧返回按钮，文字的颜色
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
}

#pragma mark - Status bar methods
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;
}

@end
