
//
//  GoodsMngCell.m
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "GoodsMngCell.h"
#import "GoodsMngModel.h"


@interface GoodsMngCell ()


@property(nonatomic,strong)UILabel *GoodsName;
@property(nonatomic,strong)UILabel *GoodsCode;
@property(nonatomic,strong)UILabel *SaleState;
@property(nonatomic,strong)UILabel *RetailPrice;
@property(nonatomic,strong)UILabel *UnitName;


@end
@implementation GoodsMngCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    GoodsMngCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[GoodsMngCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 100, 10) title:@"商品名称:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(ScreenWidth/3.9, 20, 150, 10);
        self.GoodsName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsName];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 100, 10) title:@"商品简码:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.GoodsCode = [[UILabel alloc]init];
        self.GoodsCode.frame = CGRectMake(ScreenWidth/3.9, 45, 150, 10);
        self.GoodsCode.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsCode];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 100, 10) title:@"商品状态:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.SaleState = [[UILabel alloc]init];
        self.SaleState.frame = CGRectMake(ScreenWidth/3.9,70, 150, 10);
        self.SaleState.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.SaleState];
        
        
        
        self.RetailPrice = [[UILabel alloc]init];
        self.RetailPrice.frame = CGRectMake(ScreenWidth/1.15,38, 100, 20);
        self.RetailPrice.font = [UIFont systemFontOfSize:16.5];
        //self.RetailPrice.backgroundColor = [UIColor blueColor];
        self.RetailPrice.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        [self.contentView addSubview:self.RetailPrice];
        
        
        //售价单位
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.13,38, 40, 20);
        self.UnitName.font = [UIFont systemFontOfSize:16.5];
        //self.UnitName.backgroundColor = [UIColor blueColor];
        self.UnitName.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        [self.contentView addSubview:self.UnitName];
        
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(GoodsMngModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.GoodsCode.text = _cellModel.GoodsCode;
    self.SaleState.text= _cellModel.SaleState;
    self.RetailPrice.text = [NSString stringWithFormat:@"%.2f元/",_cellModel.RetailPrice.doubleValue];
    self.UnitName.text = _cellModel.UnitName;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.5]};
    
    //动态计算出宽度
    CGSize size1 = [self.RetailPrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.RetailPrice.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.15-size1.width;
    
    self.RetailPrice.frame = frame1;
    
    //商品zhon
    CGRect frame2 = self.UnitName.frame;
    //frame2.size.width = size1.width;
    frame2.origin.x =ScreenWidth/1.15-size1.width+size1.width;
    
    self.UnitName.frame = frame2;
    
    
    
}
@end
