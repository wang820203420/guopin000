//
//  HomePageModel.h
//  guoping
//
//  Created by zhisu on 15/10/14.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomePageModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSNumber *SaleAmount;//当日销售

@property(nonatomic,strong)NSNumber *SaleCount;//销售笔数


//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(HomePageModel *)cellModel;

@end
