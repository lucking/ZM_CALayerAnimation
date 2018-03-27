//
//  GraphicsView.m
//  ZM_CGContextRef
//
//  Created by tangdi on 15/6/30.
//  Copyright (c) 2015年 ZM. All rights reserved.
//

#import "GraphicsView.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"
#import "DrawRect_imgBgView.h"
@interface GraphicsView()
{
    
}
@property (nonatomic, strong) DrawRect_imgBgView *imgBgView;
@end

@implementation GraphicsView

- (instancetype)init {
    self= [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self){
        [self commonInit];// 公共初始化方法
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self){
        [self commonInit];// 公共初始化方法
    }
    return self;
}
#pragma mark 公共初始化方法
- (void)commonInit {

}

static CGFloat xx1= 10, xx2= 150;
static CGFloat yy1= 10, yy2= 330, yy3= 440, yy4= 570, yy5= 690, yy6= 800, yy7= 1100, yy8= 1470,
yy9= 1900;

//只覆盖drawRect:如果您执行自定义绘制。
//一个空的实现会在动画中对性能产生负面影响。
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 写文字
    [self drawRectString:CGRectMake(xx1, yy1, 100, 50)];
    // 画直线
    [self drawLine];
    // 画矩形
    [self drawRectangle];
    // 画圆弧线
    [self drawCircle];
    // 画贝塞尔曲线
    [self drawCurve];
    // 画图片
    [self drawImage];
    
    
    //多个点
    const CGPoint points[] = { CGPointMake(150, 20),CGPointMake(250, 20),
                               CGPointMake(160, 50),CGPointMake(260, 50),
                               CGPointMake(170, 80),CGPointMake(270, 80),
                             };
    int length= sizeof(points)/sizeof(points[0]); // 获取以为数组的 个数
    NSLog(@"length= %d",length);

    
    //画多条线（一次性）
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    
//    for(int k = 0; k < length; k += 2) {
//        
//        NSLog(@"k%d.x=%f,  k%d.y=%f",k,points[k].x,k,points[k].y);
//        NSLog(@"k%d.x=%f,  k%d.y=%f \n ",k,points[k+1].x,k,points[k+1].y);
//
//        CGContextMoveToPoint(ctx,points[k].x, points[k].y);
//        CGContextAddLineToPoint(ctx,points[k+1].x, points[k+1].y);
//        [Red_COLOR setStroke];
//    }CGContextStrokePath(ctx);

    //同上
    CGContextSetLineWidth(ctx, 1);
    [Red_COLOR setStroke];
    CGContextStrokeLineSegments(ctx, points,length);
    
}


// 写文字
- (void)drawRectString:(CGRect)rect{
    //获得当前画板
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //方式一：设置字体
    //[@"内容：我是文字" drawInRect:CGRectMake(10, 10, 100, 30) withFont:[UIFont systemFontOfSize:16]];
    //方式二：设置字体
    NSDictionary* myDic=[NSDictionary dictionaryWithObjectsAndKeys:
                         [UIFont boldSystemFontOfSize:14],NSFontAttributeName,
                         [UIColor magentaColor],NSForegroundColorAttributeName,nil];
    //开始写字
    NSString *string= @"内容：我是文字 阿什都德个环境就快来临了";
    [string drawInRect:rect withAttributes:myDic];
    
    
    //绘制矩形
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextAddRect(ctx, rect);
    CGContextAddPath(ctx, path);
    CGContextSetLineWidth(ctx, 1);                              //边框宽度
    CGContextSetFillColorWithColor(ctx, Red_EEAEEE.CGColor);    //填充颜色
    CGContextSetStrokeColorWithColor(ctx, Bule_5CACEE.CGColor);
    CGContextStrokeRect(ctx, rect);                             //画矩形边框
//    CGContextClosePath(ctx);                                    //画矩形实体
    CGContextDrawPath(ctx, kCGPathFillStroke);                  //绘制路径

}
// 画直线
- (void)drawLine {
    //画直线有两种形式：分为（闭合路径、不闭合路径）
    
    //画直线
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.25);               //画线的宽度
    CGContextSetRGBStrokeColor(context, 0,0.25,0, 0.5); //线条颜色
    CGContextMoveToPoint(context, xx2, 10);         //起点坐标
    CGContextAddLineToPoint(context, xx2+150, 40);  //终点坐标
    CGContextStrokePath(context); //绘制路径

    //画直线：（闭合路径 为多边形）这里画三个点，三角形
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [Red_COLOR setStroke];  //边线
    [Bule_5CACEE setFill];  //填充颜色
    CGContextMoveToPoint(ctx, xx1, 80);      //点1（起点）
    CGContextAddLineToPoint(ctx, 180, 180);  //点2
    CGContextAddLineToPoint(ctx, xx1, 180);  //点3（终点）
    CGContextClosePath(ctx);                    //闭合路径
    CGContextDrawPath(ctx, kCGPathFillStroke);  //绘制路径
    
    
    //画菱形：填充  FillPath      （没有闭合路径，画出所有的线）
    CGContextRef ctx61 = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx61, 70, 200);
    CGContextAddLineToPoint(ctx61, 120, 250);
    CGContextAddLineToPoint(ctx61, 70, 300);
    CGContextAddLineToPoint(ctx61, 20, 250);
    CGContextAddLineToPoint(ctx61, 70, 200);
    CGContextSetFillColorWithColor(ctx61, Red_EEAEEE.CGColor);
    CGContextFillPath(ctx61);
    //画菱形：边框  StrokePath    （没有闭合路径，画出所有的线）
    CGContextRef ctx6 = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx6, 180, 200);
    CGContextAddLineToPoint(ctx6, 230, 250);
    CGContextAddLineToPoint(ctx6, 180, 300);
    CGContextAddLineToPoint(ctx6, 130, 250);
    CGContextAddLineToPoint(ctx6, 180, 200);
    CGContextSetLineWidth(ctx6, 2.0);
    CGContextSetStrokeColorWithColor(ctx6, Green5F9EA0.CGColor);
    CGContextStrokePath(ctx6);
    //画菱形：填充+边框  DrawPath   （闭合路径）
    CGContextRef ctx3 = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx3, 300, 200);
    CGContextAddLineToPoint(ctx3, 350, 250);
    CGContextAddLineToPoint(ctx3, 300, 300);
    CGContextAddLineToPoint(ctx3, 250, 250);
    CGContextSetLineWidth(ctx3, 2.0);
    CGContextSetFillColorWithColor(ctx3, Red_EEAEEE.CGColor);
    CGContextSetStrokeColorWithColor(ctx3, Green5F9EA0.CGColor);
    CGContextClosePath(ctx3);
    CGContextDrawPath(ctx3, kCGPathFillStroke);  //绘制路径
    
}
- (void)extracted:(CGFloat)xx4 {
    [self drawRectangleFrame:CGRectMake(xx4, yy2, 60.0f, 80.0f)
                 strokeColor:Purple_Color
                   fillColor:Green698B69
                   lineWidth:2.0f];
}

// 画矩形
- (void)drawRectangle {
    
    static CGFloat xx1= 10, xx2= 110, xx3= 190, xx4= 270 ;

    //获得当前画板 DrawPath
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();         //创建路径：并获取句柄
    CGContextAddRect(context, CGRectMake(xx1,yy2,80, 30)); //将矩形添加到路径中
    CGContextAddPath(context, path);                       //将路径添加到画布
    CGContextSetLineWidth(context, 2);              //画线的宽度
    [Red_COLOR setStroke];                          //边线颜色
    [Yellow_COLOR setFill];                         //内部颜色
    CGContextDrawPath(context, kCGPathFillStroke);  //绘制
    CGPathRelease(path);
    
    //画矩形 实心    FillRect
    CGContextRef ctx1 = UIGraphicsGetCurrentContext();
    [Green698B69 setFill];
    CGContextFillRect(ctx1, CGRectMake(xx2, yy2, 60, 80));
    CGContextFillPath(ctx1);
    //画矩形 边框    StrokeRect
    CGContextRef ctx2 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx2, 3);
    [Purple_Color setStroke];
    CGContextStrokeRect(ctx2, CGRectMake(xx3, yy2, 60, 80));
    CGContextStrokePath(ctx2);
    //画矩形 实心+边框  DrawPath
    [self extracted:xx4];
}

/** 画矩形 （封装的方法）
 @param rect 指定矩形
 @param strokeColor 边线颜色
 @param fillColor   内部颜色
 @param lineWidth   边线宽度
 */
- (void)drawRectangleFrame:(CGRect)rect strokeColor:(UIColor *)strokeColor
                 fillColor:(UIColor *)fillColor
                 lineWidth:(CGFloat)lineWidth {

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextAddRect(context, rect);
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, lineWidth);
    [strokeColor setStroke];
    [fillColor setFill];
    CGContextDrawPath(context, kCGPathFillStroke);
    CGPathRelease(path);
}


static CGFloat x1= 10, x2= 85, x3= 160;
// 画：圆/椭圆/圆弧线
- (void)drawCircle {

    //画圆/椭圆  边框         StrokeEllipseInRect+ StrokePath
    CGContextRef ctx1 = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx1, 2.0);
    [OrangeColor setStroke];
    CGContextStrokeEllipseInRect(ctx1, CGRectMake(x1, yy3, 60, 60));
    CGContextStrokePath(ctx1);
    //画圆/椭圆  实心         FillEllipseInRect+ FillPath
    CGContextRef ctx2 = UIGraphicsGetCurrentContext();
    [Color_CDDC39 setFill];
    CGContextFillEllipseInRect(ctx2, CGRectMake(x2, yy3, 60, 60));
    CGContextFillPath(ctx2);
    //画圆/椭圆  实心+边框     AddEllipseInRect+ DrawPath
    CGContextRef ctx3 = UIGraphicsGetCurrentContext();
    [OrangeColor setStroke];
    [Color_CDDC39 setFill];
    CGContextAddEllipseInRect(ctx3, CGRectMake(x3, yy3, 60, 60));
    CGContextDrawPath(ctx3, kCGPathFillStroke);
    //画椭圆1
    CGContextAddEllipseInRect(ctx3, CGRectMake(235, yy3, 10, 60));
    CGContextDrawPath(ctx3, kCGPathFillStroke);
    //画椭圆2
    CGContextAddEllipseInRect(ctx3, CGRectMake(260, yy3, 80, 50));
    CGContextDrawPath(ctx3, kCGPathFillStroke);
    
    
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    
    static CGFloat x11= 10, x22= 70, x33= 160, x44= 260;
    //画圆/扇形  （ 画扇形，也就画圆，只不过是设置角度的大小，形成一个扇形）
    float rr= 40;
    CGPoint center= CGPointMake(x11+40, yy4);
    CGContextSetLineWidth(context,5);
    [Green_00CD66 setStroke];
    [Purple_CD69C9 setFill];
    CGContextMoveToPoint(context, center.x, center.y);//起点：中心点
    CGContextAddArc(context, center.x, center.y, rr, 0, 2*M_PI, 0);  //添加一个圆
    CGContextClosePath(context);                    //闭合路径回到中心
    CGContextDrawPath(context, kCGPathFillStroke);  //绘制内外
    //画圆：不闭合
    CGContextAddArc(context, 150, yy4, 40, M_PI/2, M_PI, 1);
    [Green_00CD66 setStroke];
    CGContextSetLineCap(context, kCGLineCapRound); // 边缘线的类型
    CGContextDrawPath(context, kCGPathStroke);
    //画圆：闭合
    CGContextAddArc(context, 150+100, yy4, 40, M_PI/2, M_PI, 1);
    [Green_00CD66 setStroke];
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke); //绘制路径
    CGFloat R2= 50; //以50为半径
    //画扇形1
    [Purple_AB82FF setFill];
    CGContextMoveToPoint(context, x22, yy5);
    CGContextAddArc(context, x22, yy5, R2,  M_PI*0.3, M_PI*0.6, 1);     //逆时针_1
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    //画扇形2
    CGContextMoveToPoint(context, x33, yy5);
    CGContextAddArc(context, x33,yy5, R2,  M_PI*0.3, M_PI*0.6, 0);      //顺时针_0
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    //画扇形3
    CGContextMoveToPoint(context, x44, yy5);
    CGContextAddArc(context, x44,yy5+60, 120,  M_PI*1.3, M_PI*1.7, 0);  //顺时针_0
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    
    //画切弧线
    CGPoint p[3] =
    {
        CGPointMake(x2, yy6-30),
        CGPointMake(x2, yy6),
        CGPointMake(x2+30, yy6),
    };
    //先移到p1点
    CGContextMoveToPoint(ctx1, p[0].x, p[0].y);
    //从p1点开始画弧线，圆弧和p1-p2相切;p2-p3和弧线相切,圆弧的半径是20
    //先画俩条线从point 到 第1点 ，从第1点到第2点的线  切割里面的圆
    CGContextAddArcToPoint(ctx1, p[1].x, p[1].y, p[2].x, p[2].y, 30);
    CGContextStrokePath(ctx1);
    
    //小圆点
    CGFloat RR= 3;
    CGContextRef ctx5 = UIGraphicsGetCurrentContext();
    [Red_COLOR setFill];
    CGContextFillEllipseInRect(ctx5, CGRectMake(x2, yy6-30, RR, RR));
    CGContextFillEllipseInRect(ctx5, CGRectMake(x2, yy6, RR, RR));
    CGContextFillEllipseInRect(ctx5, CGRectMake(x2+30, yy6, RR, RR));
    CGContextFillPath(ctx5);
    
    /* 画圆弧线
     CGContextAddArc(ctx, x。, y。, r, sA, eA, cw)
     //圆心坐标(x。,y。)
     CGFloat x,          //圆心x。
     CGFloat y,          //圆心y。
     CGFloat radius,     // radius半径
     CGFloat startAngle, // startAngle 开始的弧度
     CGFloat endAngle,   // endAngle   结束的弧度
     int clockwise)      // clockwise  0为顺时针，1为逆时针
     
     // CGContextAddArc(ctx, x,y,r, 0,2*M_PI, 0);//添加一个圆
     // 1弧度＝180°/π （≈57.3°） 度＝弧度×180°/π 360°＝360×π/180 ＝2π 弧度
     */

}

// 画贝塞尔曲线
- (void)drawCurve {
    // 贝塞尔曲线(Bézier curve)，又称贝兹曲线或贝济埃曲线
    /*画贝塞尔曲线

     2.附加从当前点到(x，y)的二次曲线与控制”,点“(cpx cpy)”
       CGContextAddQuadCurveToPoint(context, cpx, cpy,  x, y)
       理解：设置贝塞尔曲线的 控制点1、终点2
     
     3.从当前点到(x，y)添加一个立方体的曲线”,与  控制点”(cp1x cp1y)”和“(cp2x cp2y)”。
       CGContextAddCurveToPoint(context,  cp1x, cp1y,  cp2x, cp2y,  x, y)
       理解：设置贝塞尔曲线的 控制点1、控制点2、终点3
    
     总结：贝兹曲线是通过移动一个起始点，然后通过控制点,还有一个中止点，调用CGContextAddCurveToPoint() 函数绘制
     
     */
    
    CGContextRef context= UIGraphicsGetCurrentContext();

    //一次曲线：即直线  AddLineToPoint
    CGContextSetLineWidth(context, 2.25);
    [Red_COLOR setStroke];
    CGContextMoveToPoint(context, 20, 30+yy6);       //起点
    CGContextAddLineToPoint(context, 200, 30+yy6);   //终点
    CGContextStrokePath(context); //绘制路径
    
    
    CGFloat xxA= 20,  yyA= 130+yy6;
    CGFloat xxB= 40,  yyB= 300+yy6;
    CGFloat xxC= 10,  yyC= 500+yy6;

// 二次曲线       AddQuadCurveToPoint
    CGPoint pointA0= CGPointMake(xxA,     yyA);
    CGPoint pointA1= CGPointMake(xxA+50,  yyA-80);
    CGPoint pointA2= CGPointMake(xxA+140, yyA);
    CGContextMoveToPoint(context, pointA0.x, pointA0.y);//起点
    [Red_COLOR setStroke];
    CGContextAddQuadCurveToPoint(context,pointA1.x, pointA1.y,
                                         pointA2.x, pointA2.y);
    CGContextStrokePath(context);//绘制路径
    //设置二次曲线 的控制点和线：便于观察
    [self setQuadCurvePoint0:pointA0 Point1:pointA1 Point2:pointA2];

    
    
// 三次曲线函数1    AddCurveToPoint
    CGPoint pB0= CGPointMake(xxB,     yyB);
    CGPoint pB1= CGPointMake(xxA,     yyB-130);
    CGPoint pB2= CGPointMake(xxA+200, yyB-130);
    CGPoint pB3= CGPointMake(xxB+280, yyB);
    [Red_COLOR setStroke];
    CGContextMoveToPoint(context, pB0.x, pB0.y);//起点
    CGContextAddCurveToPoint(context, pB1.x, pB1.y,
                                      pB2.x, pB2.y,
                                      pB3.x, pB3.y);
    CGContextStrokePath(context);//绘制路径
    //设置三次曲线1 的控制点和线
    [self setCurvePoint0:pB0 Point1:pB1 Point2:pB2 Point3:pB3];
    
    
// 三次曲线函数2    AddCurveToPoint
    CGPoint pC0= CGPointMake(xxC,     yyC);
    CGPoint pC1= CGPointMake(xxC+30,  yyC-130);
    CGPoint pC2= CGPointMake(xxC+120, yyC+130);
    CGPoint pC3= CGPointMake(xxC+130, yyC-80);
    [Red_COLOR setStroke];
    CGContextMoveToPoint(context, pC0.x, pC0.y);//起点
    CGContextAddCurveToPoint(context, pC1.x, pC1.y, pC2.x, pC2.y, pC3.x, pC3.y);
    CGContextStrokePath(context);//绘制路径
    //设置三次曲线2 的控制点和线
    [self setCurvePoint0:pC0 Point1:pC1 Point2:pC2 Point3:pC3];
    
    
    
    /*画贝塞尔曲线*/
    //二次曲线
    [Green_Color setStroke];
    CGContextMoveToPoint(context, 120, 300+yy6);
    CGContextAddQuadCurveToPoint(context,190, 310+yy6, 120, 390+yy6);
    CGContextStrokePath(context);
    //三次曲线函数
    CGContextMoveToPoint(context, 200, 300+yy6);
    CGContextAddCurveToPoint(context,250, 280+yy6, 250, 400+yy6, 280, 300+yy6);
    CGContextStrokePath(context);//绘制路径
    //绘制连续的曲线
    CGContextSetLineWidth(context, 5.0);
    CGContextSetStrokeColorWithColor(context, Green_Color.CGColor);
    CGContextMoveToPoint(context, 230, 150+yy7);//开始画线, 起点坐标
    CGContextAddCurveToPoint(context, 310, 100+yy7, 300, 200+yy7, 220, 220+yy7);//画三次点曲线
    CGContextAddCurveToPoint(context, 290, 140+yy7, 280, 180+yy7, 240, 190+yy7);//画三次点曲线
    CGContextStrokePath(context);//绘制

    //贝塞尔曲线一,两个控制点
    CGContextRef ctx= UIGraphicsGetCurrentContext();
    CGPoint start = CGPointMake(30.0, 120+yy7+200); //起始点
    CGPoint end = CGPointMake(300.0, 120+yy7+200);//终点
    CGPoint cp1 = CGPointMake(120.0, 30+yy7+200);//控制点1
    CGPoint cp2 = CGPointMake(210.0, 210+yy7+200);//控制点2
    CGContextMoveToPoint(ctx, start.x, start.y);
    CGContextAddCurveToPoint(ctx, cp1.x, cp1.y, cp2.x, cp2.y, end.x, end.y);
    CGContextStrokePath(ctx);

    
}

// 画图
- (void)drawImage {
    
    CGContextRef context= UIGraphicsGetCurrentContext();
    /*图片*/
    CGFloat ww=130, hh=100;
    UIImage *img1 = [UIImage imageNamed:@"m0.jpg"];
    UIImage *img2 = [UIImage imageNamed:@"scene1_1.png"];

    [img1 drawInRect:CGRectMake(20, yy8, ww, hh)];  //在坐标中画出图片
    CGContextDrawImage(context, CGRectMake(170, yy8, ww, hh), img1.CGImage);//使用这个使图片上下颠倒了
    [img2 drawAtPoint:CGPointMake(20, yy8+120)];    //保持原图片大小,以point为起点开始画图

    
    //平铺图
    [self addSubview:self.imgBgView];
    //CGContextDrawTiledImage(context, CGRect);
}

//---------"  二次曲线 的控制点和线  （这里对曲线没有影响，只是为了便于观察）  "-----------
- (void)setQuadCurvePoint0:(CGPoint)point0 Point1:(CGPoint)point1 Point2:(CGPoint)point2
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    //小圆点
    CGFloat R= 5;
    [Green_00CD66 setFill];
    CGContextFillEllipseInRect(context, CGRectMake(point0.x -R/2, point0.y -R/2, R, R));
    CGContextFillEllipseInRect(context, CGRectMake(point1.x -R/2, point1.y -R/2, R, R));
    CGContextFillEllipseInRect(context, CGRectMake(point2.x -R/2, point2.y -R/2, R, R));
    CGContextFillPath(context); //绘制路径
    //画直线
    [Gray_888888 setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint   (context, point0.x, point0.y); //起点0
    CGContextAddLineToPoint(context, point1.x, point1.y); //点1
    CGContextAddLineToPoint(context, point2.x, point2.y); //点2
    CGContextStrokePath(context); //绘制路径
}

//---------"  三次曲线 的控制点和线  （这里对曲线没有影响，只是为了便于观察）  "-----------
- (void)setCurvePoint0:(CGPoint)point0 Point1:(CGPoint)point1
                Point2:(CGPoint)point2 Point3:(CGPoint)point3
{
    CGContextRef context= UIGraphicsGetCurrentContext();
    //小圆点
    CGFloat R= 5;
    [Green_00CD66 setFill];
    CGContextFillEllipseInRect(context, CGRectMake(point0.x -R/2, point0.y -R/2, R, R));
    CGContextFillEllipseInRect(context, CGRectMake(point1.x -R/2, point1.y -R/2, R, R));
    CGContextFillEllipseInRect(context, CGRectMake(point2.x -R/2, point2.y -R/2, R, R));
    CGContextFillEllipseInRect(context, CGRectMake(point3.x -R/2, point3.y -R/2, R, R));
    CGContextFillPath(context); //绘制路径
    //画直线
    [Gray_888888 setStroke];
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint   (context, point0.x, point0.y); //起点0
    CGContextAddLineToPoint(context, point1.x, point1.y); //点1
    CGContextAddLineToPoint(context, point2.x, point2.y); //点2
    CGContextAddLineToPoint(context, point3.x, point3.y); //点3
    CGContextStrokePath(context); //绘制路径
}


- (DrawRect_imgBgView *)imgBgView {
    if (_imgBgView==nil) {
        _imgBgView = [[DrawRect_imgBgView alloc] initWithFrame:CGRectMake(10, yy9, self.width-20, 300)];
    }
    return _imgBgView;
}

/*
 画图的步骤原则：（顺序不可改变，否则会影响其他类型 属性的设置）
 
 1.创建画板：CGContextRef ctx = UIGraphicsGetCurrentContext();
 2.设置属性：颜色、线宽、边角弧度
 3.添加绘制的类型：点、线、矩形、圆/椭圆
 4.绘制路径
 
 //填充模式
 //    typedef CF_ENUM (int32_t, CGPathDrawingMode) {
 //        kCGPathFill,          //只填充内容
 //        kCGPathEOFill,
 //        kCGPathStroke,        //只填充边框
 //        kCGPathFillStroke,    //填充内容和边框
 //        kCGPathEOFillStroke
 //    };
 
 画曲线
 CG_EXTERN void CGContextAddCurveToPoint(
 CGContextRef cg_nullable c,
 CGFloat cp1x,
 CGFloat cp1y,
 CGFloat cp2x,
 CGFloat cp2y,
 CGFloat x,
 CGFloat y
 )
 CG_AVAILABLE_STARTING(__MAC_10_0, __IPHONE_2_0);
 从当前点到(x，y)添加一个立方体的曲线”,与
 控制点”(cp1x cp1y)”和“(cp2x cp2y)”。* /

 
}
*/


@end
