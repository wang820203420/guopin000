//
//  StockshModel.h
//  guoping
//
//  Created by zhisu on 15/10/17.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockshModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称

@property(nonatomic,strong)NSString *GoodsCode;//商品编码

@property(nonatomic,strong)NSString *StoreName;//所属门店

@property(nonatomic,strong)NSNumber *CurrentInventory;//当前库存

@property(nonatomic,strong)NSString *GoodsID;//商品id

@property(nonatomic,strong)NSString *UnitName;//商品重量单位


//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(StockshModel *)cellModel;

@end
