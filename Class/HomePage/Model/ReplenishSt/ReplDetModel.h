//
//  ReplDetModel.h
//  guoping
//
//  Created by wangqian on 15/11/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplDetModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *StoreIncomeNo;//商品名称

@property(nonatomic,strong)NSString *StoreName;//所属门店

@property(nonatomic,strong)NSString *IncomeDate;//订单时间



//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ReplDetModel *)cellModel;




@end
