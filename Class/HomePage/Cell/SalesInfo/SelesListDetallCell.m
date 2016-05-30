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
@property(nonatomic,strong)UILabel *totalcutoff;//折扣金额
@property(nonatomic,strong)UILabel *memberID;//会员卡


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
        
        
        
        
        UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(13,170, 100, 10) title:@"折扣金额" textAlignment:NSTextAlignmentLeft];
        label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label3.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label3];
        self.totalcutoff = [[UILabel alloc]init];
        self.totalcutoff.frame = CGRectMake(ScreenWidth/1.05,170, 200, 20);
        self.totalcutoff.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.totalcutoff];
        
        
        
        
        UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(13,220, 100, 10) title:@"会员卡" textAlignment:NSTextAlignmentLeft];
        label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label4.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label4];
        self.memberID = [[UILabel alloc]init];
        self.memberID.frame = CGRectMake(ScreenWidth/1.05,220, 200, 20);
        self.memberID.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:self.memberID];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(SalesListDetailModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.saleno.text = _cellModel.saleno;
    self.storename.text = _cellModel.storename;
    self.saledate.text = _cellModel.saledate;
    self.memberID.text = _cellModel.memberID;
    self.totalcutoff.text = [NSString stringWithFormat:@"%@",_cellModel.totalcutoff];
    self.memberID.text = [NSString stringWithFormat:@"%@",_cellModel.memberID];
    
    
   //1.订单号
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size1 = [self.saleno.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.saleno.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.05-size1.width;
    
    self.saleno.frame = frame1;
    

   //2.所属门店
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size2 = [self.storename.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 = self.storename.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.05-size2.width;
    
    self.storename.frame = frame2;
    
    

    //3.订单时间
    
    
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size3 = [self.saledate.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    
    
    CGRect frame3 = self.saledate.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.05-size3.width;
    
    self.saledate.frame = frame3;
    
    

    //4.折扣金额
    
    
    NSDictionary *attribute3 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size4 = [self.totalcutoff.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute3 context:nil].size;
    
    
    CGRect frame4 = self.totalcutoff.frame;
    frame4.size.width = size4.width;
    frame4.origin.x =ScreenWidth/1.05-size4.width;
    
    self.totalcutoff.frame = frame4;
    
    

    //5.会员卡
    
    
    NSDictionary *attribute4 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size5 = [self.memberID.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute4 context:nil].size;
    
    
    CGRect frame5 = self.memberID.frame;
    frame5.size.width = size5.width;
    frame5.origin.x =ScreenWidth/1.05-size5.width;
    
    self.memberID.frame = frame5;

    
    
    
}


@end
