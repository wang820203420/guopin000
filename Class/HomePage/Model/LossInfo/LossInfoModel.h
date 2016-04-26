//
//  LossInfoModel.h
//  guoping
//
//  Created by zhisu on 15/10/19.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LossInfoModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称

@property(nonatomic,strong)NSString *StoreName;//所属门店

@property(nonatomic,strong)NSNumber *Wastage;//损耗率

@property(nonatomic,strong)NSNumber *RetailPrice;//单价


//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(LossInfoModel *)cellModel;

@end
