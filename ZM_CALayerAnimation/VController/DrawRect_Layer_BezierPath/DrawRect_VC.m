//
//  DrawRect_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "DrawRect_VC.h"
#import "BaseHeader.h"
#import "GraphicsView.h"
#import "RectView.h"
#import "CircleView.h"
#import "UIView+ZMFrame.h"
#import "DrawRect1_VC.h"
#import "DrawRect2_VC.h"


@interface DrawRect_VC ()
{
    // 画图
    GraphicsView* ghview;
}
@property (nonatomic, strong) UIScrollView* sscrollview;
@property (nonatomic, strong) RectView *rectView;
@property (nonatomic, strong) CircleView *circleView;
@end

@implementation DrawRect_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Animation_Graphics";
    
    //创建UI
    [self createUI];
    

//    // 画不规则矩形
//    [self setRectView];
//    // 画圆
//    [self setCircleView];
    
}


- (void)myBtnClick:(UIButton *)Btn{
    UIViewController *pushVC;
    if (Btn.tag==111) {         pushVC = [[DrawRect1_VC alloc]init];
    }else if (Btn.tag==222) {   pushVC = [[DrawRect2_VC alloc]init];
    }else if (Btn.tag==333) {
    }
    [self.navigationController pushViewController:pushVC animated:YES];
}

//创建UI
-(void)createUI
{

    CGFloat width = 150;
    CGFloat yy = 70;
    [self addBtnTitle:@"DrawRect1_VC" frame:CGRectMake(10, yy, width, 35) Tag:111];
    [self addBtnTitle:@"DrawRect2_VC" frame:CGRectMake(10*2+width, yy, width, 35) Tag:222];
    [self addBtnTitle:@"333" frame:CGRectMake(10, yy+45, width, 35) Tag:333];
    
    
    [self.view addSubview:self.sscrollview];
    //画图
    ghview = [[GraphicsView alloc] init];
    ghview.frame = CGRectMake(5, 0, SSWIDTH-10, _sscrollview.contentSize.height);
    ghview.backgroundColor = BgColor;
    ghview.num = @"22";
    ghview.numFont = 16;
    [self.sscrollview addSubview:ghview];
    
}

// 画圆+label
- (void)setCircleView {
    
    _circleView = [[CircleView alloc] initWithFrame:CGRectMake(10, 100, 100+30,100)];
    _circleView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_circleView];
    _circleView.textLab.text = @"10:30:21";
}

// 画不规则矩形
- (void)setRectView {
    
    _rectView = [[RectView alloc]init];
    _rectView.backgroundColor = Clear_COLOR;
    _rectView.frame = CGRectMake(10, 70, SSWIDTH-20,SSHEIGHT/2);
    _rectView.fillColor = [UIColor purpleColor];
    _rectView.lineWidth = 2;
    _rectView.strokeColor = [UIColor cyanColor];
    [self.view addSubview:_rectView];
}

- (UIScrollView *)sscrollview {
    if (_sscrollview==nil) {
        CGFloat yy= 160;
        _sscrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(1,yy,SSWIDTH-2,SSHEIGHT-yy-2)];
        _sscrollview.contentSize = CGSizeMake(SSWIDTH-2,SSHEIGHT*3.5);
        _sscrollview.showsVerticalScrollIndicator = YES;
        _sscrollview.showsHorizontalScrollIndicator= NO;
        _sscrollview.layer.borderColor = Color_8BC34A.CGColor;
        _sscrollview.layer.borderWidth = 1;
    }
    return _sscrollview;
}

// 按钮：我的消息
-(void)MyMessageBtnClick:(UIButton *)Btn {
    NSLog(@"isSelected   = %d",[Btn isSelected]);
    NSLog(@"Btn.selected = %d \n ",Btn.selected);
    
    if (Btn.selected == NO) {
        ghview.hidden= YES;	Btn.selected = YES;
    }else{
        ghview.hidden= NO;	Btn.selected = NO;
    }
}



@end
