//
//  PopupMenuCell.h
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupMenuCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic) CGFloat cellWidth;
@property (nonatomic) CGFloat cellHeight;

//配置数据
- (void)setTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end
