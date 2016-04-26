//
//  AllStoreCell.h
//  guoping
//
//  Created by zhisu on 15/10/30.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AllStoreModel;
@interface AllStoreCell : UITableViewCell

//保存当前cell的显示数据
@property(nonatomic,retain) AllStoreModel *cellModel;



//指定的cell是给哪个tableview使用
+(instancetype)cellWithTableView:(UITableView *)tableView;




@end
