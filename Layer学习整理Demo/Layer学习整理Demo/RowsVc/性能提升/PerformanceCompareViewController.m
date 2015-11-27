//
//  PerformanceCompareViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "PerformanceCompareViewController.h"
#import "DrawPictureViewController.h"
#import "ImageDrawPictureViewController.h"
#import "ImageCacheViewController.h"

@interface PerformanceCompareViewController ()

@end

@implementation PerformanceCompareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DrawPictureViewController *linedraw = [[DrawPictureViewController alloc] init];
    linedraw.title = @"DrawPic";
    ImageDrawPictureViewController *imageDraw = [[ImageDrawPictureViewController alloc] init];
    imageDraw.title = @"imageDraw";
    ImageCacheViewController *imageCache = [[ImageCacheViewController alloc] init];
    imageCache.title = @"imageCache";
    UITabBarController *tabVc = [[UITabBarController alloc] init];
    tabVc.viewControllers = @[linedraw, imageDraw, imageCache];
    
    [self addChildViewController:tabVc];
    [self.view addSubview:tabVc.view];
}



@end
