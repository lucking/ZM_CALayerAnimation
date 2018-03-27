//
//  DrawRect2_VC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/13.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "DrawRect2_VC.h"
#import "BaseHeader.h"
#import "DrawRectView2.h"

@interface DrawRect2_VC ()
{
    
}
@property (nonatomic, strong) DrawRectView2 *rectView2;
@end

@implementation DrawRect2_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"DrawRect2_VC";

    [self createUI];
}

//创建UI
-(void)createUI
{
    //画图
    _rectView2 = [[DrawRectView2 alloc] initWithFrame:CGRectMake(10, 80, SSWIDTH-20,500)];
    _rectView2.backgroundColor = BgColor;
    [self.view addSubview:_rectView2];
    
}


@end
