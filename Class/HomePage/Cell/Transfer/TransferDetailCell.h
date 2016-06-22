//
//  TransferDetailCell.h
//  guoping
//
//  Created by zhisu on 16/6/21.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransferDetailModel;
@interface TransferDetailCell : UITableViewCell


@property(nonatomic,retain) TransferDetailModel *cellModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
