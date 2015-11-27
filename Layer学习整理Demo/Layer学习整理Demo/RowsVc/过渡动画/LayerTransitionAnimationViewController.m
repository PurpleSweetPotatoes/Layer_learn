//
//  LayerTransitionAnimationViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerTransitionAnimationViewController.h"
#import "ChangeViewImageViewController.h"
#import "ChangeViewViewController.h"

@interface LayerTransitionAnimationViewController ()<UITabBarControllerDelegate>

@end

@implementation LayerTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTabBarVc];
    
}
- (void)createTabBarVc {
    ChangeViewImageViewController *viewImageVc = [[ChangeViewImageViewController alloc] init];
    viewImageVc.title = @"ViewImage";
    ChangeViewViewController *viewVc = [[ChangeViewViewController alloc] init];
    viewVc.title = @"ViewChange";
    
    UITabBarController *tabVc = [[UITabBarController alloc] init];
    tabVc.viewControllers = @[viewImageVc, viewVc];
    
    tabVc.delegate = self;
    
    [self addChildViewController:tabVc];
    [self.view addSubview:tabVc.view];
}
#pragma mark - UITabBarControllerDelegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [UIView transitionWithView:tabBarController.view duration:1.0 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        
    } completion:nil];
}

@end
