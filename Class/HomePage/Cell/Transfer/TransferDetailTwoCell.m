//
//  TransferDetailTwoCell.m
//  guoping
//
//  Created by zhisu on 16/6/22.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferDetailTwoCell.h"
#import "TransferDetailModel.h"

@interface TransferDetailTwoCell ()

@property (nonatomic,strong) UILabel *GoodsName;  //商品名称
@property (nonatomic,strong) UILabel *UnitName;   //商品单位
@property (nonatomic,strong) UILabel *BoxAmount;  //单箱重量
@property (nonatomic,strong) UILabel *BoxPtare;   //单箱皮重
@property (nonatomic,strong) UILabel *SendBox;    //调货箱数
@property (nonatomic,strong) UILabel *SendNumber; //总数量


@end

@implementation TransferDetailTwoCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"detailTwoCellID";
    TransferDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[TransferDetailTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //1.商品名称
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(13, 12, 150, 20);
        self.GoodsName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.GoodsName];
        
        //2.单箱重量
        self.BoxAmount = [[UILabel alloc]init];
        self.BoxAmount.frame = CGRectMake(ScreenWidth/2.5, 12, 50, 20);
        self.BoxAmount.font = [UIFont systemFontOfSize:15];
        self.BoxAmount.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.BoxAmount];
        
        //3.单箱皮重
        self.BoxPtare = [[UILabel alloc]init];
        self.BoxPtare.frame = CGRectMake(ScreenWidth/1.75,12, 200, 20);
        self.BoxPtare.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.BoxPtare];
    
        //4.调货箱数
        self.SendBox = [[UILabel alloc]init];
        self.SendBox.frame = CGRectMake(ScreenWidth/1.47,12, 200, 20);
        self.SendBox.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.SendBox];
        
        //5.商品单位
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.1,12, 200, 20);
        self.UnitName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.UnitName];
        
        //6.总数量
        self.SendNumber = [[UILabel alloc]init];
        self.SendNumber.frame = CGRectMake(ScreenWidth/1.1,12, 200, 20);
        self.SendNumber.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.SendNumber];
    }
    
    return self;
}


-(void)setCellModel:(TransferDetailModel *)cellModel
{
    _cellModel = cellModel;
    
    self.GoodsName.text = cellModel.GoodsName;
    self.BoxAmount.text = [NSString stringWithFormat:@"%.2f", cellModel.BoxAmount.doubleValue];
    self.BoxPtare.text = [NSString stringWithFormat:@"%.2f", cellModel.BoxPtare.doubleValue];
    self.SendBox.text = [NSString stringWithFormat:@"%.2f", cellModel.SendBox.doubleValue];
    self.UnitName.text = cellModel.UnitName;
    self.SendNumber.text = [NSString stringWithFormat:@"%.2f", cellModel.SendNumber.doubleValue];
}





@end



