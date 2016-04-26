//
//  SalesInformationModel.h
//  guoping
//
//  Created by zhisu on 15/10/15.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesInformationModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,retain)NSString *saleno;//订单编号

@property(nonatomic,strong)NSString *storename;//店铺地址

@property(nonatomic,strong)NSNumber *totalmoney;//金钱

@property(nonatomic,strong)NSString *saledate;//出售时间

@property(nonatomic,strong)NSString *GUID;
@property(nonatomic,strong)NSString *StoreID;

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(SalesInformationModel *)cellModel;

@end
