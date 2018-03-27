//
//  DrawRect1_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/28.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "DrawRect1_VC.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"


@interface DrawRect1_VC (){
    
    CGPoint startPoint;
}
@property (nonatomic, weak) UIView *faceView1;
@property (nonatomic, weak) UIView *faceView2;
@property (nonatomic, weak) UIView *faceView3;
@property (nonatomic, weak) UIView *myView1;
@property (nonatomic, weak) UIView *myView2;
@property (nonatomic, weak) UILabel *myLab1;
@property (nonatomic, weak) UIView *myView3;
@property (nonatomic, weak) UIView *myView4;
@end

@implementation DrawRect1_VC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"DrawRect1_VC";
    [self createUI];
    
}
static CGFloat faceWidth  = 150;  //
static CGFloat faceHeight = 140;  //

- (void)createUI {
    
    CGFloat top = 20;
    [self addViewToSuperView:self.view frame:CGRectMake(10, top+80, faceWidth, faceHeight) tag:111];
    [self addViewToSuperView:self.view frame:CGRectMake(10, top+250, faceWidth, faceHeight) tag:222];
    [self addViewToSuperView:self.view frame:CGRectMake(10, top+410, faceWidth, faceHeight) tag:333];
    
    CGFloat xx= faceWidth+ 50;
    [self addViewToSuperView:self.view frame:CGRectMake(xx, top+80, 100, 100) tag:11];
    [self addViewToSuperView:self.view frame:CGRectMake(xx, _myView1.bottom+20, 100, 60) tag:22];
    [self addLabSuperView:self.view frame:CGRectMake(xx, _myView2.bottom+20, 40, 100) text:@"待估损" tag:101];
    [self addViewToSuperView:self.view frame:CGRectMake(xx, _myLab1.bottom+20, 100, 60) tag:33];
    [self addViewToSuperView:self.view frame:CGRectMake(xx, _myView3.bottom+20, 100, 60) tag:44];
    
    
    [self Quartz_CGPath];       //1.使用Quartz的CGPath 画脸
    [self Quartz_CGContextRef]; //2.完全使用CGContextRef相关的函 画脸
    [self Quartz_UIBezierPath]; //3.使用Quartz的UIBezierPath 画脸
    
    
    //设置各个圆角：基础使用
    [self setCornersOfView1];
    //设置各个圆角：封装方法
    [self setCornersOfView:_myView2 byCorners:UIRectCornerTopRight|UIRectCornerBottomRight
               cornerRadii:CGSizeMake(20,20)
                 fillColor:Green_9BCD9B
                 lineWidth:2
                 lineColor:Red_EEAEEE];
    _myLab1.font = [UIFont systemFontOfSize:17];
    
    
    
    //设置各个圆角：封装方法
    [self setCornersOfView:_myLab1 byCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft
               cornerRadii:CGSizeMake(10,10) fillColor:Purple_CD69C9 lineWidth:10 lineColor:Clear_COLOR];
    // 设置段落样式
    [self seteLineSpace:0 paragraphSpace:0 characterSpace:[NSNumber numberWithFloat:5] alignment:NSTextAlignmentCenter headIndent:5 withUILabel:_myLab1];
    //2.阴影图层
    //    _myLab1.layer.shadowOffset = CGSizeMake(-6, 6);
    //    _myLab1.layer.shadowColor  = [UIColor greenColor].CGColor;
    //    _myLab1.layer.shadowOpacity= 0.3;
    //    _myLab1.layer.shadowRadius = 2;
    //设置阴影：封装方法 (同上)
    [self setshadowOfView:_myLab1 shadowOffset:CGSizeMake(-6, 6) shadowColor:[UIColor greenColor]
            shadowOpacity:0.3 shadowRadius:2];
    
        
    //设置各个圆角：封装方法
    [self setCornersOfView:_myView3 byCorners:UIRectCornerTopLeft|UIRectCornerTopRight
               cornerRadii:CGSizeMake(20,20) fillColor:Green_9BCD9B lineWidth:2 lineColor:Red_EEAEEE];
    
    [self setCornersOfView:_myView4 byCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight
               cornerRadii:CGSizeMake(20,20) 
                 fillColor:Green_9BCD9B 
                 lineWidth:2 
                 lineColor:Red_EEAEEE];
    
}

/**
 阴影设置：shadow
 
 @param myView  主视图
 @param shadowOffset  阴影偏移
 @param shadowColor   阴影颜色
 @param shadowOpacity 阴影透明度
 @param shadowRadius  阴影角弧度
 */
- (void)setshadowOfView:(UIView *)myView
           shadowOffset:(CGSize)shadowOffset
            shadowColor:(UIColor *)shadowColor
          shadowOpacity:(float)shadowOpacity
           shadowRadius:(CGFloat)shadowRadius
{
    myView.layer.shadowOffset = shadowOffset;
    myView.layer.shadowColor  = shadowColor.CGColor;
    myView.layer.shadowOpacity= shadowOpacity;
    myView.layer.shadowRadius = shadowRadius;
}



/**
 设置段落样式
 
 @param lineSpace      行间距
 @param paragraphSpace 段间距
 @param characterSpace 字间距
 @param alignment 文本排版位置
 @param headIndent 所有：行首缩进
 */
- (void)seteLineSpace:(CGFloat)lineSpace
       paragraphSpace:(CGFloat)paragraphSpace
       characterSpace:(NSNumber*)characterSpace
            alignment:(NSTextAlignment)alignment
           headIndent:(CGFloat)headIndent withUILabel:(UILabel *)myLab {
    
    NSMutableAttributedString *mutAttStr = [[NSMutableAttributedString alloc] initWithString:myLab.text];
    //设置段落样式
    NSMutableParagraphStyle* paraStyle= [[NSMutableParagraphStyle alloc] init];
    paraStyle.alignment         = alignment;        // 文本排版位置
    paraStyle.lineSpacing       = lineSpace;        // 行间距
    paraStyle.paragraphSpacing  = paragraphSpace;   // 段间距
    paraStyle.headIndent        = headIndent;       // 所有：行首缩进
    paraStyle.firstLineHeadIndent =headIndent;      // 段行首缩进
    [mutAttStr addAttribute:NSParagraphStyleAttributeName value:paraStyle range:NSMakeRange(0, myLab.text.length)];
    //设置 字间距
    [mutAttStr addAttribute:NSKernAttributeName value:characterSpace range:NSMakeRange(0, myLab.text.length)];
    // 文本属性化
    [myLab setAttributedText:mutAttStr];
}


- (void)setCornersOfView1 {
    
    //每个角的半径.
    CGSize radii = CGSizeMake(20,10);
    //不同的角度
    UIRectCorner corners = UIRectCornerTopLeft | UIRectCornerBottomLeft;
    //用一个圆角矩形 初始化路径
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.myView1.bounds byRoundingCorners:corners cornerRadii:radii];
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor  = [UIColor blueColor].CGColor;
    shapeLayer.fillColor    = Green_96CDCD.CGColor;
    shapeLayer.lineWidth    = 2;
    shapeLayer.lineJoin     = kCALineJoinRound;
    shapeLayer.lineCap      = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [self.myView1.layer addSublayer:shapeLayer];
}

/**
 设置view的四个边角圆弧
 
 @param myView 要设置的View
 @param corners 不同的角度
 @param radii 每个角的半径.
 @param fillColor 内部颜色（注意：myView.backgroundColor= 设为透明色，用fillColor代替背景色）
 @param lineWidth 边线宽度
 @param lineColor 边线颜色
 */
- (void)setCornersOfView:(UIView *)myView
               byCorners:(UIRectCorner)corners
             cornerRadii:(CGSize)radii
               fillColor:(UIColor *)fillColor
               lineWidth:(CGFloat )lineWidth
               lineColor:(UIColor *)lineColor {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:myView.bounds
                                               byRoundingCorners:corners
                                                     cornerRadii:radii];
    CAShapeLayer *shapeLayer= [CAShapeLayer layer];
    shapeLayer.fillColor    = fillColor.CGColor;
    shapeLayer.strokeColor  = lineColor.CGColor;
    shapeLayer.lineWidth    = lineWidth;
    shapeLayer.lineJoin     = kCALineJoinRound;
    shapeLayer.lineCap      = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    [myView.layer addSublayer:shapeLayer];
}


/**
 *  1.使用Quartz的CGPath 画图
 */
- (void)Quartz_CGPath {
    
    UIGraphicsBeginImageContext(_faceView1.bounds.size);        //开始图像绘图
    CGContextRef cRef = UIGraphicsGetCurrentContext();    //获取当前 画板
    
    //创建用于转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    CGAffineTransform transform = CGAffineTransformMakeTranslation(20, 20);
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, &transform, CGRectMake(0, 0, 20, 20)); //左眼
    CGPathAddEllipseInRect(path, &transform, CGRectMake(80, 0, 20, 20));//右眼
    CGPathMoveToPoint(path, &transform, 100, 50);                       //笑
    CGPathAddArc(path, &transform, 50, 50, 50, 0, M_PI, NO);
    
    CGContextAddPath(cRef, path);       //将CGMutablePathRef添加到当前Context内
    [[UIColor blueColor] setStroke];    //设置绘图属性：颜色
    CGContextSetLineWidth(cRef, 2);     //设置绘图属性：边框
    CGContextStrokePath(cRef);          //执行绘画
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_faceView1 addSubview:imgView];
    
}
/**
 *  2.完全使用CGContextRef相关的函 画图
 */
- (void)Quartz_CGContextRef {
    
    UIGraphicsBeginImageContext(_faceView2.bounds.size);    //开始图像绘图
    CGContextRef cRef = UIGraphicsGetCurrentContext();      //获取当前 画板
    
    //使用CGContextTranslateCTM函数来转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    CGContextTranslateCTM( cRef, 20, 20);
    CGContextAddEllipseInRect( cRef, CGRectMake(0, 0, 20, 20));    //左眼
    CGContextAddEllipseInRect( cRef, CGRectMake(80, 0, 20, 20));   //右眼
    CGContextMoveToPoint( cRef, 100, 50);                          //笑
    CGContextAddArc( cRef, 50, 50, 50, 0, M_PI, NO);
    
    [[UIColor blueColor] setStroke];    //设置绘图属性：颜色
    CGContextSetLineWidth(cRef, 2);     //设置绘图属性：边框
    CGContextStrokePath(cRef);          //执行绘画
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_faceView2 addSubview:imgView];
}
/**
 *  3.使用Quartz的UIBezierPath 画图
 */
- (void)Quartz_UIBezierPath {
    
    UIGraphicsBeginImageContext(_faceView3.bounds.size);    //开始图像绘图
    //创建UIBezierPath
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 20, 20)]];  //左眼
    [path appendPath:[UIBezierPath bezierPathWithOvalInRect:CGRectMake(80, 0, 20, 20)]]; //右眼
    [path moveToPoint:CGPointMake(100, 50)];                                             //笑
    //注意这里clockwise参数是YES而不是NO，因为这里不知Quartz，不需要考虑Y轴翻转的问题
    [path addArcWithCenter:CGPointMake(50, 50) radius:50 startAngle:0 endAngle:M_PI clockwise:YES];
    //使用applyTransform函数来转移坐标的Transform，这样我们不用按照实际显示做坐标计算
    [path applyTransform:CGAffineTransformMakeTranslation(20, 20)];
    
    [[UIColor blueColor] setStroke];//设置绘图属性：颜色
    [path setLineWidth:2];          //设置绘图属性：边框
    [path stroke];                  //执行绘画
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    [_faceView3 addSubview:imgView];
}




- (void)addViewToSuperView:(UIView *)superView frame:(CGRect)frame tag:(NSInteger)tag
{
    UIView *myView = [[UIView alloc] initWithFrame:frame];
    myView.tag= tag;
    [superView addSubview:myView];
    if (tag==111){          myView.backgroundColor= Yellow_COLOR;   _faceView1 = myView;
    }else if (tag==222){    myView.backgroundColor= BgColor;        _faceView2 = myView;
    }else if (tag==333){    myView.backgroundColor= Color_CDDC39;   _faceView3 = myView;
    }else if (tag==11){     myView.backgroundColor= Red_EEAEEE;   _myView1 = myView;
    }else if (tag==22){     myView.backgroundColor= Clear_COLOR;   _myView2 = myView;
    }else if (tag==33){     myView.backgroundColor= Clear_COLOR;   _myView3 = myView;
    }else if (tag==44){     myView.backgroundColor= Clear_COLOR;   _myView4 = myView;

    }
}
- (void )addLabSuperView:(UIView *)superView frame:(CGRect)frame text:(NSString *)text tag:(NSInteger)tag
{
    UILabel *label = [[UILabel alloc] initWithFrame: frame];
    label.backgroundColor = Clear_COLOR;
    label.font = [UIFont systemFontOfSize:16];
    label.text = text;
    label.textColor = White_COLOR;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines= 0;
    [superView addSubview:label];
    if (tag==101){ _myLab1 = label;
    }
}


@end
