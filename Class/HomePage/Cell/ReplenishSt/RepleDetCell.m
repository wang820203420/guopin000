//
//  RepleDetCell.m
//  guoping
//
//  Created by wangqian on 15/11/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "RepleDetCell.h"
#import "ReplDetModel.h"

@interface RepleDetCell ()


@property(nonatomic,strong)UILabel *StoreIncomeNo;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *IncomeDate;


//@property(nonatomic,strong)NSString *StoreIncomeNo;//商品名称
//
//@property(nonatomic,strong)NSString *StoreName;//水果一号店
//
//@property(nonatomic,strong)NSString *IncomeDate;//订单时间

@end
@implementation RepleDetCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    RepleDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[RepleDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 70, 10) title:@"订单号" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        self.StoreIncomeNo = [[UILabel alloc]init];
        //self.StoreIncomeNo.backgroundColor = [UIColor redColor];
        self.StoreIncomeNo.frame = CGRectMake(ScreenWidth/1.02, 15, 150, 20);
        self.StoreIncomeNo.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.StoreIncomeNo];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"所属门店" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.StoreName = [[UILabel alloc]init];
        //self.StoreName.backgroundColor = [UIColor redColor];
        self.StoreName.frame = CGRectMake(ScreenWidth/1.02, 65, 150, 20);
        self.StoreName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.StoreName];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 120, 200, 10) title:@"订单时间" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label2];
        self.IncomeDate = [[UILabel alloc]init];
        //self.IncomeDate.backgroundColor = [UIColor redColor];
        self.IncomeDate.frame = CGRectMake(ScreenWidth/1.01,115, 150, 20);
        self.IncomeDate.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.IncomeDate];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(ReplDetModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.StoreIncomeNo.text = _cellModel.StoreIncomeNo;
    self.StoreName.text = _cellModel.StoreName;
    self.IncomeDate.text= _cellModel.IncomeDate;
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size1 = [ self.StoreIncomeNo.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 =  self.StoreIncomeNo.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.02-size1.width;
    
     self.StoreIncomeNo.frame = frame1;
    
    //店铺
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size2 = [self.StoreName.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 =  self.StoreName.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.02-size2.width;
    
    self.StoreName.frame = frame2;
    
    
    //订单时间
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size3 = [self.IncomeDate.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    
    
    CGRect frame3 =  self.IncomeDate.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.01-size3.width;
    
   self.IncomeDate.frame = frame3;
    
    
    
}
@end
