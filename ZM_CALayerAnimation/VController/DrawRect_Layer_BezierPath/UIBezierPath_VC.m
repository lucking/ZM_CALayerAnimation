//
//  UIBezierPath_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "UIBezierPath_VC.h"
#import "BaseHeader.h"
#import "RectView.h"
#import "UIBezierPath_AAView.h"
#import "UIBezierPath_RectView.h"

static CGFloat WWHH = 100;  // 的高度
@interface UIBezierPath_VC ()
{
    BOOL isflage;
}
@property (nonatomic, strong)  UIView *customView;
//@property (nonatomic, strong) RectView *rectView;
@property (nonatomic, strong) UIBezierPath_AAView *aaView;
@property (nonatomic, strong) UIBezierPath_RectView *bgView;
@end

@implementation UIBezierPath_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"UIBezierPath_VC";
    self.tabBarController.tabBar.hidden = YES;
    // 用 UIBezierPath 绘图
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.aaView];
    // 创建进度条
    [self createProgress];

}
// 创建进度条：
- (void)createProgress {
    // 创建一个view
    UIView *showView = [[UIView alloc] initWithFrame:CGRectMake(260, 560, WWHH, WWHH)];
    showView.backgroundColor = Color_CDDC39;
    showView.alpha = 0.5;
    [self.view addSubview:showView];
    
    // 贝塞尔曲线(创建一个圆)  radius：半径R
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WWHH/2.f, WWHH/2.f)
                                                        radius:WWHH/2.f
                                                    startAngle:0
                                                      endAngle:M_PI * 2
                                                     clockwise:YES];

    // 创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = showView.bounds;              // 与showView的frame一致
    layer.strokeColor   = [UIColor redColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor; // 闭环填充的颜色
    layer.lineCap       = kCALineCapSquare;             // 边缘线的类型
    layer.path          = path.CGPath;                  // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 4.0f; // 线条宽度
    layer.strokeStart   = 0.0f; // 弧线开始的角度值
    layer.strokeEnd     = 0.9f; // 弧线结束的角度值
    // 将layer添加进图层
    [showView.layer addSublayer:layer];

    //同上
    [self performSelector:@selector(mainThread:) withObject:layer afterDelay:1];
    
    
}
//主线程
-(void)mainThread:(CAShapeLayer *)layer
{
    layer.lineWidth   = 2.0f;   // 线条宽度
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:0.9f]; //1.0f：是正圆（0.0~1.0 整圆的占比）
    [layer addAnimation:pathAnimation forKey:nil];
}


- (UIBezierPath_AAView *)aaView {
    if (!_aaView) {
        _aaView = [[UIBezierPath_AAView alloc]initWithFrame:CGRectMake(30, 80, SSWIDTH-60,460)];
        _aaView.backgroundColor = [UIColor yellowColor];
        _aaView.fillColor = Cyan_COLOR;
        _aaView.lineWidth = 2;
        _aaView.strokeColor = [UIColor magentaColor];
    }
    return _aaView;
}
// RectView 绘制的背景
- (UIBezierPath_RectView *)bgView {
    if (!_bgView) {
        _bgView = [[UIBezierPath_RectView alloc]initWithFrame:CGRectMake(0, 64, SSWIDTH,SSHEIGHT)];
        _bgView.backgroundColor = Clear_COLOR;
        _bgView.fillColor = BgColor;
        _bgView.lineWidth = 2;
        _bgView.strokeColor = Clear_COLOR;
    }
    return _bgView;
}



#pragma mark - onClick
//触摸时：隐藏导航条
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    isflage=!isflage;
    [super.navigationController setNavigationBarHidden:isflage animated:TRUE];
}
- (void)test {
    //block代码块动画
    [UIView transitionWithView:self.customView duration:3.0 options:0 animations:^{
        //执行的动画
        NSLog(@"动画开始执行前的位置：%@",NSStringFromCGPoint(self.customView.center));
        self.customView.center=CGPointMake(200, 300);
        
    } completion:^(BOOL finished) {
        //动画执行完毕后的首位操作
        NSLog(@"动画执行完毕");
        NSLog(@"动画执行完毕后的位置：%@",NSStringFromCGPoint( self.customView.center));
    }];
    
    [UIView animateKeyframesWithDuration:3.0 delay:1 options:0 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
    [UIView animateWithDuration:3.0 delay:1 options:0 animations:^{
        
    } completion:^(BOOL finished) {
        
    }];
}
+ (void)animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}
+ (void)transitionWithView:(UIView *)view duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion
{
    
}
+ (void)transitionFromView:(UIView *)fromView toView:(UIView *)toView duration:(NSTimeInterval)duration options:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion;
{
    
}

@end
