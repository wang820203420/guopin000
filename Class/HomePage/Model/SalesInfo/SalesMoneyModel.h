//
//  SalesMoneyModel.h
//  guoping
//
//  Created by zhisu on 15/10/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesMoneyModel : NSObject

@property(nonatomic,strong)NSNumber *Data;//销售信息总金额




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(SalesMoneyModel *)cellModel;




@end
