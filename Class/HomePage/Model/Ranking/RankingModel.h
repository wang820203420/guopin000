//
//  RankingModel.h
//  guoping
//
//  Created by zhisu on 15/10/27.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *StoreName;//水果店名

@property(nonatomic,strong)NSNumber *TotalSaleMoney;//销售总额



//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(RankingModel *)cellModel;



@end
