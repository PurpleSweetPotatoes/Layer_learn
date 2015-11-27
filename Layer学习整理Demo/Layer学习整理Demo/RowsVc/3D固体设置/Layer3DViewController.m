//
//  TestViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/25.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "Layer3DViewController.h"
#import <GLKit/GLKit.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface Layer3DViewController()
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;
@property (nonatomic, assign) CATransform3D perspective;
@end

@implementation Layer3DViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
}

- (void)initUI {
    _perspective = CATransform3DIdentity;
    _perspective.m34 = - 1.0 / 500.0;
    _perspective = CATransform3DRotate(_perspective, -M_PI_4, 1, 0, 0);
    _perspective = CATransform3DRotate(_perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform = _perspective;
    
    //依次加入每个face
    //1.face
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 75);
    [self addfaceView:0 withTransform:transform];
    //2.face
    transform = CATransform3DMakeTranslation(75, 0, 0);
    transform = CATransform3DRotate(transform,M_PI_2, 0, 1, 0);
    [self addfaceView:1 withTransform:transform];
    //3.face
    transform = CATransform3DMakeTranslation(0, -75, 0);
    transform = CATransform3DRotate(transform,M_PI_2, 1, 0, 0);
    [self addfaceView:2 withTransform:transform];
    //4.face
    transform = CATransform3DMakeTranslation(0, 75, 0);
    transform = CATransform3DRotate(transform,-M_PI_2, 1, 0, 0);
    [self addfaceView:3 withTransform:transform];
    //5.face
    transform = CATransform3DMakeTranslation(-75, 0, 0);
    transform = CATransform3DRotate(transform,-M_PI_2, 0, 1, 0);
    [self addfaceView:4 withTransform:transform];
    //6.face
    transform = CATransform3DMakeTranslation(0, 0, -75);
    transform = CATransform3DRotate(transform,M_PI, 1, 0, 0);
    [self addfaceView:5 withTransform:transform];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _perspective = CATransform3DRotate(_perspective, -M_PI_4, 1, 1, 0);
    self.view.layer.sublayerTransform = _perspective;
}

/**
 *  改变光线阴暗情况（貌似没作用）
 *
 *  @param face 需要改变的layer
 */
- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = [CALayer layer];
    layer.frame = face.bounds;
    [face addSublayer:layer];
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
#warning 此处值转化无穷大
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
    UIColor *color = [UIColor colorWithWhite:1 alpha:shadow];
    layer.backgroundColor = color.CGColor;
}

/**
 *  取出对应的View并设置其transform
 *
 *  @param index     view在数组中的位置
 *  @param transform transform
 */
- (void)addfaceView:(NSInteger)index withTransform:(CATransform3D)transform {
    UIView *face = _faces[index];
    [self.view addSubview:face];
    face.center = CGPointMake(screenWidth * 0.5, screenHeight * 0.5);
    face.layer.transform = transform;
//    [self applyLightingToFace:face.layer];
}

@end
