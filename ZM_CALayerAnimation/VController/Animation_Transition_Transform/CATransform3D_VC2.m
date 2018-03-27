//
//  CATransform3D_VC2.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CATransform3D_VC2.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"
#import "GCD.h"
#define DEGREE(d)            ((d) * M_PI / 180.0f)

@interface CATransform3D_VC2 ()
@property (nonatomic, strong) GCDTimer  *m_timer1;
@property (nonatomic, strong) GCDTimer  *m_timer2;
@end

@implementation CATransform3D_VC2

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.m_timer1 = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
    self.m_timer2 = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
    
    [self animateCALayer];
    
    [self animateCATransformLayer];
}

- (void)animateCALayer {
    
    // 普通的一个layer
    CALayer *layer1        = [CALayer layer];
    layer1.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    layer1.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    layer1.position        = CGPointMake(self.view.centerX, self.view.centerY - 55);       // 位置
    layer1.opacity         = 0.6;                                                          // 背景透明度
    layer1.backgroundColor = Purple_AB82FF.CGColor;
    layer1.borderColor     = Green_00CD66.CGColor;
    layer1.borderWidth     = 3;
    layer1.cornerRadius    = 10;
    // Z轴平移
    CATransform3D planeLayer1_3D = CATransform3DIdentity;
    planeLayer1_3D               = CATransform3DTranslate(planeLayer1_3D, 0, 0, -10);
    layer1.transform        = planeLayer1_3D;
    
    // 创建容器layer
    CALayer *container = [CALayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    [container addSublayer:layer1];
    
    // 启动定时器
    CFTimeInterval duration= 0.5f;
    [self.m_timer1 event:^{
        static float degree = 0.f;
        // 起始值
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34           = 1.0/ -500;
        fromValue               = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        // 结束值
        CATransform3D toValue   = CATransform3DIdentity;
        toValue.m34             = 1.0/ -500;
        toValue                 = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        // 添加3d动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration  = duration;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        container.transform = toValue;
        [container addAnimation:transform3D forKey:@"transform3D"];
        
    } timeIntervalWithSecs:duration];
    
    [self.m_timer1 start];
}

- (void)animateCATransformLayer {
    
    // 普通的一个layer
    CALayer *Layer1        = [CALayer layer];
    Layer1.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    Layer1.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    Layer1.position        = CGPointMake(self.view.centerX, self.view.centerY + 55);       // 位置
    Layer1.opacity         = 0.6;
    Layer1.backgroundColor = Red_COLOR.CGColor;
    Layer1.borderColor     = White_COLOR.CGColor;
    Layer1.borderWidth     = 5;
    Layer1.cornerRadius    = 10;
    // 普通的一个layer
    CALayer *Layer2        = [CALayer layer];
    Layer2.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    Layer2.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    Layer2.position        = CGPointMake(self.view.centerX, self.view.centerY + 55);       // 位置
    Layer2.opacity         = 0.6;
    Layer2.backgroundColor = Green_Color.CGColor;
    Layer2.borderColor     = White_COLOR.CGColor;
    Layer2.borderWidth     = 5;
    Layer2.cornerRadius    = 10;
    
    // Layer1、Layer2 的层次感
    // Z轴平移 Layer1
    CATransform3D planeLayer1_3D = CATransform3DIdentity;
    planeLayer1_3D               = CATransform3DTranslate(planeLayer1_3D, 0, 0, -10);
    Layer1.transform        = planeLayer1_3D;
    // Z轴平移 Layer2
    CATransform3D planeLayer2_3D = CATransform3DIdentity;
    planeLayer2_3D               = CATransform3DTranslate(planeLayer2_3D, 0, 0, -30);
    Layer2.transform        = planeLayer2_3D;
    
    
    // 创建容器layer
    CATransformLayer *container = [CATransformLayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    [container addSublayer:Layer1];
    [container addSublayer:Layer2];
    
    // 启动定时器
    [self.m_timer2 event:^{
        static float degree = 0.f;
        // 起始值
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34           = 1.0/ -500;
        fromValue               = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        // 结束值
        CATransform3D toValue   = CATransform3DIdentity;
        toValue.m34             = 1.0/ -500;
        toValue                 = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        // 添加3d动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration  = 1.f;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        container.transform = toValue;
        [container addAnimation:transform3D forKey:@"transform3D"];
        
    } timeIntervalWithSecs:1.f];
    [self.m_timer2 start];
}

@end
