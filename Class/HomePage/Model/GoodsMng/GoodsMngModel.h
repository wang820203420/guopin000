//
//  GoodsMngModel.h
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsMngModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称

@property(nonatomic,strong)NSString *GoodsCode;//商品简码

@property(nonatomic,strong)NSString *SaleState;//销售状态

@property(nonatomic,strong)NSNumber *RetailPrice;//零售价格

@property(nonatomic,strong)NSString *GUID;//零售价格

@property(nonatomic,strong)NSNumber *IsForbidden;//零售状态

@property(nonatomic,strong)NSString *UnitName;//商品重量单位




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(GoodsMngModel *)cellModel;



@end
