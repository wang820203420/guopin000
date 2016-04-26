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
@property(nonatomic,strong)UILabel *staffName;//会员姓名
@property(nonatomic,strong)UILabel *mobile;//手机号码
@property(nonatomic,strong)UILabel *discount;//折扣
@property(nonatomic,strong)UILabel *UnitName;//人民币符号



@end

@implementation MemberCell



+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 100, 10) title:@"会员卡类型:" textAlignment:NSTextAlignmentLeft];
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
        self.staffName = [[UILabel alloc]init];
        self.staffName.frame = CGRectMake(ScreenWidth/3.9, 45, 150, 10);
        self.staffName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.staffName];
        
        
        
        
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
        
        
        //售价单位
        self.UnitName = [[UILabel alloc]init];
        self.UnitName.frame = CGRectMake(ScreenWidth/1.13,38, 40, 20);
        self.UnitName.font = [UIFont systemFontOfSize:16.5];
        self.UnitName.textColor = [UIColor colorWithRed:74.0/255.0 green:150.0/255.0 blue:62.0/255.0 alpha:1];
        [self.contentView addSubview:self.UnitName];
        
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(MemberModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.cardTypeName.text = _cellModel.CardTypeName;
    self.staffName.text = _cellModel.StaffName;
    self.mobile.text= _cellModel.Mobile;
    self.discount.text = [NSString stringWithFormat:@"%.2f元/",_cellModel.Discount.doubleValue];
    self.UnitName.text = _cellModel.UnitName;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.5]};
    
    //动态计算出宽度
    CGSize size1 = [self.discount.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.discount.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.15-size1.width;
    
    self.discount.frame = frame1;
    
    //商品zhon
    CGRect frame2 = self.UnitName.frame;
    //frame2.size.width = size1.width;
    frame2.origin.x =ScreenWidth/1.15-size1.width+size1.width;
    
    self.UnitName.frame = frame2;
    
    
    
}






- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
