//
//  LossInfoCell.m
//  guoping
//
//  Created by zhisu on 15/10/19.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "LossInfoCell.h"
#import "LossInfoModel.h"


@interface LossInfoCell ()
{
    
    UILabel *_label3;
}

@property(nonatomic,strong)UILabel *GoodsName;
@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *Wastage;
@property(nonatomic,strong)UILabel *RetailPrice;


@end
@implementation LossInfoCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    LossInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[LossInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        self.GoodsName = [[UILabel alloc]init];
        self.GoodsName.frame = CGRectMake(ScreenWidth/5, 20, 150, 10);
        self.GoodsName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.GoodsName];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"所属店:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(ScreenWidth/5, 45, 150, 10);
        self.StoreName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.StoreName];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"数量:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.Wastage = [[UILabel alloc]init];
       // self.Wastage.backgroundColor = [UIColor redColor];
        self.Wastage.frame = CGRectMake(ScreenWidth/6.6,71, 150, 10);
        self.Wastage.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.Wastage];
        
        

    }
    
    return self;
    
}



-(void)setCellModel:(LossInfoModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.GoodsName.text = _cellModel.GoodsName;
    self.StoreName.text = _cellModel.StoreName;
    self.RetailPrice.text= _cellModel.RetailPrice.stringValue;
    self.Wastage.text =_cellModel.Wastage.stringValue;
    
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
//    
//    //动态计算出宽度
//    CGSize size1 = [self.Wastage.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
//    
//    
//    CGRect frame1 = self.Wastage.frame;
//    frame1.size.width = size1.width;
//    frame1.origin.x =ScreenWidth/8+size1.width;
//    self.Wastage.frame = frame1;
//    

    
}


@end
