//
//  ReplenishStCell.m
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ReplenishStCell.h"
#import "ReplenishStModel.h"


@interface ReplenishStCell ()


@property(nonatomic,strong)UILabel *StoreIncomeNo;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *IncomeDate;


//@property(nonatomic,strong)NSString *StoreIncomeNo;//商品名称
//
//@property(nonatomic,strong)NSString *StoreName;//水果一号店
//
//@property(nonatomic,strong)NSString *IncomeDate;//订单时间

@end
@implementation ReplenishStCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ReplenishStCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[ReplenishStCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        self.StoreIncomeNo = [[UILabel alloc]init];
        self.StoreIncomeNo.frame = CGRectMake(ScreenWidth/5.357, 20, 150, 10);
        self.StoreIncomeNo.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreIncomeNo];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"所属门店:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(80, 45, 150, 10);
        self.StoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreName];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"订单时间:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.IncomeDate = [[UILabel alloc]init];
        self.IncomeDate.frame = CGRectMake(85,70, 150, 10);
        self.IncomeDate.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.IncomeDate];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(ReplenishStModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.StoreIncomeNo.text = _cellModel.StoreIncomeNo;
    self.StoreName.text = _cellModel.StoreName;
    self.IncomeDate.text= _cellModel.IncomeDate;
    
    
}
@end
