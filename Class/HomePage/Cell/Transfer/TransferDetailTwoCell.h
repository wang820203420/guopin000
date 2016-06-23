//
//  TransferDetailTwoCell.h
//  guoping
//
//  Created by zhisu on 16/6/22.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransferDetailModel;
@interface TransferDetailTwoCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) TransferDetailModel *cellModel;

//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
