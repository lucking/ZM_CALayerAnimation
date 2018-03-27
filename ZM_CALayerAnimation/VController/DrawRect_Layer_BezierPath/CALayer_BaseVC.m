//
//  CALayer_BaseVC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/12.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "CALayer_BaseVC.h"
#import "BaseHeader.h"

static CGFloat ww=100, hh=100;
static CGFloat xx1= 10, xx2= 120, xx3= 260;
static CGFloat  yy1= 10,    yy2= 130,   yy3= 240,   yy4= 350,   yy5= 480,
yy6= 670,   yy7= 870,   yy8= 1080;

@interface CALayer_BaseVC ()
{
    
}
@property(nonatomic, strong) UIScrollView* sscrollview;
@end

@implementation CALayer_BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    [self addScrollView];
    [self case1];
}

- (void)case1 {
    //layer             创建CALayer
    //contents          设置CALayer的内容
    //contentsGravity   拉伸
    //contentsScale     寄宿图的像素尺寸和视图大小的比例
    UIImage *image = [UIImage imageNamed:@"s1.png"]; //Home.jpg、cc.png、1.png
    CALayer *layer1        = [CALayer layer];
    layer1.frame           = CGRectMake(10, yy1, ww, hh);
    layer1.backgroundColor = BgColor.CGColor;
    layer1.contents        = (__bridge id)image.CGImage;
    layer1.contentsGravity = kCAGravityResize;
    layer1.contentsScale   = image.scale;
    layer1.contentsScale   = [UIScreen mainScreen].scale;
    layer1.contentsRect    = CGRectMake(0, 0, 1.0, 1.0);
    layer1.borderWidth= 1.0f,
    layer1.borderColor= Blue_2599FA.CGColor;
    [_sscrollview.layer addSublayer:layer1];
    //椭圆
    CALayer *layer12= [CALayer layer];  [_sscrollview.layer addSublayer:layer12];
    [self setLayer:layer12 frame:CGRectMake(xx2, yy1, ww*2, ww) image:image contentsRect:CGRectMake(0, 0, 1.0, 1.0)];
    
    
    // 5.contentsRect
    // 注意CALayer的 contentsRect属性的单位是比例（而不是绝对坐标）。
    CALayer *layer21 = [CALayer layer]; [_sscrollview.layer addSublayer:layer21];
    CALayer *layer22 = [CALayer layer]; [_sscrollview.layer addSublayer:layer22];
    CALayer *layer23 = [CALayer layer]; [_sscrollview.layer addSublayer:layer23];
    CALayer *layer24 = [CALayer layer]; [_sscrollview.layer addSublayer:layer24];
    //左右分割 （椭圆）
    [self setLayer:layer21 frame:CGRectMake(xx1, yy2, ww, hh) image:image contentsRect:CGRectMake(0,   0,   0.5, 1.0)];
    [self setLayer:layer22 frame:CGRectMake(xx2, yy2, ww, hh) image:image contentsRect:CGRectMake(0.5, 0,   0.5, 1.0)];
    //上下分割 （椭圆）
    [self setLayer:layer23 frame:CGRectMake(xx3, yy2, ww, hh) image:image contentsRect:CGRectMake(0,   0,   1.0, 0.5)];
    [self setLayer:layer24 frame:CGRectMake(xx3, yy3, ww, hh) image:image contentsRect:CGRectMake(0,   0.5, 1.0, 0.5)];
    
    // 分割整区的4个角 （拼起来是个整图）
    CGRect rect1= CGRectMake(0,   0,    0.5, 0.5);
    CGRect rect2= CGRectMake(0.5, 0,    0.5, 0.5);
    CGRect rect3= CGRectMake(0,   0.5,  0.5, 0.5);
    CGRect rect4= CGRectMake(0.5, 0.5,  0.5, 0.5);
    CALayer *layer2Left = [CALayer layer];  [_sscrollview.layer addSublayer:layer2Left];
    CALayer *layer2Right= [CALayer layer];  [_sscrollview.layer addSublayer:layer2Right];
    CALayer *layer2BL   = [CALayer layer];  [_sscrollview.layer addSublayer:layer2BL];
    CALayer *layer2BR   = [CALayer layer];  [_sscrollview.layer addSublayer:layer2BR];
    [self setLayer:layer2Left  frame:CGRectMake(xx1, yy3, ww, hh) image:image contentsRect: rect1];
    [self setLayer:layer2Right frame:CGRectMake(xx2, yy3, ww, hh) image:image contentsRect: rect2];
    [self setLayer:layer2BL    frame:CGRectMake(xx1, yy4, ww, hh) image:image contentsRect: rect3];
    [self setLayer:layer2BR    frame:CGRectMake(xx2, yy4, ww, hh) image:image contentsRect: rect4];
    
    
    
    //6.contentsCenter
    CGFloat xx11= 8, xx22= 102, xx33= 190, xx44= 280;
    //创建CGImageRef（test.png是工程Bundle中的资源图片文件）
    CGImageRef img = [UIImage imageNamed:@"test.png"].CGImage;
    CALayer *layer = [CALayer layer];
    layer.contents = (__bridge id)img;
    layer.frame = CGRectMake(xx11, yy5, CGImageGetWidth(img), CGImageGetHeight(img));
    [_sscrollview.layer addSublayer:layer];
    
    
    NSLog(@"-->CGImageWidth = %zu ", CGImageGetWidth(img));
    NSLog(@"-->CGImageHeight= %zu ", CGImageGetHeight(img));
    CGFloat ww2= CGImageGetWidth(img),
    hh2= CGImageGetHeight(img);
    CGRect cRect= CGRectMake(0.5, 0, 0.5, 0.5);     //选择 右上角的四分之一 为内容
    CGRect rect10= CGRectMake(0, 0, 1, 1);          //默认
    CGRect rect11= CGRectMake(0,   0.5, 0.5, 0.5);  //左下角的四分之一拉伸
    CGRect rect22= CGRectMake(0.5, 0,   0.5, 0.5);  //左上角
    CGRect rect33= CGRectMake(0,   0,   0.5, 0.5);  //右上角
    CGRect rect44= CGRectMake(0.5, 0.5, 0.5, 0.5);  //右下角
    
    // 选择右上角的四分之一为内容，对内容的左下角的四分之一拉伸
    CALayer *layer30= [CALayer layer];  [_sscrollview.layer addSublayer:layer30];
    [self setLayer:layer30 frame:CGRectMake(xx33, yy5, ww2, hh2) contentsRect:cRect contentsCenter:rect10];
    
    CALayer *layer31= [CALayer layer];  [_sscrollview.layer addSublayer:layer31];
    CALayer *layer32= [CALayer layer];  [_sscrollview.layer addSublayer:layer32];
    CALayer *layer33= [CALayer layer];  [_sscrollview.layer addSublayer:layer33];
    CALayer *layer34= [CALayer layer];  [_sscrollview.layer addSublayer:layer34];
    [self setLayer:layer31 frame:CGRectMake(xx11, yy6, ww2, hh2) contentsRect:cRect contentsCenter:rect11];
    [self setLayer:layer32 frame:CGRectMake(xx33, yy6, ww2, hh2) contentsRect:cRect contentsCenter:rect22];
    [self setLayer:layer33 frame:CGRectMake(xx11, yy7, ww2, hh2) contentsRect:cRect contentsCenter:rect33];
    [self setLayer:layer34 frame:CGRectMake(xx33, yy7, ww2, hh2) contentsRect:cRect contentsCenter:rect44];
    
    //不用原图尺寸，图片拉伸 效果不明显
    CGFloat ww3= 80, hh3= 80;
    CALayer *layer35= [CALayer layer];  [_sscrollview.layer addSublayer:layer35];
    CALayer *layer36= [CALayer layer];  [_sscrollview.layer addSublayer:layer36];
    CALayer *layer37= [CALayer layer];  [_sscrollview.layer addSublayer:layer37];
    CALayer *layer38= [CALayer layer];  [_sscrollview.layer addSublayer:layer38];
    [self setLayer:layer35 frame:CGRectMake(xx11, yy8, ww3, hh3) contentsRect:cRect contentsCenter:rect11];
    [self setLayer:layer36 frame:CGRectMake(xx22, yy8, ww3, hh3) contentsRect:cRect contentsCenter:rect22];
    [self setLayer:layer37 frame:CGRectMake(xx33, yy8, ww3, hh3) contentsRect:cRect contentsCenter:rect33];
    [self setLayer:layer38 frame:CGRectMake(xx44, yy8, ww3, hh3) contentsRect:cRect contentsCenter:rect44];
}

- (void)setLayer:(CALayer *)layer
           frame:(CGRect)frame
    contentsRect:(CGRect)contentsRect
  contentsCenter:(CGRect)contentsCenter {
    
    CGImageRef img = [UIImage imageNamed:@"test.png"].CGImage;
    layer.contents = (__bridge id)img;
    layer.frame           = frame;
    layer.backgroundColor = BgColor.CGColor;
    layer.contentsRect    = contentsRect;
    layer.contentsCenter  = contentsCenter;
    //    layer.borderWidth= 0.5f,
    //    layer.borderColor= Color_FF9800.CGColor;
}


- (void)setLayer:(CALayer *)layer
           frame:(CGRect)frame
           image:(UIImage *)image
    contentsRect:(CGRect)contentsRect {
    
    layer.frame           = frame;
    layer.backgroundColor = BgColor.CGColor;
    layer.contents        = (__bridge id)image.CGImage;
    layer.contentsGravity = kCAGravityResize;
    layer.contentsScale   = image.scale;
    layer.contentsScale   = [UIScreen mainScreen].scale;
    layer.contentsRect    = contentsRect;
}


- (void)addScrollView{
    self.sscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0,70,SSWIDTH,SSHEIGHT)];
    self.sscrollview.contentSize = CGSizeMake(SSWIDTH,SSHEIGHT*3);
    self.sscrollview.showsVerticalScrollIndicator = YES;
    self.sscrollview.showsHorizontalScrollIndicator= NO;
    self.sscrollview.layer.borderColor = Color_8BC34A.CGColor;
    self.sscrollview.layer.borderWidth = 1;
    [self.view addSubview:self.sscrollview];
}
@end
