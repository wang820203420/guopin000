//
//  GoodsMngDetModel.h
//  guoping
//
//  Created by zhisu on 15/10/26.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsMngDetModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称1

@property(nonatomic,strong)NSString *GoodsCode;//商品简码1

@property(nonatomic,strong)NSString *SaleState;//销售状态1

@property(nonatomic,strong)NSNumber *CurrentInventory;//库存1

@property(nonatomic,strong)NSNumber *RetailPrice;//售价1

@property(nonatomic,strong)NSString *UnitName;//重量单位

@property(nonatomic,strong)NSNumber *HandInput;//是否手输金额

@property(nonatomic,strong)NSNumber *Forbidden;//是否上架

@property(nonatomic,strong)NSString *updateUser;//更新用户




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(GoodsMngDetModel *)cellModel;

@end
