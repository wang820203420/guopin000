//
//  StockDetCell.m
//  guoping
//
//  Created by zhisu on 15/11/19.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "StockDetCell.h"
#import "StockDetModel.h"


@interface StockDetCell ()

@property(nonatomic,strong)UILabel *GoodsName;
@property(nonatomic,strong)UILabel *GoodsCode;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *CurrentInventory;
@property(nonatomic,strong)UILabel *RetailPrice;
@property(nonatomic,strong)UILabel *UnitName;
@property(nonatomic,strong)UILabel *UnitName1;

@end

@implementation StockDetCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    StockDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[StockDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, -55, 80, 10) title:@"商品名称:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(80, -55, 150, 10);
        self.GoodsName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsName];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, -25, 200, 10) title:@"商品简码:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.GoodsCode = [[UILabel alloc]init];
        self.GoodsCode.frame = CGRectMake(80, -25, 150, 10);
        self.GoodsCode.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsCode];
        
        

        
        
       UILabel *label3= [MyUtil createLabelFrame:CGRectMake(10, 20, 100, 20) title:@"库存" textAlignment:NSTextAlignmentLeft];
        label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label3.font = [UIFont systemFontOfSize:16];
        //_label3.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:label3];
        self.CurrentInventory = [[UILabel alloc]init];
        //self.CurrentInventory.backgroundColor = [UIColor redColor];
        self.CurrentInventory.frame = CGRectMake(ScreenWidth/1.08,17, 60, 20);
        self.CurrentInventory.font = [UIFont systemFontOfSize:14];
        self.CurrentInventory.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.CurrentInventory];
        
        
        //重量单位
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.08,17, 60, 20);
        self.UnitName.font = [UIFont systemFontOfSize:14];
        self.UnitName.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.UnitName];
        
        
        UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"售价" textAlignment:NSTextAlignmentLeft];
        label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label4.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label4];
        self.RetailPrice = [[UILabel alloc]init];
        //self.RetailPrice.backgroundColor = [UIColor redColor];
        self.RetailPrice.frame = CGRectMake(ScreenWidth/1.08,63, 150, 20);
        self.RetailPrice.font = [UIFont systemFontOfSize:14];
        self.RetailPrice.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.RetailPrice];
        
        
        //重量单位
        self.UnitName1 = [[UILabel alloc]init];
        self.UnitName1.frame = CGRectMake(ScreenWidth/1.08,63, 60, 20);
        self.UnitName1.font = [UIFont systemFontOfSize:14];
        self.UnitName1.textColor = [UIColor blackColor];
        [self.contentView addSubview:self.UnitName1];
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 120, 200, 10) title:@"所属门店" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label2];
        self.StoreName = [[UILabel alloc]init];
        //self.StoreName.backgroundColor = [UIColor redColor];
        self.StoreName.frame = CGRectMake(ScreenWidth/1.04,113, 150, 20);
        self.StoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreName];
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(StockDetModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.GoodsCode.text = _cellModel.GoodsCode;
    self.StoreName.text = _cellModel.StoreName;
    self.CurrentInventory.text= [NSString stringWithFormat:@"%@",_cellModel.CurrentInventory.stringValue];
    self.RetailPrice.text = [NSString stringWithFormat:@"%@元/",_cellModel.RetailPrice.stringValue];
    self.UnitName.text = _cellModel.UnitName;
    self.UnitName1.text = _cellModel.UnitName;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    //动态计算出宽度
    CGSize size1 = [self.CurrentInventory.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.CurrentInventory.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.08-size1.width;
    
    self.CurrentInventory.frame = frame1;
    
    //重量单位
    CGRect frame4 = self.UnitName.frame;
    frame4.size.width = 40;
    frame4.origin.x =ScreenWidth/1.08;
    
    self.UnitName.frame = frame4;

    
    //售价
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    //动态计算出宽度
    CGSize size2 = [self.RetailPrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 = self.RetailPrice.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.08-size2.width;
    
    self.RetailPrice.frame = frame2;
    
    //重量单位
    CGRect frame5 = self.UnitName1.frame;
    frame5.size.width = 40;
    frame5.origin.x =ScreenWidth/1.08;
    
    self.UnitName1.frame = frame5;
    

    
    
    
    //所属店铺
    
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    //动态计算出宽度
    CGSize size3 = [self.StoreName.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    
    
    CGRect frame3 = self.StoreName.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.04-size3.width;
    
    self.StoreName.frame = frame3;

    
    
}

@end
