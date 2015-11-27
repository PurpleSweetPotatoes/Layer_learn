//
//  ImageDrawPictureViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/27.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ImageDrawPictureViewController.h"
#import "TestView.h"

@interface ImageDrawPictureViewController ()

@end

@implementation ImageDrawPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建画图层
    TestView *testView = [[TestView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:testView];
}



@end
