//
//  SalesListDetailTwoModel.h
//  guoping
//
//  Created by zhisu on 15/10/16.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesListDetailTwoModel : NSObject

@property(nonatomic,strong)NSString *GoodsName;//商品名称

@property(nonatomic,strong)NSNumber *SalePrice;//售价

@property(nonatomic,strong)NSNumber *SaleNumber;//数量

@property(nonatomic,strong)NSString *UnitName;//单位

@property(nonatomic,strong)NSNumber *Amount;//小计金额



//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(SalesListDetailTwoModel *)cellModel;





@end
