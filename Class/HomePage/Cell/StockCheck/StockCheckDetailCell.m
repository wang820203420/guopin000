//
//  StockCheckDetailCell.m
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "StockCheckDetailCell.h"
#import "StockCheckModel.h"

@interface StockCheckDetailCell ()

@property (nonatomic, strong) UILabel *stockNo;       //盘点编号
@property (nonatomic, strong) UILabel *storeName;     //盘点门店
@property (nonatomic, strong) UILabel *createTime;    //盘点时间
@property (nonatomic, strong )UILabel *staffName;     //操作人

@end

@implementation StockCheckDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *cellID = @"detailCellID";
    
    StockCheckDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil) {
        cell = [[StockCheckDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.盘点编号
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 20, 100, 10) title:@"盘点编号" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        self.stockNo = [[UILabel alloc]init];
        self.stockNo.frame = CGRectMake(ScreenWidth/1.05, 15, 150, 20);
        self.stockNo.font = [UIFont systemFontOfSize:16];
        self.stockNo.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.stockNo];
        
        //2.盘点门店
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(13, 70, 100, 10) title:@"盘点门店" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label1];
        self.storeName = [[UILabel alloc]init];
        self.storeName.frame = CGRectMake(ScreenWidth/1.05, 75, 150, 10);
        self.storeName.font = [UIFont systemFontOfSize:16];
        self.storeName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.storeName];
        
        //3.盘点时间
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(13,120, 100, 10) title:@"盘点时间" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label2];
        self.createTime = [[UILabel alloc]init];
        self.createTime.frame = CGRectMake(ScreenWidth/1.05,120, 200, 20);
        self.createTime.font = [UIFont systemFontOfSize:16];
        self.createTime.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.createTime];
        
        //4.操作人
        UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(13,170, 100, 10) title:@"操作人" textAlignment:NSTextAlignmentLeft];
        label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label3.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label3];
        self.staffName = [[UILabel alloc]init];
        self.staffName.frame = CGRectMake(ScreenWidth/1.05,170, 200, 20);
        self.staffName.font = [UIFont systemFontOfSize:16];
        self.staffName.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.staffName];
    }
    return self;
}

- (void)setCellModel:(StockCheckModel *)cellModel
{
    _cellModel = cellModel;
    
    self.stockNo.text = cellModel.StockNo;
    self.storeName.text = cellModel.StoreName;
    self.createTime.text = cellModel.CreateTime;
    self.staffName.text = cellModel.StaffName;
    
    //重新计算frame
    [self frameWith:_stockNo];        //盘点编号
    [self frameWith:_storeName];      //盘点门店
    [self frameWith:_createTime];     //盘点时间
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
