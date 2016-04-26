//
//  RepleDetCell.h
//  guoping
//
//  Created by wangqian on 15/11/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReplDetModel;
@interface RepleDetCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) ReplDetModel *cellModel;



//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
