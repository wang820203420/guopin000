//
//  SelesListDetallTwoCell.h
//  guoping
//
//  Created by zhisu on 15/10/16.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SalesListDetailTwoModel;
@interface SelesListDetallTwoCell : UITableViewCell


//保存当前cell的显示数据
@property(nonatomic,retain) SalesListDetailTwoModel *cellModel;


//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
