//
//  StockshCell.m
//  guoping
//
//  Created by zhisu on 15/10/17.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "StockshCell.h"
#import "StockshModel.h"


@interface StockshCell ()

//
//@property(nonatomic,assign,setter=setId:)NSInteger mId;
//
//@property(nonatomic,strong)NSString *GoodsName;//商品名称
//
//@property(nonatomic,strong)NSString *GoodsCode;//商品编码
//
//@property(nonatomic,strong)NSString *StoreName;//所属门店
//
//@property(nonatomic,strong)NSString *CurrentInventory;//当前库存
{
    UILabel *_label3;
}

@property(nonatomic,strong)UILabel *GoodsName;
@property(nonatomic,strong)UILabel *GoodsCode;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *CurrentInventory;
@property(nonatomic,strong)UILabel *UnitName;


@end


@implementation StockshCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    StockshCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[StockshCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 80, 10) title:@"商品名称:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(80, 20, 150, 10);
        self.GoodsName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsName];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"商品简码:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.GoodsCode = [[UILabel alloc]init];
        self.GoodsCode.frame = CGRectMake(80, 45, 150, 10);
        self.GoodsCode.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsCode];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"所属门店:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(80,70, 150, 10);
        self.StoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreName];
        
        
        
        _label3= [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.27, 40, 100, 20) title:@"库存" textAlignment:NSTextAlignmentLeft];
        _label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        _label3.font = [UIFont systemFontOfSize:14];
        //_label3.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_label3];
        self.CurrentInventory = [[UILabel alloc]init];
        //self.CurrentInventory.backgroundColor = [UIColor redColor];
        self.CurrentInventory.frame = CGRectMake(ScreenWidth/1.14,40, 60, 20);
        self.CurrentInventory.font = [UIFont systemFontOfSize:14];
        self.CurrentInventory.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        [self.contentView addSubview:self.CurrentInventory];
        
        
        //重量单位
        self.UnitName = [[UILabel alloc]init];
        //self.UnitName.backgroundColor = [UIColor redColor];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.14,40, 60, 20);
        self.UnitName.font = [UIFont systemFontOfSize:14];
        self.UnitName.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        [self.contentView addSubview:self.UnitName];
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(StockshModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.GoodsCode.text = _cellModel.GoodsCode;
    self.StoreName.text = _cellModel.StoreName;
    self.CurrentInventory.text= [NSString stringWithFormat:@"%.2f",_cellModel.CurrentInventory.doubleValue];
    self.UnitName.text =_cellModel.UnitName;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    //动态计算出宽度
    CGSize size1 = [self.CurrentInventory.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.CurrentInventory.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.14-size1.width;
    
    self.CurrentInventory.frame = frame1;
    
    
    CGRect frame2 = self.CurrentInventory.frame;
    frame2.size.width = 50;
    frame2.origin.x =ScreenWidth/1.14-size1.width-30;
    _label3.frame = frame2;

    
    
    //重量单位
    CGRect frame3 = self.UnitName.frame;
    frame3.size.width = 40;
    frame3.origin.x =ScreenWidth/1.14;
    
    self.UnitName.frame = frame3;
    
}

@end
