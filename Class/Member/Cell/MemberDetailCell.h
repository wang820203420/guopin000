//
//  MemberDetailCell.h
//  guoping
//
//  Created by zhisu on 16/4/26.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MemberModel;//由于没有MemberDetailModel所以导入同样的MemberModel数据模型
@interface MemberDetailCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) MemberModel *cellModel;



//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;



@end
