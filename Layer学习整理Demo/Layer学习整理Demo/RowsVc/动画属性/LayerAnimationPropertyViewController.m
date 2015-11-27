//
//  LayerAnimationPropertyViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerAnimationPropertyViewController.h"
static CGFloat const spacing = 20;

@interface LayerAnimationPropertyViewController ()
@property (nonatomic, strong) CALayer *colorLayer;
@property (nonatomic, strong) NSArray *buttonTitle;
@property (nonatomic, strong) UIButton *preBtn;
@end

@implementation LayerAnimationPropertyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    [self.view.layer addSublayer:self.colorLayer];
}
- (void)initData {
    self.buttonTitle = @[
                         @"基础动画",
                         @"核心动画",
                         ];
}
- (void)initUI {

    NSInteger count = self.buttonTitle.count;
    CGFloat buttonWidth = (screenWidth - spacing * (count + 1))/ (CGFloat)count;
    for (int i = 0; i < count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(spacing + (buttonWidth + spacing) * i , CGRectGetMaxY(self.navigationController.navigationBar.frame) + 10, buttonWidth, 40);
        [btn setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(btnClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor grayColor];
        btn.layer.cornerRadius = 5;
        btn.clipsToBounds = YES;
        [self.view addSubview:btn];
        if (i == 0) {
            [self btnClickedEvent:btn];
        }
    }
}

- (void)btnClickedEvent:(UIButton *)btn {
    _preBtn.selected = !_preBtn.selected;
    btn.selected = !btn.selected;
    _preBtn = btn;
    
    if ([btn.currentTitle isEqualToString:@"基础动画"]) {
        [self basicAnimation];
    }else {
        [self keyAnimation];
    }
}

/**
 *  基础动画
 */
- (void)basicAnimation {
    //创建基础动画
    CABasicAnimation *animation = [CABasicAnimation animation];
    //动画所关联属性,此处可以直接设置transform的虚拟属性
    animation.keyPath = @"transform.rotation";
    //动画时间
    animation.duration = 2.0f;
    //一般是设置formValue和toValue,但若值相同则没有动画，此时用byValue则可解决此问题
    animation.byValue = @(M_PI * 2);
    //设置动画速率，此处动画速率为开始和结束时较慢，中间过程较快
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //对layer层添加动画
    [self.colorLayer addAnimation:animation forKey:nil];
}

/**
 *  核心动画
 */
- (void)keyAnimation {
    //创建核心动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    //设置核心动画所关联属性
    animation.keyPath = @"backgroundColor";
    //动画时间
    animation.duration = 2.0f;
    //可以设置动画开始时间延时执行
    animation.beginTime = CACurrentMediaTime() + 0.0f;
    //核心动画所关联的属性所将要被赋的值
    animation.values = @[(__bridge id)[UIColor redColor].CGColor,
                         (__bridge id)[UIColor blueColor].CGColor,
                         (__bridge id)[UIColor greenColor].CGColor,
                         (__bridge id)[UIColor orangeColor].CGColor
                         ];
    //设置动画速率
    CAMediaTimingFunction *fn = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    //数组中动画速率个数须比values值少一个
    animation.timingFunctions = @[fn,fn,fn];
    //添加动画
    [self.colorLayer addAnimation:animation forKey:nil];
}

- (CALayer *)colorLayer {
    if (_colorLayer == nil) {
        CALayer *colorLayer = [CALayer layer];
        colorLayer.frame = CGRectMake(0, 0, 200, 200);
        colorLayer.backgroundColor = [UIColor orangeColor].CGColor;
        colorLayer.position = self.view.center;
        _colorLayer = colorLayer;
    }
    return _colorLayer;
}

@end
