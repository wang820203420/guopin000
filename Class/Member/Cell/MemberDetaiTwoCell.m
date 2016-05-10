//
//  MemberDetaiTwoCell.m
//  guoping
//
//  Created by zhisu on 16/5/3.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberDetaiTwoCell.h"
#import "MemberModel.h"



@interface MemberDetaiTwoCell ()



@property(nonatomic,strong)UILabel *staffName;//会员姓名
@property(nonatomic,strong)UILabel *sex;//性别
@property(nonatomic,strong)UILabel *mobile;//手机号
@property(nonatomic,strong)UILabel *name;//会员卡号
@property(nonatomic,strong)UILabel *cardType;//会员类型
@property(nonatomic,strong)UILabel *amount;//账户余额
@property(nonatomic,strong)UILabel *points;//账户积分
@property(nonatomic,strong)UILabel *storeName;//办卡地点
@property(nonatomic,strong)UILabel *createTime;//办卡时间
@property(nonatomic,strong)UILabel *createUser;//办理人



@end







@implementation MemberDetaiTwoCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    MemberDetaiTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[MemberDetaiTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    return cell;
    
    
}





-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        
    }
    
    return self;
    
}




-(void)setCellModel:(MemberModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.staffName.text = _cellModel.StaffName;
    self.name.text = _cellModel.Name;
    self.sex.text = _cellModel.Sex;
    self.mobile.text = _cellModel.Mobile;
    self.cardType.text = _cellModel.CardTypeName;
    self.amount.text = [NSString stringWithFormat:@"%@", _cellModel.Amount];
    self.points.text= [NSString stringWithFormat:@"%@", _cellModel.Points];
    self.createTime.text = _cellModel.CreateTime;
    
    [self calculatePosition];
    
    
}


- (void)calculatePosition
{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    
    //会员姓名
    
    
    //动态计算出宽度
    CGSize size = [self.staffName.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame = self.staffName.frame;
    frame.size.width = size.width;
    frame.origin.x =ScreenWidth/1.05-size.width;
    self.staffName.frame = frame;
    
    //性别
    
    
    CGSize size1 = [self.sex.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = self.sex.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.05-size1.width;
    self.sex.frame = frame1;
    
    //手机号
    
    
    CGSize size2 = [self.mobile.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame2 = self.mobile.frame;
    frame2.size.width = size2.width;
    frame2.origin.x =ScreenWidth/1.05-size2.width;
    self.mobile.frame = frame2;
    
    //会员卡号
    
    
    CGSize size3 = [self.name.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame3 = self.name.frame;
    frame3.size.width = size3.width;
    frame3.origin.x =ScreenWidth/1.05-size3.width;
    self.name.frame = frame3;
    
    //会员类型
    
    
    
    CGSize size4 = [self.cardType.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame4 = self.cardType.frame;
    frame4.size.width = size4.width;
    frame4.origin.x =ScreenWidth/1.05-size4.width;
    self.cardType.frame = frame4;
    
    //账户余额
    
    
    
    CGSize size5 = [self.amount.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame5 = self.amount.frame;
    frame5.size.width = size5.width;
    frame5.origin.x =ScreenWidth/1.05-size5.width;
    self.amount.frame = frame5;
    
    //账户积分
    
    
    
    CGSize size6 = [self.points.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame6 = self.points.frame;
    frame6.size.width = size6.width;
    frame6.origin.x =ScreenWidth/1.05-size6.width;
    self.points.frame = frame6;
    
    //办卡地点
    
    
    CGSize size7 = [self.storeName.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame7 = self.storeName.frame;
    frame7.size.width = size7.width;
    frame7.origin.x =ScreenWidth/1.05-size7.width;
    self.storeName.frame = frame7;
    
    //办卡时间
    
    
    CGSize size8 = [self.createTime.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame8 = self.createTime.frame;
    frame8.size.width = size8.width;
    frame8.origin.x =ScreenWidth/1.05-size8.width;
    self.createTime.frame = frame8;
    
    //办理人
    
    
    CGSize size9 = [self.createUser.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame9 = self.createUser.frame;
    frame9.size.width = size9.width;
    frame9.origin.x =ScreenWidth/1.05-size9.width;
    self.createUser.frame = frame9;
    
    
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
