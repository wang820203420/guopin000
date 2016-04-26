//
//  ToGoodsCreatUserModel.h
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToGoodsCreatUserModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *CreateUser;//制单人


//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ToGoodsCreatUserModel *)cellModel;



@end
