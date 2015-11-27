//
//  LayerCATransactionViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerCATransactionAnimationViewController.h"

@interface LayerCATransactionAnimationViewController ()
@property (nonatomic, strong) CALayer *changeLayer;
@end

@implementation LayerCATransactionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createChangeLayer];
    [self createLabel];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.view];
    
    //类似于UIView动画提交方式
    [CATransaction begin];
    [CATransaction setAnimationDuration:1];
    
    //[self.changeLayer.presentationLayer hitTest:point]可以判断当前layer是否被点击
    if ([self.changeLayer.presentationLayer hitTest:point]) {
        CGFloat red = arc4random() / (CGFloat)INT_MAX;
        CGFloat green = arc4random() / (CGFloat)INT_MAX;
        CGFloat blue = arc4random() / (CGFloat)INT_MAX;
        self.changeLayer.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0].CGColor;
    }else{
        self.changeLayer.position = point;
    }
    [CATransaction commit];
}

/**
 *  创建layer
 */
- (void)createChangeLayer {
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 150, 150);
    layer.position = self.view.center;
    layer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:layer];
    self.changeLayer = layer;
}
- (void)createLabel {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, screenHeight - CGRectGetMaxY(self.navigationController.navigationBar.frame) - 30, screenWidth, 30)];
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"触摸改变layer状态";
    [self.view addSubview:label];
}

@end
