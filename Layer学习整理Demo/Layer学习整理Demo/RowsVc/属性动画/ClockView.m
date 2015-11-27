//
//  ClockView.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ClockView.h"

@interface ClockView ()

@property (nonatomic, strong) UIImageView *hourView;
@property (nonatomic, strong) UIImageView *minView;
@property (nonatomic, strong) UIImageView *secondView;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation ClockView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createClock];
    }
    return self;
}

- (void)createClock {
    self.layer.contents = (__bridge id)[UIImage imageNamed:@"clockBottom"].CGImage;
    self.hourView = [self creteImageViewWithImageName:@"hour"];
    self.minView = [self creteImageViewWithImageName:@"minutes"];
    self.secondView = [self creteImageViewWithImageName:@"sencond"];
    
    //设置时间来进行动画
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timechagne) userInfo:nil repeats:YES];
    [self updateClockWithAnimation:NO];
}
/**
 *  视图移除时 停止计时器
 */
- (void)removeFromSuperview {
    [super removeFromSuperview];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timechagne {
    [self updateClockWithAnimation:YES];
}

- (void)updateClockWithAnimation:(BOOL)animated {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:units fromDate:[NSDate date]];
    //获取时、分、秒指针弧度值
    CGFloat hourAngle = (components.hour / 12.0) * M_PI * 2;
    CGFloat minAngle = (components.minute / 60.0) * M_PI * 2;
    CGFloat secondAngle = (components.second / 60.0) * M_PI * 2;
    
    [self setAngle:hourAngle forView:self.hourView withAnimated:animated];
    [self setAngle:minAngle forView:self.minView withAnimated:animated];
    [self setAngle:secondAngle forView:self.secondView withAnimated:animated];
    
}

- (void)setAngle:(CGFloat)angle forView:(UIView*)view withAnimated:(BOOL)animated {
    //针对于z轴旋转
    CATransform3D transform = CATransform3DMakeRotation(angle, 0, 0, 1);
    if (animated == YES) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        [self updateClockWithAnimation:NO];
        //针对于属性路径动画
        animation.keyPath = @"transform";
        //设置动画时间
        animation.duration = 0.5;
        //设置动画最终状态值
        animation.toValue = [NSValue valueWithCATransform3D:transform];
//        //设置动画代理，当动画完成后保存动画效果
//        animation.delegate = self;
        //设置动画缓冲函数
        animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:1 :0 :0.75 :1];
        //将view存储在animation中方便动画结束后使用
        [animation setValue:view forKey:@"view"];
        [view.layer addAnimation:animation forKey:nil];
    }else{
        view.layer.transform = transform;
    }
}

//- (void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag {
//    UIView *view = [anim valueForKey:@"view"];
//    view.layer.transform = [anim.toValue CATransform3DValue];
//}

/**
 *  创建并设置ImageView
 */
- (UIImageView *)creteImageViewWithImageName:(NSString *)name {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    CGRect rect = CGRectMake(0, 0, 0, 0);
    if ([name isEqualToString:@"hour"]) {
        rect.size.width = imageView.image.size.width * 0.18;
        rect.size.height = imageView.image.size.height * 0.22;
    }else {
        rect.size.width = imageView.image.size.width * 0.3;
        rect.size.height = imageView.image.size.height * 0.3;
    }
    imageView.frame = rect;
    imageView.center = self.center;
    
    imageView.layer.anchorPoint = CGPointMake(0.5, 0.9);
    [self addSubview:imageView];
    
    return imageView;
}
@end
