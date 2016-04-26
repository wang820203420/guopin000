//
//  CityModel.h
//  guoping
//
//  Created by zhisu on 16/1/7.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CityModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *REGION_CODE;//编码

@property(nonatomic,strong)NSString *REGION_NAME;//市





//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(CityModel *)cellModel;


@end
