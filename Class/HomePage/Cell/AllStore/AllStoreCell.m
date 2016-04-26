//
//  AllStoreCell.m
//  guoping
//
//  Created by zhisu on 15/10/30.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "AllStoreCell.h"
#import "AllStoreModel.h"


@interface AllStoreCell ()


@property(nonatomic,strong)UILabel *StoreName;



@end

@implementation AllStoreCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    AllStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[AllStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}

#pragma mark 下拉列表中所有店铺的名称列表

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        

        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(10, 15, 150, 10);
        
        self.StoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreName];
        
        

        
    }
    
    return self;
    
}



-(void)setCellModel:(AllStoreModel *)cellModel
{
    
    _cellModel = cellModel;
    

    self.StoreName.text = _cellModel.StoreName;

    
}



@end
