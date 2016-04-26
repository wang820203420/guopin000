//
//  ReplenishStModel.h
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplenishStModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *StoreIncomeNo;//商品名称

@property(nonatomic,strong)NSString *StoreName;//水果一号店

@property(nonatomic,strong)NSString *IncomeDate;//订单时间

@property(nonatomic,strong)NSString *GUID;//订单时间



//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ReplenishStModel *)cellModel;



@end
