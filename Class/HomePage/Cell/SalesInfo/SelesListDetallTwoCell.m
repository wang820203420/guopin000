//
//  SelesListDetallTwoCell.m
//  guoping
//
//  Created by zhisu on 15/10/16.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SelesListDetallTwoCell.h"
#import "SalesListDetailTwoModel.h"

@interface SelesListDetallTwoCell ()

@property(nonatomic,strong)UILabel *GoodsName;//商品名称
@property(nonatomic,strong)UILabel *SalePrice;//售价
@property(nonatomic,strong)UILabel *SaleNumber;//数量
@property(nonatomic,strong)UILabel *UnitName;//单位
@property(nonatomic,strong)UILabel *Amount;//金额

@end
@implementation SelesListDetallTwoCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    SelesListDetallTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[SelesListDetallTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}


#pragma mark 会员信息的列表模版


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
      
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(13, 12, 150, 20);
        self.GoodsName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.GoodsName];
        
        
        
      
        self.SalePrice = [[UILabel alloc]init];
        //self.SalePrice.backgroundColor = [UIColor redColor];
        self.SalePrice.frame = CGRectMake(ScreenWidth/2.5, 12, 50, 20);
        self.SalePrice.font = [UIFont systemFontOfSize:15];
        self.SalePrice.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.SalePrice];
        
        
        
     
        self.SaleNumber = [[UILabel alloc]init];
        self.SaleNumber.frame = CGRectMake(ScreenWidth/1.75,12, 200, 20);
        self.SaleNumber.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.SaleNumber];
        
        
   
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.47,12, 200, 20);
        self.UnitName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.UnitName];
        
        

        self.Amount = [[UILabel alloc]init];
        self.Amount.frame = CGRectMake(ScreenWidth/1.1,12, 200, 20);
        self.Amount.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.Amount];
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(SalesListDetailTwoModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.SalePrice.text = [NSString stringWithFormat:@"%.2f",_cellModel.SalePrice.doubleValue];
    self.SaleNumber.text = [NSString stringWithFormat:@"%.3f",_cellModel.SaleNumber.doubleValue];
    self.UnitName.text = _cellModel.UnitName;
    self.Amount.text = [NSString stringWithFormat:@"%.2f",_cellModel.Amount.doubleValue];
    
    //售价
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size1 = [self.SalePrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.SalePrice.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/2.5-size1.width;
    
    self.SalePrice.frame = frame1;
    
    //数量
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size2 = [self.SaleNumber.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 = self.SaleNumber.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.75-size2.width;
    
    self.SaleNumber.frame = frame2;
    
    
    //小计
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size3 = [self.Amount.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    
    
    CGRect frame3 = self.Amount.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.1-size3.width;
    
    self.Amount.frame = frame3;
    
    
}


@end
