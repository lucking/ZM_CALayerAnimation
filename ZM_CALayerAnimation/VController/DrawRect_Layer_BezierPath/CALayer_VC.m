//
//  CALayer_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CALayer_VC.h"
#import "BaseHeader.h"
#import <CoreText/CoreText.h>
#import <QuartzCore/QuartzCore.h>
#import "UIView+ZMFrame.h"
#import "CALayer_BaseVC.h"
#import "CALayer_TypeVC.h"
#import "CALayer_CAEmitterLayer.h"

static CGFloat xx1= 10, xx2= 150, xx3= 260;
static CGFloat yy1= 20, yy2= 200, yy3= 240;


@interface CALayer_VC ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
{
    BOOL isflage;
}
@property(nonatomic, strong) UIScrollView* sscrollview;
@property(nonatomic, strong) UIImageView *imgView;
//@property(nonatomic, strong) CALayer *maskLayer;
@end

@implementation CALayer_VC

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];

    [self createUI];
    [self.view addSubview:self.sscrollview];

    [self case1];
}

/*  borderWidth：  边框
    borderColor：  边色
    cornerRadius： 边角
    masksToBounds：裁剪
    opacity：    设置 透明度
    position：   设置 位置
    zPosition：  设置 显示的优先级
    shadow          阴影
    shadowColor     阴影颜色
    shadowOffset    阴影偏移
    shadowOpacity   阴影透明度
    shadowRadius    阴影角弧度
    mask：蒙版
 总结：CALayer 蒙版图层真正厉害的地方在于蒙版图层不局限于静态图。
 任何有图层构成的都可以作为mask属性，这意味着你的蒙版可以通过代码甚至是动画实时生成！
*/
- (void)case1 {
   
    CALayer *my_layer=[CALayer layer];
    my_layer.frame=CGRectMake(xx1, yy1, 80, 80);
    my_layer.backgroundColor= Red_COLOR.CGColor;
    my_layer.borderWidth    = 2;
    my_layer.borderColor    = Cyan_COLOR.CGColor;
    my_layer.cornerRadius   = 40;
    my_layer.masksToBounds  = YES;
    my_layer.opacity        = 0.2;
    my_layer.position       = CGPointMake(80, 80);
    [_sscrollview.layer addSublayer:my_layer];

    //zPosition：显示的优先级
    CALayer *layer1 = [CALayer layer];
    layer1.frame    = CGRectMake(xx2, yy1, 100, 150);
    layer1.backgroundColor = Red_COLOR.CGColor;
    layer1.zPosition       = 1;
    [_sscrollview.layer addSublayer:layer1];

    //shadow：阴影
    CALayer *layer2 = [CALayer layer];
    layer2.frame    = CGRectMake(xx2+20, yy1-10, 100, 150);
    layer2.backgroundColor  = GreenColor.CGColor;
    layer2.shadowColor      = Black_COLOR.CGColor;
    layer2.shadowOffset     = CGSizeMake(30,20);
    layer2.shadowOpacity    = 0.8;
    layer2.shadowRadius     = 2;
    [_sscrollview.layer addSublayer:layer2];
    NSLog(@"-->layer1.zPosition= %f",layer1.zPosition); //1
    NSLog(@"-->layer2.zPosition= %f",layer2.zPosition); //0
    
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(xx1, yy2, 200, 200)];
    _imgView.backgroundColor = BgColor;
    [_sscrollview addSubview:_imgView];
    
    //create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:_imgView.bounds];
    // Mask: circlePath
    [path appendPath:[UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:30 startAngle:0 endAngle:2*M_PI clockwise:NO]];
    // Mask: roundRectanglePath
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(20, 40, 20, 60) cornerRadius:15] bezierPathByReversingPath]];
    // setMask
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.backgroundColor= Cyan_COLOR.CGColor;
    shapeLayer.path = path.CGPath;
    [_imgView.layer setMask:shapeLayer];
    
    //mask：蒙版
    UIImage *maskImage = [UIImage imageNamed:@"mask"];
    CALayer *mask = [CALayer layer];
    mask.frame = CGRectMake(10, 10, 100, 100);   //给maskLayer 设定frame
    mask.contents = (__bridge id)maskImage.CGImage;
    mask.backgroundColor = Yellow_COLOR.CGColor;
//    self.imgView.layer.mask = mask;
//    [_imgView.layer setMask:mask];
    [_imgView.layer addSublayer:mask];
    
}



- (UIScrollView *)sscrollview {
    if (_sscrollview==nil) {
        CGFloat yy= 180;
        _sscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,yy,SSWIDTH,SSHEIGHT-yy)];
        _sscrollview.contentSize = CGSizeMake(SSWIDTH,SSHEIGHT*1);
        _sscrollview.showsVerticalScrollIndicator = YES;
        _sscrollview.showsHorizontalScrollIndicator= NO;
        _sscrollview.delegate= self;
        _sscrollview.layer.borderColor = Color_8BC34A.CGColor;
        _sscrollview.layer.borderWidth = 1;
      
        UITapGestureRecognizer * gesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick)];
        gesture.numberOfTapsRequired = 1;
        [_sscrollview addGestureRecognizer:gesture];
    }
    return _sscrollview;
}

- (void)createUI {
    
    CGFloat width = 130;
    CGFloat yy = 70;
    [self addBtnTitle:@"CALayer_BaseVC" frame:CGRectMake(10, yy, width, 35) Tag:111];
    [self addBtnTitle:@"CALayer_TypeVC" frame:CGRectMake(10*2+width, yy, width, 35) Tag:222];
    [self addBtnTitle:@"CAEmitterLayer" frame:CGRectMake(10, yy+45, width, 35) Tag:333];
}
- (void)myBtnClick:(UIButton *)Btn{
    UIViewController *pushVC;
    if (Btn.tag==111) {         pushVC = [[CALayer_BaseVC alloc]init];
    }else if (Btn.tag==222) {   pushVC = [[CALayer_TypeVC alloc]init];
    }else if (Btn.tag==333) {   pushVC = [[CALayer_CAEmitterLayer alloc]init];
    }else if (Btn.tag==444) {
        
    }
    [self.navigationController pushViewController:pushVC animated:YES];
}

//手势绑定的事件
-(void)tapGestureClick{
    isflage=!isflage;
   [self.navigationController setNavigationBarHidden:isflage animated:YES];
}
#pragma mark - onClick
//触摸时：隐藏导航条
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.navigationController setNavigationBarHidden:isflage animated:YES];
    isflage=!isflage;
}


@end
