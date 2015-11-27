//
//  CATransformLayerViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "CATransformLayerViewController.h"

@interface CATransformLayerViewController ()
@property (nonatomic, strong) CALayer *changelayer;
@property (nonatomic, assign) CATransform3D ct1;
@end

@implementation CATransformLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置全体子layer透视
    CATransform3D pt = CATransform3DIdentity;
    pt.m34 = - 1.0/ 500.0;
    self.view.layer.sublayerTransform = pt;
    
    //创建上部图层
    _ct1 = CATransform3DIdentity;
    _ct1 = CATransform3DTranslate(_ct1, -50, -150, 0);
    _changelayer = [self cubeWithTransform:_ct1];
    [self.view.layer addSublayer:_changelayer];
    
    
    //创建下部对比图层
    CATransform3D ct2 = CATransform3DIdentity;
    ct2 = CATransform3DTranslate(ct2, -50, 100, 0);
    CALayer *cube2 = [self cubeWithTransform:ct2];
    [self.view.layer addSublayer:cube2];
}
/**
 *  触摸使上部图层进行仿射变换
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _ct1 = CATransform3DRotate(_ct1, M_PI_4, 1, 1, 0);
    _changelayer.transform  = _ct1;
}


/**
 *  创建图层设置随机背景色及仿射变换并返回
 */
- (CALayer *)faceWithTransform:(CATransform3D )transform {
    CALayer *face = [CALayer layer];
    face.frame = CGRectMake(0, 0, 100, 100);
    
    CGFloat red = (rand() / (double)INT_MAX);
    CGFloat green = (rand() / (double)INT_MAX);
    CGFloat blue = (rand() / (double)INT_MAX);
    
    face.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0f].CGColor;
    face.transform = transform;
    
    return face;
}

/**
 *  创建立方体图层
 */
- (CALayer *)cubeWithTransform:(CATransform3D)transform {
    CATransformLayer *cube = [CATransformLayer layer];
    
    //add cube face 1
    CATransform3D faceCT = CATransform3DMakeTranslation(0, 0, 50);
    [cube addSublayer:[self faceWithTransform:faceCT]];
    //add cube face 2
    faceCT = CATransform3DMakeTranslation(50, 0, 0);
    faceCT = CATransform3DRotate(faceCT, M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:faceCT]];
    //add cube face 3
    faceCT = CATransform3DMakeTranslation(-50, 0, 0);
    faceCT = CATransform3DRotate(faceCT, -M_PI_2, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:faceCT]];
    //add cube face 4
    faceCT = CATransform3DMakeTranslation(0, 50, 0);
    faceCT = CATransform3DRotate(faceCT, M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:faceCT]];
    //add cube face 5
    faceCT = CATransform3DMakeTranslation(0, -50, 0);
    faceCT = CATransform3DRotate(faceCT, -M_PI_2, 1, 0, 0);
    [cube addSublayer:[self faceWithTransform:faceCT]];
    //add cube face 6
    faceCT = CATransform3DMakeTranslation(0, 0, -50);
    faceCT = CATransform3DRotate(faceCT, M_PI, 0, 1, 0);
    [cube addSublayer:[self faceWithTransform:faceCT]];
    //set cube position
    cube.position = self.view.center;
    NSLog(@"%@",NSStringFromCGPoint(cube.position));
    cube.transform = transform;
    return cube;
}

@end
