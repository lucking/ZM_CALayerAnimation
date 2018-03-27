//
//  Form_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/17.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "Form_VC.h"
#import "BaseHeader.h"
#import "FormView.h"
#import "UIView+BorderPath.h"

@interface Form_VC ()
@property (nonatomic, strong) FormView *formView;
@end

@implementation Form_VC

- (void)viewDidLoad {
    [super viewDidLoad];

    _formView = [[FormView alloc] initWithFrame:CGRectMake((SSWIDTH - 200)/2, 80, 200,200)];
    _formView.backgroundColor = Clear_COLOR;
    [self.view addSubview:_formView];
    
    
    CGRect rect = _formView.frame;
    //五角星距离中心距离
    CGFloat redius_star = rect.size.width/2;
    CGFloat star_w = redius_star * sin(2*M_PI/5)*2;
    CGFloat star_h = redius_star * (sin(3*M_PI/10) + 1);
    
    //图形所在区域frame
    CGRect changeFrame = CGRectMake((rect.size.width -star_w)/2, 0, star_w, star_h);
    rect.size.height = star_h;
    
    _formView.changeFrame = changeFrame;
    _formView.borderPath = [UIView startPathRect:rect lineWidth:0];
    _formView.border_fillColor = [UIColor orangeColor];

}



@end
