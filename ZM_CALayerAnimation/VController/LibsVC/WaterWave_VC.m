//
//  WaterWave_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "WaterWave_VC.h"
#import "BaseHeader.h"
#import "UIView+ZMFrame.h"
#import "WaveWaterView.h"
#import "UIView+BorderPath.h"

@interface WaterWave_VC ()
@property (nonatomic,strong) UISlider * slider;//滑块
@property (nonatomic,strong) UISwitch* sswitch;//开关器
@property (nonatomic,strong) UISegmentedControl *segmented;//选择器
@property (nonatomic,strong) WaveWaterView *waterView;;

@end


@implementation WaterWave_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.


    _waterView = [[WaveWaterView alloc] initWithFrame:CGRectMake((SSWIDTH - 200)/2, 70, 200,200)];
    _waterView.progress = 0.1;
    _waterView.layer.borderWidth = 1.f;
    _waterView.layer.borderColor = Purple_CD69C9.CGColor;
    [self.view addSubview:_waterView];
    
    
    [self setUISegment];
    [self setSlider];
    [self.view addSubview:self.sswitch];

    
}

//监听方法
- (void)sementedControlClick:(UISegmentedControl*)sender {
    NSLog(@"-->%ld",sender.selectedSegmentIndex);
    
    CGRect rect = _waterView.frame;
    
    switch (sender.selectedSegmentIndex) {
        case 0:{
            //矩形
            _waterView.borderPath = nil;
            rect.size.height = rect.size.width;
        }break;
        case 1:{
            CGRect frame = _waterView.bounds;
            frame.size.height = frame.size.width * 9 /10;
            _waterView.changeFrame = frame;
            //心形❤️❤
            _waterView.borderPath = [UIView heartPathRect:rect lineWidth:0];
            _waterView.border_fillColor = [UIColor groupTableViewBackgroundColor];
            
        }break;
        case 2:{
            _waterView.changeFrame = _waterView.bounds;
            //圆形
            _waterView.borderPath = [UIView circlePathRect:rect lineWidth:0];
            _waterView.border_fillColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        case 3:
        {
            //五角星距离中心距离
            CGFloat redius_star = rect.size.width/2;
            CGFloat star_w = redius_star * sin(2*M_PI/5)*2;
            CGFloat star_h = redius_star * (sin(3*M_PI/10) + 1);
            
            //图形所在区域frame
            CGRect changeFrame = CGRectMake((rect.size.width -star_w)/2, 0, star_w, star_h);
            rect.size.height = star_h;
            
            _waterView.changeFrame = changeFrame;
            _waterView.borderPath = [UIView startPathRect:rect lineWidth:0];
            _waterView.border_fillColor = [UIColor groupTableViewBackgroundColor];
        }
            break;
        default:
            break;
    }

    
}
-(void)switchAction:(UISwitch *)switchBtn
{
    if ([switchBtn isOn]) { NSLog(@"开");
    }else {                 NSLog(@"关");}
    _waterView.progress_animation = switchBtn.on;

}
#pragma mark-滑块值发生改变
-(void)sliderValuechange:(UISlider *)sender{
    
    NSLog(@"---> sender.value= %f",sender.value);
    [_waterView setProgress:sender.value];

}
#pragma mark-点击滑块
-(void)sliderTap:(UITapGestureRecognizer *)tap{
    
    UISlider * slider = (UISlider *)tap.view;
    CGPoint point = [tap locationInView:_slider];
    [_slider setValue:point.x/_slider.bounds.size.width*1 animated:YES];
    
    NSLog(@"---> sliderTap.value= %f",slider.value);
    [_waterView setProgress:slider.value];

}



- (void)setUISegment {
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"矩形",@"心形",@"圆形",@"五角星",nil];
    self.segmented = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    self.segmented.frame = CGRectMake(20, _waterView.bottom+ 80, 300, 40);
    self.segmented.selectedSegmentIndex = 0;//设置默认选择项索引
    self.segmented.tintColor = BgColor;
    [self.view addSubview:self.segmented];

    NSDictionary* normalDic= @{NSFontAttributeName:FFont(14),
                               NSForegroundColorAttributeName:Black_COLOR};
    NSDictionary* selectDic= @{NSFontAttributeName:FFont(16),
                               NSForegroundColorAttributeName:Purple_CD69C9};
    //设置普通状态下(未选中)状态下的文字颜色和字体
    [self.segmented setTitleTextAttributes:normalDic forState:UIControlStateNormal];
    //设置选中状态下的文字颜色和字体
    [self.segmented setTitleTextAttributes:selectDic forState:UIControlStateSelected];
    //添加监听
    [self.segmented addTarget:self action:@selector(sementedControlClick:) forControlEvents:UIControlEventValueChanged];

}


- (void)setSlider {
    
    _slider = [[UISlider alloc] initWithFrame:CGRectMake(100, _segmented.bottom+30, 200, 5) ];
    _slider.userInteractionEnabled = YES;
    _slider.continuous = YES;//设置为NO,只有在手指离开的时候调用valueChange
    [_slider addTarget:self action:@selector(sliderValuechange:) forControlEvents:UIControlEventValueChanged];
    UITapGestureRecognizer * sliderTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(sliderTap:)];
    [_slider addGestureRecognizer:sliderTap];
    [self.view addSubview:_slider];
    
}
- (UISwitch *)sswitch {
    if (_sswitch==nil) {
        //实例化一个开关控件
        _sswitch=[[UISwitch alloc] init];
        _sswitch.frame=CGRectMake(30, _slider.bottom+100, 0, 0);
        _sswitch.transform = CGAffineTransformMakeScale(1.5, 1.2); //(宽、高)
        [_sswitch setOn:YES animated:NO];
        [_sswitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        _sswitch.tag= 222;
    }
    return _sswitch;
}

@end
