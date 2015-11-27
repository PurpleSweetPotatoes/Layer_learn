//
//  ChangeViewImageViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "ChangeViewImageViewController.h"

@interface ChangeViewImageViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *imageArray;
@end

@implementation ChangeViewImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageView];
    self.imageView.image = self.imageArray[0];
    
    //createBtn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 120, 30);
    [btn setTitle:@"changeImage" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(self.imageView.frame) + btn.height);
    [btn addTarget:self action:@selector(btnClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}

- (void)btnClickedEvent:(UIButton *)sender {
    CATransition *transform = [CATransition animation];
    //kCATransitionFade  平滑淡入淡出
    //kCATransitionMoveIn 从左边飞入，原视图淡出
    //kCATransitionPush  从左边飞入，原视图被顶出
    //kCATransitionReveal 原视图从右边飞出
    transform.type = kCATransitionReveal;
    [self.imageView.layer addAnimation:transform forKey:nil];
    
    UIImage *currentImage = self.imageView.image;
    NSUInteger index = [self.imageArray indexOfObject:currentImage];
    index = (index + 1) % self.imageArray.count;
    self.imageView.image = self.imageArray[index];
}
- (UIImageView *)imageView {
    if (_imageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        imageView.center = self.view.center;
        _imageView = imageView;
    }
    return _imageView;
}
- (NSArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = @[[UIImage imageNamed:@"feichuan_03"],
                        [UIImage imageNamed:@"ball.png"],
                        [UIImage imageNamed:@"boat.jpg"]
                        ];
    }
    return _imageArray;
}
@end
