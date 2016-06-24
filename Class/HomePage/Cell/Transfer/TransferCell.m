//
//  TransferCell.m
//  guoping
//
//  Created by zhisu on 16/6/21.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferCell.h"
#import "TransferModel.h"

@interface TransferCell ()

@property (nonatomic,strong) UILabel *orderNo;        //调货单号
@property (nonatomic,strong) UILabel *storeName;      //调货门店
@property (nonatomic,strong) UILabel *targetStoreName;//收货门店
@property (nonatomic,strong) UILabel *sendDate;       //订单时间

@end


@implementation TransferCell
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    TransferCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[TransferCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.调货单号
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 200, 10) title:@"调货单号:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.orderNo = [[UILabel alloc]init];
        self.orderNo.frame = CGRectMake(ScreenWidth/4.5, 20, 200, 10);
        self.orderNo.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.orderNo];
        
        //2.调货门店
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"调货门店:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.storeName = [[UILabel alloc]init];
        self.storeName.frame = CGRectMake(ScreenWidth/4.5, 45, 200, 10);
        self.storeName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.storeName];
        
        //3.收货门店
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"收货门店:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.targetStoreName = [[UILabel alloc]init];
        self.targetStoreName.frame = CGRectMake(ScreenWidth/4.5, 70, 200, 10);
        self.targetStoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.targetStoreName];
        
        //4.订单时间
        UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(10, 95, 200, 10) title:@"订单时间:" textAlignment:NSTextAlignmentLeft];
        label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label3.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label3];
        self.sendDate = [[UILabel alloc]init];
        self.sendDate.frame = CGRectMake(ScreenWidth/4.5, 95, 200, 10);
        self.sendDate.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.sendDate];
        
        //5.添加箭头
        UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/1.06, 53, 10, 15) imageName:@"my_arrow_17X30@2x"];
        [self.contentView addSubview:arrowImage];
        
        //6.补全线条
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:CGRectMake(0, 124.5, ScreenWidth, 0.5) imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage];
    }
    return self;
}

- (void)setCellModel:(TransferModel *)cellModel
{
    _cellModel = cellModel;
    self.orderNo.text = cellModel.OrderNo;
    self.storeName.text = cellModel.StoreName;
    self.targetStoreName.text = cellModel.TargetStoreName;
    self.sendDate.text = cellModel.SendDate;
}

@end
