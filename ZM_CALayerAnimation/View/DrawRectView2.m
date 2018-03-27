//
//  DrawRectView2.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/13.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "DrawRectView2.h"
#import "BaseHeader.h"

//#include <CoreFoundation/CFBase.h>
//#include <CoreFoundation/CFAvailability.h>
//#include <stdint.h>
//
//#include <CoreGraphics/CGBase.h>
//#include <CoreGraphics/CGAffineTransform.h>
//#include <CoreGraphics/CGColor.h>
//#include <CoreGraphics/CGColorSpace.h>
//#include <CoreGraphics/CGFont.h>
//#include <CoreGraphics/CGGradient.h>
//#include <CoreGraphics/CGImage.h>
//#include <CoreGraphics/CGPath.h>
//#include <CoreGraphics/CGPattern.h>
//#include <CoreGraphics/CGPDFDocument.h>
//#include <CoreGraphics/CGShading.h>

@implementation DrawRectView2

- (instancetype)initWithFrame:(CGRect)frame {
    self= [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

//static CGFloat xx1= 10, xx2= 150, xx3= 280;
//static CGFloat yy1= 10, yy2= 100, yy3= 260;
// Drawing code
- (void)drawRect:(CGRect)rect {
    
    [self test];
}


- (void)test {
    
    //创建画板
    CGContextRef cxt = UIGraphicsGetCurrentContext(); //设置上下文
    CGContextSetLineWidth(cxt, 5.0); //线条宽度
    //画一条直线
    CGContextSetStrokeColorWithColor(cxt, Red_COLOR.CGColor);//线条颜色
    CGContextMoveToPoint(cxt, 5, 20);       //点1（起点坐标）
    CGContextAddLineToPoint(cxt, 300, 20);  //点2
    CGContextStrokePath(cxt);//绘制
    //绘制贝兹曲线
    CGContextSetLineWidth(cxt, 2.0);
    CGContextSetStrokeColorWithColor(cxt, Blue_Color.CGColor);
    CGContextMoveToPoint(cxt, 5, 30);
    CGContextAddCurveToPoint(cxt, 200, 50, 100, 400, 300, 400);
    CGContextStrokePath(cxt);//绘制
    
    
    
    //创建画板
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 5.0); //线条宽度
    //画虚线_1A
    CGFloat dashArray1[] = {5, 10}; //虚线间隙数组
    CGFloat count1 = sizeof(dashArray1) / sizeof(dashArray1[0]);
    CGContextSetRGBStrokeColor(ctx, 0.1, 0.2, 0.3, 1);  //线条颜色
    CGContextSetLineDash(ctx, 0, dashArray1, count1);   //画虚线
    CGContextMoveToPoint(ctx, 5, 50);       //起点坐标
    CGContextAddLineToPoint(ctx, 310, 50);  //结束点坐标
    CGContextStrokePath(ctx);//绘制
    //画虚线_1B
    CGFloat dashArray1B[] = {5, 20, 10};
    CGFloat count1B = sizeof(dashArray1B) / sizeof(dashArray1B[0]);
    CGContextSetLineDash(ctx, 0, dashArray1B, count1B);//画虚线
    CGContextMoveToPoint(ctx, 5, 70);       //起点坐标
    CGContextAddLineToPoint(ctx, 330, 70);  //结束点坐标
    CGContextStrokePath(ctx);//绘制
    //画虚线_1C
    CGFloat dashArray1C[] = {2, 3};
    CGContextSetLineDash(ctx, 0, dashArray1C, 2);//画虚线
    CGContextSetLineWidth(ctx, 2.0);
    CGContextMoveToPoint(ctx, 5, 90);       //起点坐标
    CGContextAddLineToPoint(ctx, 330, 90);  //结束点坐标
    CGContextStrokePath(ctx);//绘制
    
    //画_'曲'虚线_2
    CGFloat dashArray2[] = {3, 2, 10};
    CGContextSetStrokeColorWithColor(ctx, Color_673AB7.CGColor);//线条颜色
    CGContextSetLineDash(ctx, 0, dashArray2, 3); //画虚线
    CGContextMoveToPoint(ctx, 5, 120);           //起点坐标
    CGContextAddCurveToPoint(ctx, 200, 50, 100, 400, 300, 400);
    CGContextStrokePath(ctx);//绘制
    
    
    //画虚线_3
    CGFloat dashArray3[] = {2, 3};
    [self drawDashLineOfDashArray:dashArray3
                       startPoint:CGPointMake(5, 200)
                         endPoint:CGPointMake(305, 200) lineWidth:2 lineColor:Orange_AA ];
    
    
}

/**
 画虚线
 
 @param dashArray 虚线间隙数组
 @param startPoint  开始点 坐标
 @param endPoint    结束点 坐标
 @param lineWidth 线宽
 @param lineColor 线颜色
 */
- (void)drawDashLineOfDashArray:(const CGFloat * __nullable)dashArray
                     startPoint:(CGPoint)startPoint
                       endPoint:(CGPoint)endPoint
                      lineWidth:(CGFloat)lineWidth
                      lineColor:(UIColor *)lineColor{
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(ctx, 0, dashArray, 2);
    CGContextSetStrokeColorWithColor(ctx, lineColor.CGColor);
    CGContextSetLineWidth(ctx, lineWidth);
    CGContextMoveToPoint(ctx, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(ctx, endPoint.x, endPoint.y);
    CGContextStrokePath(ctx);
}


/*  总结
 
 画虚线
 draw_DashLine
 可参考http://blog.csdn.net/zhangao0086/article/details/7234859
 绘制虚线 方法
 CGContextSetLineDash(
    context, 
    CGFloat phase,  
    CGFloat lengths, 
    size_t count
 )
 context ： 画板
 phase   ： 参数表示在第一个虚线绘制前跳过多少个点
 lengths ： 指明虚线是如何交替绘制，具体看例子
 count   ： lengths数组的长度
 
例子讲解：
 若CGFloat lengths1[] = {5,10}; 即count= 2;
 若CGFloat lengths2[] = {5, 20, 10｝; 即count= 3;
 lengths1的值：表示先绘制5个点、隐藏10个点，再绘制5个点、隐藏10个点，  如此反复.
 lengths2的值：表示先绘制5个点，隐藏20个点，绘制10个点，再隐藏5个点，绘制20个点，隐藏10个点，如此反复.
 
 显示、隐藏、显示、隐藏、显示、隐藏...(按显示隐藏的规律：重复设置的值)
 （5、10）、（5、10）、（5、10）...(按显示隐藏的规律：重复设置的值)
 （5、20、10）、（5、20、10）...(按显示隐藏的规律：重复设置的值)
 
 //对于数组array C/C++ 的code
 //计算占用内存大小
 CGFloat aa= sizeof(dashArray1);
 //计算数组元素个数
 CGFloat bb=  sizeof(dashArray1) / sizeof(dashArray1[0]);
 NSLog(@"-->aa= %f",aa);
 NSLog(@"-->bb= %f",bb);
 
 
 
 
 //绘制连续的曲线
 CGFloat dashArray3[] = {3, 2, 10, 20, 5};
 CGContextSetLineWidth(context, 5.0);
 CGContextSetLineDash(context, 0, dashArray3, 5);//画虚线
 CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
 CGContextMoveToPoint(context, 5, 400);                          //起点
 CGContextAddCurveToPoint(context, 50, 200, 80, 300, 100, 220);  //画三次点曲线
 CGContextAddQuadCurveToPoint(context, 150, 100, 200, 200);      //画二次点曲线
 CGContextAddCurveToPoint(context, 240, 400, 10, 50, 300, 300);  //画三次点曲线
 CGContextStrokePath(context);//绘制
*/



@end
