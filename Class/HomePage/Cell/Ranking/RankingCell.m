//
//  RankingCell.m
//  guoping
//
//  Created by zhisu on 15/10/27.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "RankingCell.h"
#import "RankingModel.h"


@interface RankingCell ()
{
    UILabel *_label2;
}

@property(nonatomic,strong)UILabel *StoreName;
@property(nonatomic,strong)UILabel *TotalSaleMoney;


@end
@implementation RankingCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    RankingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[RankingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        

        
    
        
      
        self.StoreName = [[UILabel alloc]init];
        self.StoreName.frame = CGRectMake(80, 15, 150, 10);
        self.StoreName.font = [UIFont systemFontOfSize:14];
        
    
        [self.contentView addSubview:self.StoreName];
        
        
        
        
      _label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.06, 15, 50, 10) title:@"¥" textAlignment:NSTextAlignmentLeft];
        _label2.textColor = [UIColor colorWithRed:72.0/255.0 green:158.0/255.0 blue:27.0/255.0 alpha:1];
        _label2.font = [UIFont systemFontOfSize:15];
       // _label2.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_label2];
        self.TotalSaleMoney = [[UILabel alloc]init];
        self.TotalSaleMoney.frame = CGRectMake(ScreenWidth/1.03,15, 150, 20);
        self.TotalSaleMoney.font = [UIFont systemFontOfSize:14];
        //self.TotalSaleMoney.backgroundColor = [UIColor redColor];
        self.TotalSaleMoney.textColor = [UIColor colorWithRed:72.0/255.0 green:158.0/255.0 blue:27.0/255.0 alpha:1];
        [self.contentView addSubview:self.TotalSaleMoney];
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(RankingModel *)cellModel
{
    
    _cellModel = cellModel;
    
    
    self.StoreName.text = _cellModel.StoreName;
    self.TotalSaleMoney.text= _cellModel.TotalSaleMoney.stringValue;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14]};
    
    //动态计算出宽度
    CGSize size1 = [self.TotalSaleMoney.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.TotalSaleMoney.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.03-size1.width;
    
    self.TotalSaleMoney.frame = frame1;
    
    
    CGRect frame2 = self.TotalSaleMoney.frame;
     frame2.size.width = size1.width;
    frame2.origin.x =ScreenWidth/1.06-size1.width;
    
    _label2.frame = frame2;
    
}

@end
