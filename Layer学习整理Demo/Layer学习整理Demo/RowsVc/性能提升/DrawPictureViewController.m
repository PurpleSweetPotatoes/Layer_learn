//
//  DrawPictureViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/27.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "DrawPictureViewController.h"
#import "DrawView.h"

@interface DrawPictureViewController ()

@end

@implementation DrawPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建画图层
    DrawView *drawView = [[DrawView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:drawView];
}



@end
