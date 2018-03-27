//
//  ZMBrokenLineView.h
//  ZM_CALayerAnimation
//
//  Created by ZM on 2018/3/27.
//  Copyright © 2018年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZMBrokenLineView;

@protocol ZMBrokenLineViewDataSource <NSObject>
@required
-(NSInteger)numberForChart:(ZMBrokenLineView *)chart;
-(NSInteger)chart:(ZMBrokenLineView *)chart valueAtIndex:(NSInteger)index;
@optional
//-(NSString *)titleForChart:(ZMBrokenLineView *)chart;    // 表的标题
-(NSString *)titleForXAtChart:(ZMBrokenLineView *)chart; // X轴标题
-(NSString *)titleForYAtChart:(ZMBrokenLineView *)chart; // Y轴标题
-(BOOL)showDataAtPointForChart:(ZMBrokenLineView *)chart;// 是否展示数据点
-(NSString *)chart:(ZMBrokenLineView *)chart titleForXLabelAtIndex:(NSInteger)index;
@end

@protocol ZMBrokenLineViewDelegate <NSObject>
@optional
-(void)chart:(ZMBrokenLineView *)view didClickPointAtIndex:(NSInteger)index;
@end



@interface ZMBrokenLineView : UIView

@property(nonatomic,assign)id<ZMBrokenLineViewDataSource> dataSource;
@property(assign, nonatomic)id<ZMBrokenLineViewDelegate> delegate;
-(void)reload;

@property(copy, nonatomic) NSString *title;
@property(copy, nonatomic) NSString *xTitle;
@property(copy, nonatomic) NSString *yTitle;

@end
