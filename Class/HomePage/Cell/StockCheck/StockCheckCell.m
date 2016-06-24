//
//  StockCheckCell.m
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "StockCheckCell.h"
#import "StockCheckModel.h"

@interface StockCheckCell ()

@property (nonatomic,strong) UILabel *stockNo;       //盘点编号
@property (nonatomic,strong) UILabel *storeName;     //盘点门店
@property (nonatomic,strong) UILabel *createTime;    //盘点时间

@end

@implementation StockCheckCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    StockCheckCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[StockCheckCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //1.盘点编号
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 80, 10) title:@"盘点编号:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.stockNo = [[UILabel alloc]init];
        self.stockNo.frame = CGRectMake(80, 20, 150, 10);
        self.stockNo.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.stockNo];
    
        //2.盘点门店
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"盘点门店:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.storeName = [[UILabel alloc]init];
        self.storeName.frame = CGRectMake(80, 45, 150, 10);
        self.storeName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.storeName];
        
        //3.盘点时间
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"盘点时间:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.createTime = [[UILabel alloc]init];
        self.createTime.frame = CGRectMake(80, 70, 150, 10);
        self.createTime.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.createTime];
        
        //4.添加箭头
        UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/1.06, 47, 10, 15) imageName:@"my_arrow_17X30@2x"];
        [self.contentView addSubview:arrowImage];
        
        //5.补全线条
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:CGRectMake(0, 94.5, ScreenWidth, 0.5) imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage];
    }
    return self;
}

- (void)setCellModel:(StockCheckModel *)cellModel
{
    _cellModel = cellModel;
    self.stockNo.text = cellModel.StockNo;        //盘点编号
    self.storeName.text = cellModel.StoreName;    //盘点门店
    self.createTime.text = cellModel.CreateTime;  //盘点时间
}


@end
