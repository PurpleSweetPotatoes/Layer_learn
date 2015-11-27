//
//  LayerManualAnimationViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerManualAnimationViewController.h"

@interface LayerManualAnimationViewController ()
@property (nonatomic, strong) UIView *contentView;
@end

@implementation LayerManualAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.contentView];

    //添加收拾
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panChange:)];
    [self.contentView addGestureRecognizer:pan];
    //设置速度为0则动画停止 ，可以通过设置timeoffset来进行手势动画
    self.contentView.layer.speed = 0.0;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"transform.rotation.y";
    animation.toValue = @(-M_PI_2);
    animation.duration = 1.0;
    [self.contentView.layer addAnimation:animation forKey:nil];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentView.frame) + 50, screenWidth, 30)];
    label.text = @"左右拖拽木门";
    label.font = [UIFont systemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
}
- (void)panChange:(UIPanGestureRecognizer *)pan {
    //获取手势在self.view上的偏移量
    CGFloat x = [pan translationInView:self.view].x;
    x /= 150.0f;
    CFTimeInterval timeOffset = self.contentView.layer.timeOffset;
    timeOffset = MIN(0.95, MAX(0.0, timeOffset - x));
    self.contentView.layer.timeOffset = timeOffset;
    //重设偏移量为0.0点
    [pan setTranslation:CGPointZero inView:self.view];
}
- (UIView *)contentView{
    if (_contentView == nil) {
        UIImageView *contentView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 300)];
        contentView.image = [UIImage imageNamed:@"door"];
        contentView.center = CGPointMake(self.view.center.x - 75, self.view.center.y);
        //设置锚点
        contentView.layer.anchorPoint = CGPointMake(0, 0.5);
        //增加透视
        CATransform3D perspective = CATransform3DIdentity;
        perspective.m34 = - 1.0/ 500.0;
        contentView.layer.transform = perspective;
        contentView.userInteractionEnabled = YES;
        _contentView = contentView;
    }
    return _contentView;
}
@end
