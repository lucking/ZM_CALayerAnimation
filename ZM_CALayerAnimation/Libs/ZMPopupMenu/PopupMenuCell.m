//
//  PopupMenuCell.m
//  ZM_CALayerAnimation
//
//  Created by ZM on 2017/8/29.
//  Copyright © 2017年 ZM. All rights reserved.
//

#import "PopupMenuCell.h"
#import "PopupMenuHeader.h"
#import "UIView+PPFrame.h"

@implementation PopupMenuCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//配置数据
- (void)setTitleArray:(NSArray *)titleArray imageArray:(NSArray *)imageArray cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (imageArray!=nil && imageArray.count>0) {
        self.imgView.image= PPIMG(imageArray[indexPath.row]);
    }
    self.titleLab.text = titleArray[indexPath.row];
}


- (UILabel *)titleLab {
    if (_titleLab==nil) {
        CGRect rect= CGRectMake(0, 0, 0, 0);
        if (_imgView==nil) {
            rect= CGRectMake(0, 0, self.cellWidth, self.cellHeight);
        }else{
            rect= CGRectMake(_imgView.right, 0, self.cellWidth-_imgView.right, self.cellHeight);
        }
        _titleLab = [[UILabel alloc] initWithFrame:rect];
        _titleLab.font = PPFont(16);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
    }return _titleLab;
}
- (UIImageView *)imgView {
    if (_imgView==nil) {
        CGFloat yy=5;
        CGFloat HH= (self.cellHeight-yy*2);
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, yy, HH, HH)];
        _imgView.backgroundColor = [UIColor clearColor];
        [self addSubview:_imgView];
    }
    return _imgView;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //self.bounds
    NSLog(@"self.width= %f",self.width);
    NSLog(@"self.height= %f \n ",self.height);
    NSLog(@"self.width= %f",self.cellWidth);
    NSLog(@"self.height= %f \n ",self.cellHeight);
    // cell.titleLab.textColor = _textColor;
    // cell.titleLab.font = [UIFont systemFontOfSize:_fontSize];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    
}

@end
