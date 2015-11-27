//
//  CARelicatorLayerViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "CARelicatorLayerViewController.h"

@interface CARelicatorLayerViewController ()

@end

@implementation CARelicatorLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    [self createBaseCAReplicatorLayer];
    [self createReflexCARelicatorLayer];
}
/**
 *  设置镜像
 */
- (void)createReflexCARelicatorLayer {
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.frame = self.view.bounds;
    layer.instanceCount = 2;
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DScale(transform, 1, -1, 0);
    
    layer.instanceTransform = transform;
    
    layer.instanceAlphaOffset = -0.6;
    
    CALayer *imagelayer = [CALayer layer];
    imagelayer.frame = CGRectMake(0, 0, 100, 100);
    imagelayer.position = CGPointMake(self.view.center.x, 270);
    imagelayer.contents = (__bridge id)[UIImage imageNamed:@"boat.jpg"].CGImage;
    [layer addSublayer:imagelayer];
    [self.view.layer addSublayer:layer];
}

/**
 *  基本使用方式
 */
- (void)createBaseCAReplicatorLayer {
    //创建重复图层
    CAReplicatorLayer *repLayer = [CAReplicatorLayer layer];
    //设置该图层大小
    repLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:repLayer];
    
    //实例化个数
    repLayer.instanceCount = 20;
    //设置仿射变换类型(实例布局依照仿射变换来布局)
    CATransform3D transform = CATransform3DIdentity;
    //    transform = CATransform3DTranslate(transform, 0, 0, 0);
    transform = CATransform3DRotate(transform, M_PI / 10.0, 0, 0, 1);
    //    transform = CATransform3DTranslate(transform, 0, 0, 0);
    repLayer.instanceTransform = transform;
    //设置颜色渐变度
    repLayer.instanceRedOffset = -0.05;
    repLayer.instanceGreenOffset = -0.02;
    repLayer.instanceBlueOffset = -0.03;
    //创建一个图层增加到作为其实例化标准
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 50, 50);
    layer.position = CGPointMake(self.view.center.x, 170);
    layer.cornerRadius = 25;
    layer.backgroundColor = [UIColor whiteColor].CGColor;
    [repLayer addSublayer:layer];
}

@end
