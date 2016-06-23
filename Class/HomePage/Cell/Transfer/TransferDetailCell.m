//
//  TransferDetailCell.m
//  guoping
//
//  Created by zhisu on 16/6/21.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferDetailCell.h"
#import "TransferModel.h"

@interface TransferDetailCell ()

@property (nonatomic,strong) UILabel *orderNo;        //调货单号
@property (nonatomic,strong) UILabel *storeName;      //调货门店
@property (nonatomic,strong) UILabel *targetStoreName;//收货门店
@property (nonatomic,strong) UILabel *sendDate;       //调货时间
@property (nonatomic,strong) UILabel *staffName;      //操作人

@end

@implementation TransferDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"detailCellID";
    
    TransferDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[TransferDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.调货单号
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 20, 100, 10) title:@"调货单号" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        self.orderNo = [[UILabel alloc]init];
        self.orderNo.frame = CGRectMake(ScreenWidth/1.05, 15, 150, 20);
        self.orderNo.font = [UIFont systemFontOfSize:16];
        self.orderNo.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.orderNo];
        
        //2.调货门店
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(13, 70, 100, 10) title:@"调货门店" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label1];
        self.storeName = [[UILabel alloc]init];
        self.storeName.frame = CGRectMake(ScreenWidth/1.05, 75, 150, 10);
        self.storeName.font = [UIFont systemFontOfSize:16];
        self.storeName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.storeName];
        
        //3.收货门店
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(13,120, 100, 10) title:@"收货门店" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label2];
        self.targetStoreName = [[UILabel alloc]init];
        self.targetStoreName.frame = CGRectMake(ScreenWidth/1.05,120, 200, 20);
        self.targetStoreName.font = [UIFont systemFontOfSize:16];
        self.targetStoreName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.targetStoreName];
        
        //4.调货时间
        UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(13,170, 100, 10) title:@"调货时间" textAlignment:NSTextAlignmentLeft];
        label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label3.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label3];
        self.sendDate = [[UILabel alloc]init];
        self.sendDate.frame = CGRectMake(ScreenWidth/1.05,170, 200, 20);
        self.sendDate.font = [UIFont systemFontOfSize:16];
        self.sendDate.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.sendDate];
        
        //5.操作人
        UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(13,220, 100, 10) title:@"操作人" textAlignment:NSTextAlignmentLeft];
        label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label4.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label4];
        self.staffName = [[UILabel alloc]init];
        self.staffName.frame = CGRectMake(ScreenWidth/1.05,220, 200, 20);
        self.staffName.font = [UIFont systemFontOfSize:16];
        self.staffName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.staffName];
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
    self.staffName.text = cellModel.StaffName;
    
    //重新计算frame
    [self frameWith:_orderNo];        //调货单号
    [self frameWith:_storeName];      //调货门店
    [self frameWith:_targetStoreName];//收货门店
    [self frameWith:_sendDate];       //调货时间
    [self frameWith:_staffName];      //操作人
}

//动态计算frame
- (void)frameWith:(UILabel *)label
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    CGSize size = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    CGRect frame = label.frame;
    frame.size.width = size.width;
    frame.origin.x = ScreenWidth/1.05 - size.width;
    label.frame = frame;
}





@end