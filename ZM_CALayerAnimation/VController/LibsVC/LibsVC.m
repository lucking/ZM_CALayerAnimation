//
//  CALayerAnimation_LibVC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/7/12.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "LibsVC.h"
#import "Common.h"
#import "BaseHeader.h"
#import "XSChartVController.h"
#import "TextAnimationVC.h"
#import "ZMBrokenLineVC.h"
#import "WaterWave_VC.h"
#import "Form_VC.h"

@interface LibsVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView* ttableView;
}
@property (nonatomic, retain) NSArray* titleArray;
@end

@implementation LibsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BgColor;
    self.title = @"Home";
    
    NSArray* titleArray = @[@" XSChartVC",
                            @" TextAnimationVC",
                            @" ZMBrokenLineVC",
                            @" WaterWave_VC",
                            @" Form_VC",
                            @" HHViewC",];
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
    if (indexPath.row == 0) {       pushVC = [[XSChartVController alloc]init];
    }else if (indexPath.row == 1 ){ pushVC = [[TextAnimationVC alloc]init];
    }else if (indexPath.row == 2 ){ pushVC = [[ZMBrokenLineVC alloc]init];
    }else if (indexPath.row == 3 ){ pushVC = [[WaterWave_VC alloc]init];
    }else if (indexPath.row == 4 ){ pushVC = [[Form_VC alloc]init];
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
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 40)];
    label.backgroundColor = [UIColor clearColor];
    label.font = FFBoldFont(16);
    label.text = _titleArray[indexPath.row];
    label.textColor = Color_009988;
    label.textAlignment = NSTextAlignmentLeft;
    [cell.contentView addSubview:label];

    return cell;
}

@end
