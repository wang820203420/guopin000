//
//  StockDetModel.h
//  guoping
//
//  Created by zhisu on 15/11/19.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockDetModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称

@property(nonatomic,strong)NSString *GoodsCode;//商品简码

@property(nonatomic,strong)NSNumber *CurrentInventory;//库存

@property(nonatomic,strong)NSNumber *RetailPrice;//售价

@property(nonatomic,strong)NSString *StoreName;//所属门店

@property(nonatomic,strong)NSString *UnitName;//重量单位




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(StockDetModel *)cellModel;

@end
