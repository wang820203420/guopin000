//
//  ToGoodsCell.m
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ToGoodsCell.h"
#import "ToGoosdModel.h"


@interface ToGoodsCell ()


@property(nonatomic,strong)UILabel *StoreNeedOrderNo;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *CreateTime;



@end
@implementation ToGoodsCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ToGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[ToGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 50, 10) title:@"订单号:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.StoreNeedOrderNo = [[UILabel alloc]init];
        self.StoreNeedOrderNo.frame = CGRectMake(ScreenWidth/4.8, 20, 150, 10);
        self.StoreNeedOrderNo.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreNeedOrderNo];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"所属店:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(ScreenWidth/4.8, 45, 150, 10);
        self.StoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreName];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"订单时间:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.CreateTime = [[UILabel alloc]init];
        self.CreateTime.frame = CGRectMake(ScreenWidth/3.9,65, 150, 20);
        self.CreateTime.font = [UIFont systemFontOfSize:14];
        //self.CreateTime.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.CreateTime];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(ToGoosdModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.StoreNeedOrderNo.text = _cellModel.StoreNeedOrderNo;
    self.StoreName.text = _cellModel.StoreName;
    self.CreateTime.text= _cellModel.CreateTime;
    
    
}

@end
