//
//  ReplenishStCell.h
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReplenishStModel;
@interface ReplenishStCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) ReplenishStModel *cellModel;



//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
