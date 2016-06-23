//
//  TransferDetailCell.h
//  guoping
//
//  Created by zhisu on 16/6/21.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TransferModel;
@interface TransferDetailCell : UITableViewCell


@property(nonatomic,retain) TransferModel *cellModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
