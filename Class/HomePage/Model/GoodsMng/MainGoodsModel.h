//
//  MainGoodsModel.h
//  guoping
//
//  Created by zhisu on 16/1/5.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainGoodsModel : NSObject
@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *GoodsName;//商品名称1
@property(nonatomic,strong)NSString *GUID;//商品guid
@property(nonatomic,strong)NSString *GoodsCode;//商品guid






//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(MainGoodsModel *)cellModel;

@end
