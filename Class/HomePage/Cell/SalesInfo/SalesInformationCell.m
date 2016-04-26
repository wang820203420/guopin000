//
//  SalesInformationCell.m
//  guoping
//
//  Created by zhisu on 15/10/15.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SalesInformationCell.h"
#import "SalesInformationModel.h"


@interface SalesInformationCell ()
{
    UILabel *_label3;
}

@property(nonatomic,strong)UILabel *saleno;
@property(nonatomic,strong)UILabel *storename;
@property(nonatomic,strong)UILabel *totalmoney;
@property(nonatomic,strong)UILabel *saledate;


@end


@implementation SalesInformationCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    SalesInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[SalesInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        self.saleno = [[UILabel alloc]init];
        self.saleno.frame = CGRectMake(ScreenWidth/5.357, 20, 150, 10);
        self.saleno.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.saleno];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"所属店:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.storename = [[UILabel alloc]init];
        self.storename.frame = CGRectMake(70, 45, 150, 10);
        self.storename.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.storename];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"订单时间:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.saledate = [[UILabel alloc]init];
        self.saledate.frame = CGRectMake(85,70, 150, 10);
        self.saledate.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.saledate];
        
        
        
        _label3= [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.2, 40, 20, 20) title:@"¥" textAlignment:NSTextAlignmentLeft];
        _label3.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        _label3.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:_label3];
        self.totalmoney = [[UILabel alloc]init];
        //self.totalmoney.backgroundColor = [UIColor redColor];
        self.totalmoney.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        self.totalmoney.frame = CGRectMake(ScreenWidth/1.14,40, 30, 20);
        self.totalmoney.font = [UIFont systemFontOfSize:14];
        self.totalmoney.textAlignment = NSTextAlignmentRight;
        
        
        
        
        
        [self.contentView addSubview:self.totalmoney];
        
    }
    
    return self;
    
}



-(void)setCellModel:(SalesInformationModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.saleno.text = _cellModel.saleno;
    self.storename.text = _cellModel.storename;
    self.saledate.text = _cellModel.saledate;
    self.totalmoney.text= [NSString stringWithFormat:@"%.2f",_cellModel.totalmoney.doubleValue];
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    //动态计算出宽度
    CGSize size1 = [self.totalmoney.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.totalmoney.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.14-size1.width;
    
    self.totalmoney.frame = frame1;
    
    
    CGRect frame2 = self.totalmoney.frame;
    frame2.size.width = size1.width;
    frame2.origin.x =ScreenWidth/1.2-size1.width;
    
    _label3.frame = frame2;
    
    
    
    
}





@end

