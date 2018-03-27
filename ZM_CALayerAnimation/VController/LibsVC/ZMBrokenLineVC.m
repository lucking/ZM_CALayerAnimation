//
//  ZMBrokenLineVC.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2018/3/27.
//  Copyright © 2018年 ZM. All rights reserved.
//

#import "ZMBrokenLineVC.h"
#import "ZMBrokenLineView.h"
#import "BaseHeader.h"

@interface ZMBrokenLineVC ()<ZMBrokenLineViewDelegate,ZMBrokenLineViewDataSource>
@property(nonatomic,strong)NSArray *data;
@end

@implementation ZMBrokenLineVC

/**
 *  轻量级折线图
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _data=@[@1,@2,@3,@4,@9,@6,@12];
    ZMBrokenLineView *chart=[[ZMBrokenLineView alloc]initWithFrame:CGRectMake(0, 70, SSWIDTH, 250)];
    chart.dataSource=self;
    chart.delegate =self;
    chart.backgroundColor = [Gray_666666 colorWithAlphaComponent:0.2];
    [self.view addSubview:chart];
    
    chart.title  = @"ZMBrokenLineView Demo";
    chart.yTitle = @"count";
    chart.xTitle = @"Index";
    
}

-(NSInteger)numberForChart:(ZMBrokenLineView *)chart{
    return _data.count;
}
-(NSInteger)chart:(ZMBrokenLineView *)chart valueAtIndex:(NSInteger)index{
    return [_data[index] floatValue];
}
-(BOOL)showDataAtPointForChart:(ZMBrokenLineView *)chart{
    return YES;
}
-(NSString *)chart:(ZMBrokenLineView *)chart titleForXLabelAtIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld",(long)index];
}

-(NSString *)titleForXAtChart:(ZMBrokenLineView *)chart{
    return @"Index";
}
-(NSString *)titleForYAtChart:(ZMBrokenLineView *)chart{
    return @"count";
}
-(void)chart:(ZMBrokenLineView *)view didClickPointAtIndex:(NSInteger)index{
    NSLog(@"click at index:%ld",(long)index);
}


@end
