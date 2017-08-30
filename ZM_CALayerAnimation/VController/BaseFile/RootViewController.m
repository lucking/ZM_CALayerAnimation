//
//  RootViewController.m
//  ZM_ImageCaches
//
//  Created by ZM on 16/4/17.
//  Copyright © 2016年 ZM. All rights reserved.
//

#import "RootViewController.h"
#import "Common.h"
#import "BaseHeader.h"
#import "FirstVController.h"
#import "SecondVController.h"
#import "Test_VC.h"

#import "DrawRect_VC.h"
#import "CALayer_VC.h"
#import "CAShapeLayer_VC.h"
#import "UIBezierPath_VC.h"
#import "CABasicAnimation_VC.h"
#import "CATransition_VC.h"
#import "CAAnimation_VC.h"
//#import "CherryViewController.h"
#import "CALayerAnimation_LibVC.h"
#import "CATransform3D_VC.h"
#import "CATransform3D_VC2.h"
#import "Form_VC.h"
#import "WaterWave_VC.h"
#import "PopupMenuVC.h"

@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
	UITableView* ttableView;
}
@property (nonatomic, retain) NSArray* titleArray;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.view.backgroundColor = BgColor;
	self.title = @"Home";
    
    //系统返回按钮隐藏文字、自定义文字
//    // 方法一
//    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsLandscapePhone];
//    
//    // 方法二 － 注意此法需要在前一界面内设置
//    self.navigationItem.backBarButtonItem =
//    [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain
//                                    target:self
//                                    action:nil];
    
    // 方法三  //系统返回按钮隐藏文字、自定义文字
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:0.01],
                                 NSForegroundColorAttributeName:[UIColor clearColor]};
    [item setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSArray* titleArray = @[@" FirstVC",
                            @" SecondVC",
                            @" Test_VC",

                            @" DrawRect_VC",
                            @" CALayer_VC",
                            @" CAShapeLayer_VC",
                            @" UIBezierPath_VC",
                            @" CABasicAnimation_VC",
                            @" CATransition_VC",
                            @" CAAnimation_VC",
                            @" CATransform3D_VC",
                            @" CATransform3D_VC2",
                            @" CALayerAnimation_LibVC",
                            @" Form_VC",
                            @" WaterWave_VC",
                            @" PopupMenu_VC",
                            @" VC",
                            @" VC"
                            ];
	self.titleArray = titleArray;

	self.automaticallyAdjustsScrollViewInsets = NO;
	float yy = 70;
	ttableView= [[UITableView alloc]initWithFrame:CGRectMake(0, yy,SSWIDTH, SSHEIGHT-yy)];
	ttableView.backgroundColor = White_COLOR;
	ttableView.delegate = self;
	ttableView.dataSource= self;
	[self.view addSubview:ttableView];
	[Common clearTableViewLine:ttableView];

}
#pragma mark UITableView
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 刚选中又马上取消选中，格子不变色
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *pushVC;
    if (indexPath.row == 0) {       pushVC = [[FirstVController alloc]init];
    }else if (indexPath.row == 1 ){ pushVC = [[PopupMenuVC alloc]init];//[[SecondVController alloc]init];
    }else if (indexPath.row == 2 ){  pushVC = [[Test_VC alloc]init];
    }else if (indexPath.row == 3 ){  pushVC = [[DrawRect_VC alloc]init];
        
    }else if (indexPath.row == 4 ){  pushVC = [[CALayer_VC alloc]init];
    }else if (indexPath.row == 5 ){  pushVC = [[CAShapeLayer_VC alloc]init];
    }else if (indexPath.row == 6 ){  pushVC = [[UIBezierPath_VC alloc]init];
    }else if (indexPath.row == 7 ){  pushVC = [[CABasicAnimation_VC alloc]init];
    }else if (indexPath.row == 8 ){  pushVC = [[CATransition_VC alloc]init];
    }else if (indexPath.row == 9 ){  pushVC = [[CAAnimation_VC alloc]init];
    }else if (indexPath.row == 10 ){  pushVC = [[CATransform3D_VC alloc]init];
    }else if (indexPath.row == 11 ){  pushVC = [[CATransform3D_VC2 alloc]init];
    }else if (indexPath.row == 12 ){  pushVC = [[CALayerAnimation_LibVC alloc]init];
    }else if (indexPath.row == 13 ){  pushVC = [[Form_VC alloc]init];
    }else if (indexPath.row == 14 ){  pushVC = [[WaterWave_VC alloc]init];
    }else if (indexPath.row == 15 ){  pushVC = [[PopupMenuVC alloc]init];
    }
    pushVC.title = self.titleArray[indexPath.row];
    pushVC.tabBarController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pushVC animated:YES];

}

#pragma mark ------"  UITableViewDataSource、UITableViewDelegate  "------
// rowHeight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	return 40;
}
// row
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _titleArray.count;
}
// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *cellId = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	if (cell == nil){
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
		[cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
	for (UIView *subviews in [cell.contentView subviews]) {
		[subviews removeFromSuperview];
	}
//    cell.textLabel.textColor = Color_70AEE1;
//    cell.textLabel.text = _titleArray[indexPath.row];
//Color_With_Hex(0x63B8FF); // 5CACEE  63B8FF  Color_009988
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 220, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = FFBoldFont(16);
    label.text = _titleArray[indexPath.row];
    label.textColor = Color_009988;
    label.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:label];
    
    if (indexPath.row==0 || indexPath.row==1 ) {    label.textColor = Color_CDDC39; }
    if (indexPath.row== (_titleArray.count-1)) {    label.textColor = Color_03A9F4; }
    if (indexPath.row== (_titleArray.count-2) || indexPath.row== (_titleArray.count-3)) {
        label.textColor = Color_FF5722; }
	
    return cell;
}


@end
