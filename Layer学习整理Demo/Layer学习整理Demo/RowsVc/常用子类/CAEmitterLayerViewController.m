//
//  CAEmiterLayerViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "CAEmitterLayerViewController.h"

@interface CAEmitterLayerViewController ()

@end

@implementation CAEmitterLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self craeteEmitterLayer];
}

- (void)craeteEmitterLayer {
    //create emitter layer
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    emitter.frame = self.view.bounds;
    [self.view.layer addSublayer:emitter];
    
    //configure emitter
    emitter.renderMode = kCAEmitterLayerAdditive;
    emitter.emitterPosition = CGPointMake(emitter.bounds.size.width * 0.5, emitter.bounds.size.height * 0.5);
    emitter.beginTime = CACurrentMediaTime() + 1.0;
    //粒子效果重复次数，设置无用
    emitter.repeatCount = 3;
    
    //create a emitter cell
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.contents = (__bridge id)[UIImage imageNamed:@"123"].CGImage;
    //每秒钟创造个数
    cell.birthRate = 10;
    //每个对象生命时间
    cell.lifetime = 5.0;
    //cell颜色
    cell.color = [UIColor redColor].CGColor;
    //透明度转变速率
    cell.alphaSpeed = -0.2;
    //初始速度
    cell.velocity = 30;
    cell.velocityRange = 40;
    cell.emissionRange = M_PI * 2.0;
    
    CAEmitterCell *cell1 = [[CAEmitterCell alloc] init];
    cell1.contents = (__bridge id)[UIImage imageNamed:@"123"].CGImage;
    cell1.birthRate = 10;
    cell1.lifetime = 5.0;
    cell1.color = [UIColor cyanColor].CGColor;
    cell1.alphaSpeed = -0.2;
    cell1.velocity = 20;
    cell1.velocityRange = 300;
    cell1.emissionRange = M_PI * 2.0;
    emitter.emitterCells = @[cell,cell1];
}


@end
