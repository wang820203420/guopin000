//
//  SeNumberModel.h
//  guoping
//
//  Created by zhisu on 16/1/18.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeNumberModel : NSObject
@property(nonatomic,strong)NSNumber *Data;//销售笔数




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(SeNumberModel *)cellModel;


@end
