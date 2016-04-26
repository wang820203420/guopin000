




//
//  ToGoodsDetCell.m
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ToGoodsDetCell.h"
#import "ToGoodsDetModel.h"


@interface ToGoodsDetCell ()


@property(nonatomic,strong)UILabel *StoreNeedOrderNo;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *CreateTime;



@end
@implementation ToGoodsDetCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ToGoodsDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[ToGoodsDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        self.StoreNeedOrderNo = [[UILabel alloc]init];
        self.StoreNeedOrderNo.frame = CGRectMake(ScreenWidth/1.65, 15, 150, 20);
        self.StoreNeedOrderNo.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.StoreNeedOrderNo];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(13, 70, 100, 10) title:@"所属门店" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label1];
        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(ScreenWidth/1.05, 65, 150, 20);
        self.StoreName.font = [UIFont systemFontOfSize:15];
        //self.StoreName.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.StoreName];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(13,120, 100, 10) title:@"订单时间" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label2];
        self.CreateTime = [[UILabel alloc]init];
        self.CreateTime.frame = CGRectMake(ScreenWidth/1.05,115, ScreenWidth/2.344, 20);
        self.CreateTime.font = [UIFont systemFontOfSize:15];
        //self.NeedGoodsDate.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.CreateTime];
        

        
        
    }
    
    return self;
    
}



-(void)setCellModel:(ToGoodsDetModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.StoreNeedOrderNo.text = _cellModel.StoreNeedOrderNo;
    self.StoreName.text = _cellModel.StoreName;
    self.CreateTime.text= _cellModel.CreateTime;
    
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度－－订单时间
    CGSize size1 = [self.CreateTime.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    CGRect frame1 = self.CreateTime.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.05-size1.width;
    self.CreateTime.frame = frame1;
    
    //动态计算出宽度－－所属门店
    CGSize size2 = [self.StoreName.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    CGRect frame2 = self.StoreName.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.05-size2.width;
    self.StoreName.frame = frame2;
    
    
    //动态计算出宽度--订单号
    CGSize size3 = [self.StoreNeedOrderNo.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    CGRect frame3 = self.StoreNeedOrderNo.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.05-size3.width;
    self.StoreNeedOrderNo.frame = frame3;
    
    
}


@end
