//
//  MemberCell.m
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberCell.h"
#import "MemberModel.h"

@interface MemberCell ()


@property(nonatomic,strong)UILabel *cardTypeName;//会员卡类型
@property(nonatomic,strong)UILabel *name;//会员姓名
@property(nonatomic,strong)UILabel *mobile;//手机号码
@property(nonatomic,strong)UILabel *discount;//折扣
@property(nonatomic,strong)UILabel *UnitName;//人民币符号



@end

@implementation MemberCell



+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"popCellID";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 100, 10) title:@"会员类型:" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label];
        self.cardTypeName = [[UILabel alloc]init];
        self.cardTypeName.frame = CGRectMake(ScreenWidth/3.9, 20, 150, 10);
        self.cardTypeName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.cardTypeName];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 100, 10) title:@"会员姓名:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.name = [[UILabel alloc]init];
        self.name.frame = CGRectMake(ScreenWidth/3.9, 45, 150, 10);
        self.name.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.name];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 100, 10) title:@"手机号码:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.mobile = [[UILabel alloc]init];
        self.mobile.frame = CGRectMake(ScreenWidth/3.9,70, 150, 10);
        self.mobile.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.mobile];
        
        
        
        self.discount = [[UILabel alloc]init];
        self.discount.frame = CGRectMake(ScreenWidth/1.15,38, 100, 20);
        self.discount.font = [UIFont systemFontOfSize:16.5];
        self.discount.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        [self.contentView addSubview:self.discount];
        
    
        
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(MemberModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.cardTypeName.text = _cellModel.CardTypeName;
    self.name.text = _cellModel.Name;
    self.mobile.text= _cellModel.Mobile;
//    self.discount.text = [NSString stringWithFormat:@"%.2f元",_cellModel.Discount.doubleValue];
    
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.5]};
//    
//    //动态计算出宽度
//    CGSize size1 = [self.discount.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
//    
//    
//    CGRect frame1 = self.discount.frame;
//    frame1.size.width = size1.width;
//    frame1.origin.x =ScreenWidth/1.15-size1.width;
//    
//    self.discount.frame = frame1;
//    
//    //商品zhon
//    CGRect frame2 = self.UnitName.frame;
//    //frame2.size.width = size1.width;
//    frame2.origin.x =ScreenWidth/1.15-size1.width+size1.width;
//    
//    self.UnitName.frame = frame2;
    
    
    
}






- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
