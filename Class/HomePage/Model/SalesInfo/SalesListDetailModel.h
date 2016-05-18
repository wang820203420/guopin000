//
//  SalesListDetailModel.h
//  guoping
//
//  Created by zhisu on 15/10/16.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesListDetailModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,retain)NSString *saleno;//订单号

@property(nonatomic,strong)NSString *storename;//所属门店

@property(nonatomic,strong)NSString *saledate;//订单时间

@property(nonatomic,strong)NSString *totalcutoff;//折扣金额

@property(nonatomic,strong)NSString *cutofftype;//会员卡


//@property(nonatomic,strong)NSString *GoodsName;//商品名称
//
//@property(nonatomic,strong)NSString *SalePrice;//售价
//
//@property(nonatomic,strong)NSString *SaleNumber;//数量
//
//@property(nonatomic,strong)NSString *UnitName;//单位
//
//@property(nonatomic,strong)NSString *Amount;//小计金额







//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(SalesListDetailModel *)cellModel;


@end
