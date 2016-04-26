//
//  ToGoodsDetailModel.h
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToGoodsDetailModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称

@property(nonatomic,strong)NSNumber *NeedNumber;//进货量

@property(nonatomic,strong)NSNumber *CurrentInventory;//库存

@property(nonatomic,strong)NSNumber *CurrentCheckInventory;//核定

@property(nonatomic,strong)NSString *UnitName;//核定

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ToGoodsDetailModel *)cellModel;



@end
