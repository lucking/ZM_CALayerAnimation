//
//  UIBezierPath_AAView.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "UIBezierPath_AAView.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"

static NSString *_cellId = @"CellCC_Id";
static CGFloat RR = 40.f;  // 半径
@interface UIBezierPath_AAView()
{
}
@property (nonatomic ,strong) UIView* line;
@end;


@implementation UIBezierPath_AAView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        
        self.radius = 30;
        self.lineWidth = 6 ;
        self.circleCenterPoint = CGPointMake(_radius+10 , _radius+100);
        self.strokeColor = [UIColor lightGrayColor];
        self.fillColor = [UIColor blueColor];
        
        [self addSubview:self.line];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    //UIBezierPath *bezierPath;

    // 画线
    [self drawLine];
    // 画多边形
    [self drawRectangle];
    // 画圆
    [self drawCircle1];
    [self drawCircle2];
    [self drawCircle3];
    [self drawCircle4];
    [self drawCircle5];
    // 画进度条
    [self drawProgress];
    // 画曲线
    [self drawCurvePath];
}

// 画线
- (void)drawLine {
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(10, 10)];     // 起点
    [linePath addLineToPoint:CGPointMake(70, 50)];  // 第2个点
    [linePath addLineToPoint:CGPointMake(100, 5)];  // 第3个点
    [linePath addLineToPoint:CGPointMake(130, 20)]; // 第4个点
    
    //属性设置（使用属性填充）
    //    [_fillColor setFill];       //设置 填充色
    //    [_strokeColor setStroke];   //设置 表面色
    //    [linePath setLineWidth:1];
    //    [linePath stroke];
    //    [linePath fill];
    //同上 （使用图层填充）
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = _strokeColor.CGColor;
    lineLayer.fillColor = _fillColor.CGColor;
    lineLayer.speed       = 0.6;    // 绘制的速度 （动画时间的百分比：0.0~1.0 * duration）
    lineLayer.lineWidth   = 2.0f;   // 线条宽度
    [self.layer addSublayer:lineLayer];
    
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:0.9f]; 
    [lineLayer addAnimation:pathAnimation forKey:nil];
    
}
// 画多边形
- (void)drawRectangle {
    
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(150, 10)];    // 起点
    [linePath addLineToPoint:CGPointMake(210, 10)]; // 第2个点
    [linePath addLineToPoint:CGPointMake(230, 40)]; // 第3个点
    [linePath addLineToPoint:CGPointMake(180, 70)]; // 第4个点
    [linePath addLineToPoint:CGPointMake(140, 40)]; // 第5个点
    [linePath closePath];
    
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = linePath.CGPath;
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = Color_005DC3.CGColor;
    lineLayer.fillColor = BgLightColor.CGColor;
    [self.layer addSublayer:lineLayer];
}
/**
 *  这个工厂方法用于画弧，参数说明如下：
 
 * 该方法会创建出一个开放路径, 创建出来的圆弧是圆的一部分. 在默认的坐标系统中, 开始角度 和 结束角度 都是基于单位圆的(看下面这张图). 调用这个方法之后, currentPoint 将会设置为圆弧的结束点.
 * 举例来说: 指定其实角度为0, 指定结束角度为π, 设置 clockwise 属性为 YES, 将会绘制出圆的下半部分.
 * 然而当我们不修改起始角度 和 结束角度, 我们仅仅将 clockwise 角度设置为 NO, 则会绘制出来一个圆的上半部分.
 * @ center:    圆心
 * @ radius:    半径
 * @ startAngle: 起始角度
 * @ endAngle:   结束角度
 * @ clockwise:  是否顺时针绘制
 
 + (instancetype) bezierPathWithArcCenter:(CGPoint)center
    radius:(CGFloat)radius
    startAngle:(CGFloat)startAngle
    endAngle:(CGFloat)endAngle
    clockwise:(BOOL)clockwise;
 
 // 添加圆到path
 // radius= R：半径
 // M_PI= 180度
 
  */
// 画圆_1
- (void)drawCircle1
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(60, 130)
                          radius: RR
                      startAngle:0.0
                        endAngle:M_PI*0.5
                       clockwise:YES];
    //设置属性
    [Color_XXXXXX setFill];     //闭环填充的颜色
    [_strokeColor setStroke];   //边线颜色
    [circlePath setLineWidth:2];//边宽
    [circlePath stroke];        //启动 边框设置
    [circlePath fill];          //启动 内部填充
    
    
}
// 画圆_2
- (void)drawCircle2
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(160,130)
                          radius: RR
                      startAngle:0.0
                        endAngle:M_PI*1
                       clockwise:YES];
    //设置属性
    [Color_XXXXXX setFill];     //闭环填充的颜色
    [_strokeColor setStroke];   //边线颜色
    [circlePath setLineWidth:2];//边宽
    [circlePath stroke];        //启动 边框设置
    [circlePath fill];          //启动 内部填充
}
// 画圆_3
- (void)drawCircle3
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(260,130)
                          radius: RR
                      startAngle:0.0
                        endAngle:M_PI*1.5
                       clockwise:YES];
    //设置属性
    [Color_XXXXXX setFill];     //闭环填充的颜色
    [_strokeColor setStroke];   //边线颜色
    [circlePath setLineWidth:2];//边宽
    [circlePath stroke];        //启动 边框设置
    [circlePath fill];          //启动 内部填充
}

// 画圆_4
- (void)drawCircle4
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(60,260)
                          radius:(RR+10.f)
                      startAngle:0.5
                        endAngle:M_PI*1.5
                       clockwise:YES];
    //设置属性
    [Color_XXXXXX setFill];     //闭环填充的颜色
    [_strokeColor setStroke];   //边线颜色
    [circlePath setLineWidth:2];//边宽
    [circlePath stroke];        //启动 边框设置
    [circlePath fill];          //启动 内部填充
}
// 画圆_5
- (void)drawCircle5
{
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(200,260)
                          radius:(RR+10.f)
                      startAngle:0.0
                        endAngle:M_PI*2
                       clockwise:YES];
    //设置属性
    [Color_XXXXXX setFill];     //闭环填充的颜色
    [_strokeColor setStroke];   //边线颜色
    [circlePath setLineWidth:2];//边宽
    [circlePath stroke];        //启动 边框设置
    [circlePath fill];          //启动 内部填充

}


// 画进度条
static CGFloat WWHH = 100;  // 的高度
- (void)drawProgress {
    
    // 贝塞尔曲线(创建一个圆)  radius：半径R
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(WWHH/2.f, WWHH/2.f)
                                                        radius:WWHH/2.f
                                                    startAngle:0
                                                      endAngle:M_PI * 2
                                                     clockwise:YES];
    // 创建一个shapeLayer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame         = CGRectMake(20, 350, WWHH, WWHH);// 与showView的frame一致
    layer.strokeColor   = [UIColor redColor].CGColor;   // 边缘线的颜色
    layer.fillColor     = [UIColor clearColor].CGColor; // 闭环填充的颜色
    layer.lineCap       = kCALineCapSquare;             // 边缘线的类型
    layer.path          = path.CGPath;                  // 从贝塞尔曲线获取到形状
    layer.lineWidth     = 6.0f; // 线条宽度
    layer.strokeStart   = 0.0f; // 弧线开始的角度值
    layer.strokeEnd     = 0.8f; // 弧线结束的角度值
    [self.layer addSublayer:layer];
    //动画
    [self performSelector:@selector(mainThread:) withObject:layer afterDelay:1];
}

// 画曲线
- (void)drawCurvePath {
    
    [Green_00CD66 set]; //设置线条颜色
    UIBezierPath* aPath = [UIBezierPath bezierPath];
    aPath.lineWidth = 1.0;
    aPath.lineCapStyle  = kCGLineCapRound; //线条拐角
    aPath.lineJoinStyle = kCGLineCapRound; //终点处理
    
    [aPath moveToPoint:CGPointMake(120, 280)];
    [aPath addCurveToPoint:CGPointMake(300, 350)
             controlPoint1:CGPointMake(210, 300)
             controlPoint2:CGPointMake(210, 400)];
//    [aPath addLineToPoint:CGPointMake(230, 450)];
    [aPath stroke];

    //（使用图层填充）
    CAShapeLayer *lineLayer = [CAShapeLayer layer];
    lineLayer.path = aPath.CGPath;
    lineLayer.lineWidth = 1;
    lineLayer.strokeColor = _strokeColor.CGColor;
    lineLayer.fillColor = _fillColor.CGColor;
    lineLayer.speed       = 0.6;    // 绘制的速度 （动画时间的百分比：0.0~1.0 * duration）
    lineLayer.lineWidth   = 2.0f;   // 线条宽度
    [self.layer addSublayer:lineLayer];
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration  = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue   = [NSNumber numberWithFloat:1.0f]; 
    [lineLayer addAnimation:pathAnimation forKey:nil];

}

//主线程
-(void)mainThread:(CAShapeLayer *)layer
{
    //NSLog(@"obj = %@",layer);
    //layer.strokeStart = 0.0;
    //layer.strokeEnd   = 0.9f;
    layer.speed       = 0.6;    // 绘制的速度 （动画时间的百分比：0.0~1.0 * duration）
    layer.lineWidth   = 2.0f;   // 线条宽度
    // 给这个layer添加动画效果
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:0.9f]; //1.0f：是正圆（0.0~1.0 整圆的占比）
    [layer addAnimation:pathAnimation forKey:nil];
}


- (UIView *)line {
    if (_line==nil) {
        _line = [[UIView alloc] initWithFrame:CGRectMake(0, 130, self.width, 1)];
        _line.backgroundColor = Gray_888888;
    }
    return _line;
}
//
- (CGFloat)strokeStart {
    return _mylayer.strokeStart;
}
- (void)setStrokeStart:(CGFloat)strokeStart {
    _mylayer.strokeStart = strokeStart;
}
//
- (CGFloat)strokeEnd {
    return _mylayer.strokeEnd;
}
- (void)setStrokeEnd:(CGFloat)strokeEnd {
    _mylayer.strokeEnd = strokeEnd;
}

@end
