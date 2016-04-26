//
//  ProvincesModel.h
//  guoping
//
//  Created by zhisu on 16/1/7.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvincesModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *REGION_CODE;//省编码

@property(nonatomic,strong)NSString *REGION_NAME;//省市区





//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ProvincesModel *)cellModel;


@end
