//
//  XSChartVController.m
//  Chart_ZM
//
//  Created by ZM on 2017/7/6.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "XSChartVController.h"
#import "XSChart.h"
#import "BaseHeader.h"

@interface XSChartVController ()<XSChartDataSource,XSChartDelegate>
@property(nonatomic,strong)NSArray *data;
@end

@implementation XSChartVController


/**
 *  轻量级折线图
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _data=@[@1,@2,@3,@4,@9,@6,@12];
    XSChart *chart=[[XSChart alloc]initWithFrame:CGRectMake(0, 70, SSWIDTH, 250)];
    chart.dataSource=self;
    chart.delegate =self;
    chart.backgroundColor = Gray_666666;
    [self.view addSubview:chart];
    
}
-(NSInteger)numberForChart:(XSChart *)chart{
    return _data.count;
}
-(NSInteger)chart:(XSChart *)chart valueAtIndex:(NSInteger)index{
    return [_data[index] floatValue];
}
-(BOOL)showDataAtPointForChart:(XSChart *)chart{
    return YES;
}
-(NSString *)chart:(XSChart *)chart titleForXLabelAtIndex:(NSInteger)index{
    return [NSString stringWithFormat:@"%ld",(long)index];
}
-(NSString *)titleForChart:(XSChart *)chart{
    return @"XSChart Demo";
}
-(NSString *)titleForXAtChart:(XSChart *)chart{
    return @"Index";
}
-(NSString *)titleForYAtChart:(XSChart *)chart{
    return @"count";
}
-(void)chart:(XSChart *)view didClickPointAtIndex:(NSInteger)index{
    NSLog(@"click at index:%ld",(long)index);
}





@end
