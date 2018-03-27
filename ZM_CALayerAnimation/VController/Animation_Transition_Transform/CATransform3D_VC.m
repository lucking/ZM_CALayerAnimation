//
//  CATransform3D_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CATransform3D_VC.h"
#import "BaseHeader.h"
#import "GCD.h"
#import "UIView+ZMFrame.h"
#define DEGREE(d)            ((d) * M_PI / 180.0f)

@interface CATransform3D_VC ()
@property (nonatomic, strong) GCDTimer  *m_timer;

@end

@implementation CATransform3D_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CATransform3D_VC";
    
    self.m_timer = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
    
    [self staticM34];
    
    [self animateM34];
}

- (void)staticM34 {
    
    // 普通的一个layer
    CALayer *planeLayer1        = [CALayer layer];
    planeLayer1.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer1.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer1.position        = CGPointMake(self.view.centerX - 55, self.view.centerY - 60);  // 位置
    planeLayer1.opacity         = 0.6;                                                          // 背景透明度
    planeLayer1.backgroundColor = Red_COLOR.CGColor;
    planeLayer1.borderWidth     = 3;                                                            // 边框宽度
    planeLayer1.borderColor     = [Green_Color colorWithAlphaComponent:0.5].CGColor;            // 边框颜色(设置了透明度)
    planeLayer1.cornerRadius    = 10;
    
    // 普通的一个layer
    CALayer *planeLayer2        = [CALayer layer];
    planeLayer2.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer2.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer2.position        = CGPointMake(self.view.centerX + 55, self.view.centerY - 60);  // 位置
    planeLayer2.opacity         = 0.6;
    planeLayer2.backgroundColor = Green_Color.CGColor;
    planeLayer2.borderWidth     = 3;                        // 边框宽度
    planeLayer2.borderColor     = Purple_AB82FF.CGColor;    // 边框颜色
    planeLayer2.cornerRadius    = 10;                       // 圆角值
    
    // 创建容器layer
    CALayer *container = [CALayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    
    CATransform3D plane_3D = CATransform3DIdentity;
    plane_3D.m34           = 1.0/ -500;
    plane_3D               = CATransform3DRotate(plane_3D, DEGREE(30), 0, 1, 0);
    container.transform    = plane_3D;
    
    [container addSublayer:planeLayer1];
    [container addSublayer:planeLayer2];
}

- (void)animateM34 {
    
    // 普通layer
    CALayer *planeLayer = [CALayer layer];
    planeLayer.anchorPoint     = CGPointMake(0.5, 0.5);                                         // 锚点
    planeLayer.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                   // 尺寸
    planeLayer.position        = CGPointMake(self.view.centerX, self.view.centerY + 60);        // 位置
    planeLayer.opacity         = 0.6;
    planeLayer.backgroundColor = [UIColor blueColor].CGColor;
    planeLayer.borderWidth     = 3.f;
    planeLayer.borderColor     = [White_COLOR colorWithAlphaComponent:0.5].CGColor;
    planeLayer.cornerRadius    = 10;
    [self.view.layer addSublayer:planeLayer];

    
    CFTimeInterval duration= 0.5f;
    // 启动定时器
    [self.m_timer event:^{
        
        static float degree = 0;
        //起始值
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34 = -1.f / 300;
        fromValue     = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        //结束值
        CATransform3D toValue = CATransform3DIdentity;
        toValue.m34   = -1.f / 300;
        toValue       = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        // 添加3D动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration  = duration;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        planeLayer.transform  = toValue;
        [planeLayer addAnimation:transform3D forKey:@"transform3D"];
        
    } timeIntervalWithSecs:duration];
    [self.m_timer start];
}




@end
