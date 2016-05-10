//
//  MemberModel.h
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,retain)NSString *StaffName;//办理人

@property(nonatomic,strong)NSString *Sex;//性别

@property(nonatomic,strong)NSString *Mobile;//手机号

@property(nonatomic,strong)NSString *Name;//会员

@property(nonatomic,strong)NSString *CardType;//会员类型

@property(nonatomic,strong)NSString *CardTypeName;//会员卡名

@property(nonatomic,strong)NSNumber *Amount;//账户余额

@property(nonatomic,strong)NSNumber *Points;//账户积分

@property(nonatomic,strong)NSString *StoreName;//办卡地点

@property(nonatomic,strong)NSString *CreateTime;//办卡时间

@property(nonatomic,strong)NSString *MemberCode;//会员卡号

@property(nonatomic,strong)NSNumber *Discount;//账户余额






@property(nonatomic,strong)NSString *GUID;//EnterpriseID 企业ID
@property(nonatomic,strong)NSString *StoreID;//店铺



@property(nonatomic,strong)NSString *UnitName;





//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(MemberModel *)cellModel;







@end
