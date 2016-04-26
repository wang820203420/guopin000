//
//  ToGoodsDetailCell.m
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ToGoodsDetailCell.h"
#import "ToGoodsDetailModel.h"

@interface ToGoodsDetailCell ()

@property(nonatomic,strong)UILabel *GoodsName;//商品名称
@property(nonatomic,strong)UILabel *NeedNumber;//进货量
@property(nonatomic,strong)UILabel *CurrentInventory;//库存
@property(nonatomic,strong)UILabel *CurrentCheckInventory; //核定
@property(nonatomic,strong)UILabel *UnitName; //核定


@end
@implementation ToGoodsDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ToGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[ToGoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(15, 12, 150, 20);
        self.GoodsName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.GoodsName];
        
        
        self.CurrentInventory = [[UILabel alloc]init];
        self.CurrentInventory.frame = CGRectMake(ScreenWidth/2.65,12, 50, 20);
        self.CurrentInventory.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.CurrentInventory];
        
        
        
        self.CurrentCheckInventory = [[UILabel alloc]init];
        self.CurrentCheckInventory.frame = CGRectMake(ScreenWidth/1.75,12, 50, 20);
        self.CurrentCheckInventory.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.CurrentCheckInventory];
        
    
        self.NeedNumber = [[UILabel alloc]init];
        self.NeedNumber.frame = CGRectMake(ScreenWidth/1.3, 12, 50, 20);
        self.NeedNumber.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.NeedNumber];
        
        
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.13, 12, 50, 20);
        self.UnitName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.UnitName];
        
    }
    
    return self;
    
}



-(void)setCellModel:(ToGoodsDetailModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.NeedNumber.text = _cellModel.NeedNumber.stringValue;
    self.CurrentInventory.text =  [NSString stringWithFormat:@"%.2f",_cellModel.CurrentInventory.doubleValue];
    self.CurrentCheckInventory.text = _cellModel.CurrentCheckInventory.stringValue;
        self.UnitName.text = _cellModel.UnitName;
  
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size1 = [self.CurrentInventory.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    CGRect frame1 = self.CurrentInventory.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/2.65-size1.width;
    self.CurrentInventory.frame = frame1;
//
//    
//    //核定
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size2 = [self.CurrentCheckInventory.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    CGRect frame2 = self.CurrentCheckInventory.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.75-size2.width;
    self.CurrentCheckInventory.frame = frame2;
//
//    
//    //进货量
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度－－订单时间
    CGSize size3 = [self.NeedNumber.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    CGRect frame3 = self.NeedNumber.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.3-size3.width;
    
    self.NeedNumber.frame = frame3;
    
    
}

@end
