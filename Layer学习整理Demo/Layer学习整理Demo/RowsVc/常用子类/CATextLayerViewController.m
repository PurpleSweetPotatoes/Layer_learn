//
//  CATextLayerViewController.m
//  Layer学习整理Demo
//
//  Created by baiqiang on 15/11/26.
//  Copyright © 2015年 baiqiang. All rights reserved.
//

#import "CATextLayerViewController.h"
#import <CoreText/CoreText.h>

@interface CATextLayerViewController ()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation CATextLayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self CATextLayerTest];
    
    [self.view addSubview:self.bottomView];
    [self CATextLayerWithNSMutableAttributesString];
}
/**
 *  CATextLayer一般使用
 */
- (void)CATextLayerTest {
    CATextLayer *textlayer = [CATextLayer layer];
    textlayer.frame = self.topView.bounds;
    [self.topView.layer addSublayer:textlayer];
    //文本颜色
    textlayer.foregroundColor = [UIColor blackColor].CGColor;
    //文本填充模式
    textlayer.alignmentMode = kCAAlignmentJustified;
    //文本是否自动换行
    textlayer.wrapped = YES;
    
    UIFont *font = [UIFont systemFontOfSize:16];
    //获取字体名字
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    //获取该字体信息
    CGFontRef fontRef = CGFontCreateWithFontName(fontName);
    //设置字体信息
    textlayer.font = fontRef;
    textlayer.fontSize = font.pointSize;
    //释放内存
    CGFontRelease(fontRef);
    
    //设置像素化
    textlayer.contentsScale = [UIScreen mainScreen].scale;
    
    NSString *text = @"Are you want to with me,i can take away here. and you can find the new world";
    textlayer.string = text;
    
}

/**
 *  textlayer对富文本的操作
 */
- (void)CATextLayerWithNSMutableAttributesString {
    CATextLayer *textlayer = [CATextLayer layer];
    textlayer.frame = self.bottomView.bounds;
    textlayer.contentsScale = [UIScreen mainScreen].scale;
    [self.bottomView.layer addSublayer:textlayer];
    
    //set textlayer attributes
    textlayer.alignmentMode = kCAAlignmentJustified;
    textlayer.wrapped = YES;
    
    //create attributes string
    NSString *text = @"Are you want to with me,i can take away here. and you can find the new world";
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    
    //convert UIFont to a CTFont
    UIFont *font = [UIFont systemFontOfSize:16];
    CFStringRef fontName = (__bridge CFStringRef)font.fontName;
    CGFloat fontSize = font.pointSize;
    //此处生成CTFontRef而非CGFontRef
    CTFontRef fontRef = CTFontCreateWithName(fontName, fontSize, NULL);
    
    //set string attributes
    NSDictionary *attribs = @{
                              (__bridge id)kCTForegroundColorAttributeName : (__bridge id)[UIColor blackColor].CGColor,
                              (__bridge id)kCTFontAttributeName : (__bridge id)fontRef
                              };
    [string setAttributes:attribs range:NSMakeRange(0, text.length)];
    //set some string attributes
    attribs = @{
                (__bridge id)kCTForegroundColorAttributeName: (__bridge id)[UIColor redColor].CGColor,
                (__bridge id)kCTUnderlineStyleAttributeName: @(kCTUnderlineStyleSingle),
                (__bridge id)kCTFontAttributeName:(__bridge id)fontRef
                };
    [string setAttributes:attribs range:NSMakeRange(8, 15)];
    textlayer.string = string;
    
    CFRelease(fontRef);
}
#pragma mark - get Method
- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 50, screenWidth, 100)];
        _topView.backgroundColor = [UIColor colorWithRed:0.884 green:0.798 blue:0.734 alpha:1.000];
    }
    return _topView;
}
- (UIView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topView.frame) + 100, screenWidth, 100)];
        _bottomView.backgroundColor = [UIColor grayColor];
    }
    return _bottomView;
}
@end
