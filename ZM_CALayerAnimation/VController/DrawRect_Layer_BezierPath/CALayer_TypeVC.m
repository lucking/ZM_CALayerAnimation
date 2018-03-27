//
//  CALayer_TypeVC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/12.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CALayer_TypeVC.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"
#import "NSObject+CALayerAnimation.h"

static CGFloat xx1= 10, xx2= 120, xx3= 260;
static CGFloat yy1= 10, yy2= 160, yy3= 300;


@interface CALayer_TypeVC ()<UIScrollViewDelegate>
{
    
}
@property(nonatomic, strong) UIScrollView* sscrollview;
@end

@implementation CALayer_TypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CALayer_TypeVC";
    [self.navigationController setNavigationBarHidden:NO animated:YES];

    [self addScrollView];
    [self case1];
    [self case3_CATransform3D];
    [self case4_CAGradientLayer];
    [self case5_CATextLayer];
    [self case6_CAEmitterLayer];

}

- (void)case1 {
    
    CGRect rect          = CGRectMake(xx1, yy1, 100, 100);
    CGSize radii         = CGSizeMake(20, 20);
    UIRectCorner corners = UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft;
    //绘制部分圆角
    UIBezierPath *path   = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor   = [UIColor redColor].CGColor;
    shapeLayer.fillColor     = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth     = 5;
    shapeLayer.lineJoin      = kCALineJoinRound;
    shapeLayer.lineCap       = kCALineCapRound;
    shapeLayer.path          = path.CGPath;
    [_sscrollview.layer addSublayer:shapeLayer];
}

// CAGradientLayer：渐变图层（用来生成多种颜色的平滑渐变效果。）
- (void)case4_CAGradientLayer {
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame  = CGRectMake(xx2, yy1, 100, 100);
    //渐变的颜色
    gradientLayer.colors = @[(__bridge id)[UIColor redColor].CGColor,
                             (__bridge id)[UIColor orangeColor].CGColor,
                             (__bridge id)[UIColor yellowColor].CGColor,
                             (__bridge id)[UIColor greenColor].CGColor,
                             (__bridge id)[UIColor cyanColor].CGColor,
                             (__bridge id)[UIColor blueColor].CGColor,
                             (__bridge id)[UIColor magentaColor].CGColor,
                             (__bridge id)[UIColor purpleColor].CGColor];
    //colors中设置的颜色的渐变范围
    //    gradientLayer.locations = @[@0.0, @0.14, @0.28, @0.42, @0.56, @0.70, @0.85];
    //渐变的方向
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint   = CGPointMake(1, 1);
    [_sscrollview.layer addSublayer:gradientLayer];
}

// CATextLayer：文本图层
- (void)case5_CATextLayer {
    
    CATextLayer *text_layer=[CATextLayer layer];
    text_layer.backgroundColor= [UIColor grayColor].CGColor;
    text_layer.frame    = CGRectMake(xx3, yy1, 100, 100);
    text_layer.string   = @"这是一文本图层:挖掘机技术哪家强 ？到山东找蓝翔！应该怎样显示，自己设置。 ";
    text_layer.wrapped  = YES;                          // 多行显示
    text_layer.fontSize = 14.0;                         // 字体大小
    text_layer.truncationMode= kCATruncationMiddle;     // 省略模式
    text_layer.alignmentMode = kCAAlignmentJustified;   // 位居模式
    [_sscrollview.layer addSublayer:text_layer];
}

// CAEmitterLayer：高性能的粒子引擎
- (void)case6_CAEmitterLayer {
    
    //创建CAEmitterLayer对象，并添加到layer层
    CAEmitterLayer *emitter = [CAEmitterLayer layer];
    CGRect rect   = CGRectMake(xx2, yy2, 10, 10);
    emitter.frame = rect;
    emitter.borderWidth= 1;
    emitter.borderColor= Cyan_COLOR.CGColor;
    [_sscrollview.layer addSublayer:emitter];
    
    //配置CAEmitterLayer对象
    emitter.renderMode      = kCAEmitterLayerOldestFirst;
    emitter.scale           = 0.3;
    emitter.emitterPosition = CGPointMake(CGRectGetWidth(rect)/2.0, CGRectGetHeight(rect)/2.0);
    emitter.emitterDepth    = 100;
    //创建CAEmitterCell对象
    CAEmitterCell *cell = [[CAEmitterCell alloc] init];
    cell.birthRate      = 10;
    cell.lifetime       = 5.0;
    cell.velocity       = 30;
    cell.velocityRange  = 30;
    cell.contents       = (__bridge id)[UIImage imageNamed:@"樱花瓣2.png"].CGImage;
    //cell.color          = [UIColor yellowColor].CGColor;
    cell.alphaSpeed     = -0.2;
    //设置成圆形扩散发射
    cell.emissionRange  = M_PI * 2.0;
    //添加
    emitter.emitterCells = @[cell];
}

// CATransform3D： 三维变换图层: 用于图层的旋转，缩放，偏移，歪斜和应用的透视 (三维变换：4x4CGFloat值的矩阵)
- (void)case3_CATransform3D {

    UIImage *image  = [UIImage imageNamed:@"scene1.png"];
    CALayer *layer1 = [CALayer layer];  [_sscrollview.layer addSublayer:layer1];
    CALayer *layer2 = [CALayer layer];  [_sscrollview.layer addSublayer:layer2];
    [self setLayer:layer1 frame:CGRectMake(10, yy3, 130, 200) bgColor:BgColor image:image];
    [self setLayer:layer2 frame:CGRectMake(150, yy3, 130, 200) bgColor:BgColor image:image];
    
    CATransform3D transform1 = CATransform3DIdentity;
    transform1 = CATransform3DRotate(transform1, M_PI_4, 0, 1, 0);
    layer1.transform = transform1;
    
    CATransform3D transform2 = CATransform3DIdentity;
    transform2.m34 = - 1/ 200.0;
    transform2 = CATransform3DRotate(transform2, M_PI_4, 0, 1, 0);
    layer2.transform = transform2;
}

- (void)addScrollView{
    self.sscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SSWIDTH, SSHEIGHT)];
    self.sscrollview.contentSize = CGSizeMake(SSWIDTH,SSHEIGHT*3);
    self.sscrollview.showsVerticalScrollIndicator = NO;
    self.sscrollview.showsHorizontalScrollIndicator= NO;
    self.sscrollview.delegate= self;
    self.sscrollview.layer.borderColor = Color_8BC34A.CGColor;
    self.sscrollview.layer.borderWidth = 1;
    [self.view addSubview:self.sscrollview];
}

@end
