//
//  ReplCreatModel.h
//  guoping
//
//  Created by wangqian on 15/11/29.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReplCreatModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *CreateUser;//创建人




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ReplCreatModel *)cellModel;



@end
