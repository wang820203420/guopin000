//
//  ReplCreatCell.h
//  guoping
//
//  Created by wangqian on 15/11/29.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReplCreatModel;
@interface ReplCreatCell : UITableViewCell
//保存当前cell的显示数据
@property(nonatomic,retain) ReplCreatModel *cellModel;



//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;


@end
