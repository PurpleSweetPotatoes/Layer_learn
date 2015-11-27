//
//  LayerTransformViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/24.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "LayerTransformViewController.h"

static CGFloat spacing = 20;

@interface LayerTransformViewController ()
@property (nonatomic, strong) NSArray *buttonTitle;
@property (nonatomic, strong) UIImageView *changeView;
@property (nonatomic, strong) UIButton *preBtn;
@end

@implementation LayerTransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];
    [self initUI];
}
- (void)initData {
    self.buttonTitle = @[
                         @"2D变换",
                         @"3D变换"];
}
- (void)initUI {
    [self createOrginImage];
    [self createChangeButton];
}

- (void)createOrginImage {
    CGFloat imageWidth = (screenWidth - spacing * 3) * 0.5;
    UIImageView *orginView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boat.jpg"]];
    orginView.frame = CGRectMake(spacing, self.view.center.y - imageWidth * 0.5, imageWidth, imageWidth);
    [self.view addSubview:orginView];
    
    
    UIImageView *changeView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"boat.jpg"]];
    changeView.frame = CGRectMake(spacing * 2 + imageWidth, self.view.center.y - imageWidth * 0.5, imageWidth, imageWidth);
    [self.view addSubview:changeView];
    _changeView = changeView;
    
}

/**
 *  通过翻转180°可以发现图层绘制其实有两面，正面和背面
 *  可以通过layer属性doubleSided来确定是否绘制背面,默认值是yes
 */
- (void)btnClickedEvent:(UIButton *)btn{
    _preBtn.selected = !_preBtn.selected;
    btn.selected = !btn.selected;
    _preBtn = btn;
    
    //将仿射变换归回原位
    _changeView.layer.affineTransform = CGAffineTransformIdentity;
    _changeView.layer.transform = CATransform3DIdentity;
    
    if ([btn.currentTitle isEqualToString:@"2D变换"]) {
        //创建2D仿射变换
        CGAffineTransform transform = CGAffineTransformIdentity;
        //集合多种转换(转换的值会相互影响)
        //缩放0.5倍
        transform = CGAffineTransformScale(transform, 0.5, 0.5);
        //在缩放后的基础上旋转45°
        transform = CGAffineTransformRotate(transform, M_PI_4);
        //最后在以自身坐标系为参考 移动x:100 y:50个单位
        transform = CGAffineTransformTranslate(transform, 100, 50);
        //将仿射变换赋予给图层
        [UIView animateWithDuration:0.75 animations:^{
            _changeView.layer.affineTransform = transform;
        }];
    }else {
        //创建3D仿射变换
        CATransform3D tranform3D = CATransform3DIdentity;
        //通过设置m34来改变透视，否则只有缩放效果,透视效果必须先设置否则无效
        tranform3D.m34 = - 1 / 500.0;
        //沿Y轴进行旋转
        tranform3D = CATransform3DRotate(tranform3D, M_PI_4, 0, 1, 0);
        [UIView animateWithDuration:0.25 animations:^{
            _changeView.layer.transform = tranform3D;
        }];
    }
}
#warning 通过以下方式可以同一设置子视图layer的透视效果
/**
 *  CATransform3D commandTransform = CATransform3DIdentity;
 *  commandTransform.m34 = - 1.0 / 500.0;
 *  sublayerTransform 保证其子视图受到相同的3D变换
 *  self.view.layer.sublayerTransform = commandTransform;
 */


- (void)createChangeButton {
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



@end
