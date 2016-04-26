//
//  ReplOrderCell.m
//  guoping
//
//  Created by wangqian on 15/11/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ReplOrderCell.h"
#import "ReplOrderModel.h"

@interface ReplOrderCell ()


@property(nonatomic,strong)UILabel *GoodsTypeName;
@property(nonatomic,strong)UILabel *ShouldIncome;
@property(nonatomic,strong)UILabel *LossIncome;
@property(nonatomic,strong)UILabel *RealIncome;
@property(nonatomic,strong)UILabel *Origin;



@end
@implementation ReplOrderCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ReplOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[ReplOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
        
        self.GoodsTypeName = [[UILabel alloc]init];
        self.GoodsTypeName.frame = CGRectMake(23, 12, 150, 20);
        self.GoodsTypeName.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.GoodsTypeName];
        
        
        
        
        self.ShouldIncome = [[UILabel alloc]init];
        //self.ShouldIncome.backgroundColor = [UIColor redColor];
        self.ShouldIncome.frame = CGRectMake(ScreenWidth/2.6, 12, 50, 20);
        self.ShouldIncome.font = [UIFont systemFontOfSize:15];
        self.ShouldIncome.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:self.ShouldIncome];
        
        
        
        
        self.LossIncome = [[UILabel alloc]init];
        self.LossIncome.frame = CGRectMake(ScreenWidth/1.8,12, 200, 20);
        self.LossIncome.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.LossIncome];
        
        
        
        self.RealIncome = [[UILabel alloc]init];
          //self.RealIncome.backgroundColor = [UIColor redColor];
        self.RealIncome.frame = CGRectMake(ScreenWidth/1.3,12, 200, 20);
        self.RealIncome.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.RealIncome];
        
        
        
        self.Origin = [[UILabel alloc]init];
        self.Origin.frame = CGRectMake(ScreenWidth/1.2,12, 80, 20);
        self.Origin.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.Origin];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(ReplOrderModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsTypeName.text = _cellModel.GoodsTypeName;
    self.ShouldIncome.text = _cellModel.ShouldIncome.stringValue;
    self.LossIncome.text= _cellModel.LossIncome.stringValue;
    self.RealIncome.text = _cellModel.RealIncome.stringValue;
    self.Origin.text= _cellModel.Origin;
    
    
    
    //应收
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size1 = [ self.ShouldIncome.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 =  self.ShouldIncome.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/2.6-size1.width;
    
    self.ShouldIncome.frame = frame1;
    
    
    //损耗
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size2 = [ self.LossIncome.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 =  self.LossIncome.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.8-size2.width;
    
    self.LossIncome.frame = frame2;
    

    //实收
    
    NSDictionary *attribute2 = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size3 = [ self.RealIncome.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute2 context:nil].size;
    
    
    CGRect frame3 =  self.RealIncome.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.3-size3.width;
    
    self.RealIncome.frame = frame3;
    
    
    
    

}
@end
