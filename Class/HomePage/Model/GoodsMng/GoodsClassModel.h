//
//  GoodsClassModel.h
//  guoping
//
//  Created by zhisu on 15/12/31.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsClassModel : NSObject
@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsTypeName;//商品名称1
@property(nonatomic,strong)NSString *GUID;//商品名称1




//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(GoodsClassModel *)cellModel;

@end
