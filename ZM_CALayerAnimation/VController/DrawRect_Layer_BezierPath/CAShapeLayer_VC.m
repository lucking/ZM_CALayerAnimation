//
//  CAShapeLayer_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CAShapeLayer_VC.h"
#import "UIView+ZMFrame.h"
#import "BaseHeader.h"

@interface CAShapeLayer_VC ()
{
    BOOL isflage;
}
@end

@implementation CAShapeLayer_VC


/**
 *  CAShapeLayer 是基于贝塞尔曲线而存在的, 如果没有贝塞尔曲线提供路径来画出图形, CAShapeLayer就没有存在的意义, CAShapeLayer可以使得不用在drawRect:方法中实现画图.
 
    另外, CAShapeLayer是属于CoreAnimation框架的（是基于GPU的来进行渲染的）,
    不必使用CoreGraphic框架（是基于CPU来渲染的）, 所以CAShapeLayer效率相对比较高一些
 
 */
- (void)viewDidLoad {
    [super viewDidLoad];

// 矩形(正方形)
    [self createRect];
// 圆、椭圆
    [self createOval_Circle];
    [self createOval];
    
}

/*
 UIBezierPath *rect = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 50, 150)];
 shapeLayer.frame   = CGRectMake20, 70, 200, 100);
 // 以上的两个尺寸 
 // 使得：UIBezierPath 脱离了 渲染区（CAShapeLayer）
 // 结果：还是能够全部显示出来
 
 */
// 矩形(正方形)
- (void)createRect
{
    // 创建CAShapeLayer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame         = CGRectMake(20, 70, 200, 100);    // 设置位置、尺寸
    //shapeLayer.position      = CGPointMake(200, 200);         // 设置中心点位置（可以不设置） self.view.center
    shapeLayer.backgroundColor  = [UIColor greenColor].CGColor; // 设置背景颜色
    shapeLayer.fillColor     = [UIColor yellowColor].CGColor;   // 填充颜色
    shapeLayer.strokeColor   = [UIColor blackColor].CGColor;    // 路径颜色
    // 创建矩形贝塞尔曲线路径
    UIBezierPath *rect = [UIBezierPath bezierPathWithRect:CGRectMake(10, 10, 50, 150)];
    // 关联 ShapeLayer和贝塞尔曲线
    shapeLayer.path = rect.CGPath;
    // 显示
    [self.view.layer addSublayer:shapeLayer];
}
// 圆
- (void)createOval_Circle
{
    // 创建CAShapeLayer
    CAShapeLayer *shapeLayer    = [CAShapeLayer layer];
    shapeLayer.frame            = CGRectMake(0,0, 120, 120);// 设置尺寸,
    shapeLayer.position         = self.view.center;         // 设置中心点位置(设置的是shapeLayer的中心点位置)
    shapeLayer.backgroundColor  = BgColor.CGColor;          // 设置 背景颜色
    shapeLayer.fillColor        = Yellow_COLOR.CGColor;     // 设置 填充颜色(注意, 这里不是设置背景颜色)
    shapeLayer.strokeColor      = GreenColor.CGColor;       // 设置 边框颜色(路径颜色)
    shapeLayer.borderWidth      = 2.f;
    shapeLayer.borderColor      = Red_COLOR.CGColor;
    
    // 创建圆形贝塞尔曲线路径  bezierPath_OvalInRect
    CGFloat RR = 100;
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(10, 10, RR, RR)];
    oval.lineWidth = 6;
    // 关联 ShapeLayer和贝塞尔曲线
    shapeLayer.path = oval.CGPath;
    [self.view.layer addSublayer:shapeLayer]; // 显示
}
// 椭圆
- (void)createOval
{
    // 创建CAShapeLayer
    CAShapeLayer *shapeLayer    = [CAShapeLayer layer];
    shapeLayer.frame            = CGRectMake(0,0, 220, 120);// 设置尺寸,
    shapeLayer.position       = CGPointMake(200, SSHEIGHT-200);// 设置中心点位置(设置的是shapeLayer的中心点位置)
    shapeLayer.backgroundColor  = BgColor.CGColor;          // 设置 背景颜色
    shapeLayer.fillColor        = Yellow_COLOR.CGColor;     // 设置 填充颜色(注意, 这里不是设置背景颜色)
    shapeLayer.strokeColor      = GreenColor.CGColor;       // 设置 边框颜色(路径颜色)
    shapeLayer.borderWidth      = 2.f;
    shapeLayer.borderColor      = Red_COLOR.CGColor;
    // 创建椭圆形贝塞尔曲线路径
    UIBezierPath *oval = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 5, 200, 100)];
    // 关联 ShapeLayer和贝塞尔曲线
    shapeLayer.path = oval.CGPath;
    [self.view.layer addSublayer:shapeLayer];  // 显示
}



#pragma mark - onClick
//触摸时：隐藏导航条
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    isflage=!isflage;
    [super.navigationController setNavigationBarHidden:isflage animated:TRUE];
    [super.navigationController setToolbarHidden:isflage animated:TRUE];
}

@end
