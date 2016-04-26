//
//  MemberDetailCell.m
//  guoping
//
//  Created by zhisu on 16/4/26.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberDetailCell.h"
#import "MemberModel.h"


@interface MemberDetailCell ()
{
    
    NSString *data;
}

@property(nonatomic,strong)UILabel *staffName;//会员姓名
@property(nonatomic,strong)UILabel *sex;//性别
@property(nonatomic,strong)UILabel *mobile;//手机号
@property(nonatomic,strong)UILabel *memberId;//会员卡号
@property(nonatomic,strong)UILabel *cardType;//会员类型
@property(nonatomic,strong)UILabel *amount;//账户余额
@property(nonatomic,strong)UILabel *points;//账户积分
@property(nonatomic,strong)UILabel *sourceID;//办卡地点
@property(nonatomic,strong)UILabel *createTime;//办卡时间
@property(nonatomic,strong)UILabel *createUser;//办理人



@end

@implementation MemberDetailCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    MemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[MemberDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
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
        self.cardType = [[UILabel alloc]init];
        self.cardType.frame = CGRectMake(85, 20, 150, 10);
        self.cardType.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.cardType];
        
        
        
        UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(10, 45, 200, 10) title:@"会员姓名:" textAlignment:NSTextAlignmentLeft];
        label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label1];
        self.staffName = [[UILabel alloc]init];
        self.staffName.frame = CGRectMake(85, 45, 150, 10);
        self.staffName.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.staffName];
        
        
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 70, 200, 10) title:@"手机号码:" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        self.mobile = [[UILabel alloc]init];
        self.mobile.frame = CGRectMake(85,70, 150, 10);
        self.mobile.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:self.mobile];
        
        
        
        
        //线条
        CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage];
        
        //线条
        CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
        UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
        [self.contentView addSubview:Lowimage1];
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(MemberModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.staffName.text = _cellModel.StaffName;
    self.sex.text = _cellModel.Sex;
    self.SaleState.text= _cellModel.SaleState;
    self.UnitName.text = _cellModel.UnitName;
    self.UnitName1.text = [NSString stringWithFormat:@"元/%@",_cellModel.UnitName];
    
    self.CurrentInventory.text = [NSString stringWithFormat:@"%.2f",_cellModel.CurrentInventory.doubleValue];
    
    self.RetailPrice.text = [NSString stringWithFormat:@"%.2f",_cellModel.RetailPrice.doubleValue];
    
    
    
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size1 = [self.CurrentInventory.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.CurrentInventory.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.09-size1.width;
    
    self.CurrentInventory.frame = frame1;
    
    
    CGRect frame4 = self.UnitName.frame;
    //frame4.size.width = size1.width;
    frame4.origin.x =ScreenWidth/1.09;
    
    self.UnitName.frame = frame4;
    
    
    
    //销售的
    
    NSDictionary *attribute1 = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //动态计算出宽度
    CGSize size2 = [self.RetailPrice.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute1 context:nil].size;
    
    
    CGRect frame2 = self.RetailPrice.frame;
    frame2.size.width = size2.width+20;
    frame2.origin.x =ScreenWidth/1.2-size2.width;
    self.RetailPrice.frame = frame2;
    
    
    CGRect frame3 = self.UnitName1.frame;
    //frame3.size.width = size1.width;
    frame3.origin.x =ScreenWidth/1.18;
    self.UnitName1.frame = frame3;
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
