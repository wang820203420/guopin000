//
//  SelesListDetallCell.m
//  guoping
//
//  Created by zhisu on 15/10/16.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SelesListDetallCell.h"
#import "SalesListDetailModel.h"

@interface SelesListDetallCell ()

@property(nonatomic,strong)UILabel *saleno;
@property(nonatomic,strong)UILabel *storename;
@property(nonatomic,strong)UILabel *saledate;


@end

@implementation SelesListDetallCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    SelesListDetallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[SelesListDetallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 20, 100, 10) title:@"订单号" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        self.saleno = [[UILabel alloc]init];
        self.saleno.frame = CGRectMake(ScreenWidth/1.05, 15, 150, 20);
        self.saleno.font = [UIFont systemFontOfSize:16];
        //self.saleno.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.saleno];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(13, 70, 100, 10) title:@"所属门店" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label1];
        self.storename = [[UILabel alloc]init];
        self.storename.frame = CGRectMake(ScreenWidth/1.05, 75, 150, 10);
        self.storename.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.storename];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(13,120, 100, 10) title:@"订单时间" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label2];
        self.saledate = [[UILabel alloc]init];
        self.saledate.frame = CGRectMake(ScreenWidth/1.05,120, 200, 20);
        self.saledate.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.saledate];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(SalesListDetailModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.saleno.text = _cellModel.saleno;
    self.storename.text = _cellModel.storename;
    self.saledate.text = _cellModel.saledate;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size1 = [self.saleno.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.saleno.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.05-size1.width;
    
    self.saleno.frame = frame1;
    
    
    //所属门店
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size2 = [self.storename.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 = self.storename.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.05-size2.width;
    
    self.storename.frame = frame2;
    
    
    //订单时间
    
    
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size3 = [self.saledate.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    
    
    CGRect frame3 = self.saledate.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.05-size3.width;
    
    self.saledate.frame = frame3;
    
    
    
    
}


@end
