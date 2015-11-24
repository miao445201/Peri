//
//  BaseMenuViewController.m
//  Peri
//
//  Created by fitfun on 15/11/9.
//  Copyright © 2015年 miao. All rights reserved.
//


#import "BaseMenuViewController.h"

@interface BaseMenuViewController ()

@end

@implementation BaseMenuViewController

#pragma mark - UIViewController methods
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillDisappear:(BOOL)animated {
    CATransition *transition = [CATransition animation];
    [transition setDuration:1];
    [transition setType:@"cube"];
    [self.view.layer addAnimation:transition forKey:nil];
}
@end
