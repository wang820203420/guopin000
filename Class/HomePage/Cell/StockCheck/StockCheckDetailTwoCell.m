//
//  StockCheckDetailTwoCell.m
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "StockCheckDetailTwoCell.h"
#import "StockCheckDetailModel.h"

@interface StockCheckDetailTwoCell ()

@property (nonatomic,strong) UILabel *goodsName;    //商品名称
@property (nonatomic,strong) UILabel *unitName;     //商品单位
@property (nonatomic,strong) UILabel *boxNum;       //盘点箱数
@property (nonatomic,strong) UILabel *totalAmount;  //盘点重量
@property (nonatomic,strong) UILabel *diffAmount;   //库存差异

@end
@implementation StockCheckDetailTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"detailTwoCellID";
    StockCheckDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[StockCheckDetailTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //1.商品名称
        self.goodsName = [[UILabel alloc]init];
        self.goodsName.frame = CGRectMake(13, 12, 150, 20);
        self.goodsName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.goodsName];
        
        //2.盘点箱数
        self.boxNum = [[UILabel alloc]init];
        self.boxNum.frame = CGRectMake(ScreenWidth/2.5, 12, 50, 20);
        self.boxNum.font = [UIFont systemFontOfSize:15];
        self.boxNum.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.boxNum];
        
        //3.盘点重量
        self.totalAmount = [[UILabel alloc]init];
        self.totalAmount.frame = CGRectMake(ScreenWidth/1.75,12, 200, 20);
        self.totalAmount.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.totalAmount];
        
        //4.商品单位
        self.unitName = [[UILabel alloc]init];
        self.unitName.frame = CGRectMake(ScreenWidth/1.47,12, 200, 20);
        self.unitName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.unitName];
        
        //5.库存差异
        self.diffAmount = [[UILabel alloc]init];
        self.diffAmount.frame = CGRectMake(ScreenWidth/1.1,12, 200, 20);
        self.diffAmount.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.diffAmount];
    }
    
    return self;
}


-(void)setCellModel:(StockCheckDetailModel *)cellModel
{
    _cellModel = cellModel;
    
    self.goodsName.text = cellModel.GoodsName;
    self.boxNum.text = [NSString stringWithFormat:@"%.2f", cellModel.BoxNum.doubleValue];
    self.totalAmount.text = [NSString stringWithFormat:@"%.2f", cellModel.TotalAmount.doubleValue];
    self.unitName.text = cellModel.UnitName;
    self.diffAmount.text = [NSString stringWithFormat:@"%.2f", cellModel.DiffAmount.doubleValue];
}

@end