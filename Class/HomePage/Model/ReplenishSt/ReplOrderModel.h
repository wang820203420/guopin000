//
//  ReplOrderModel.h
//  guoping
//
//  Created by wangqian on 15/11/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplOrderModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsTypeName;//商品名称

@property(nonatomic,strong)NSNumber *ShouldIncome;//应收

@property(nonatomic,strong)NSNumber *LossIncome;//损耗

@property(nonatomic,strong)NSNumber *RealIncome;//实收

@property(nonatomic,strong)NSString *Origin;//产地




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ReplOrderModel *)cellModel;



@end
