//
//  TransferCell.h
//  guoping
//
//  Created by zhisu on 16/6/21.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TransferModel;
@interface TransferCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) TransferModel *cellModel;
//指定的cell是给哪个tableview使用
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
