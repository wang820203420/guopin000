//
//  ToGoodsDetCell.h
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToGoodsDetModel;
@interface ToGoodsDetCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) ToGoodsDetModel *cellModel;



//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;

@end
