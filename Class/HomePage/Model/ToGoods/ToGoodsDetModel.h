//
//  ToGoodsDetModel.h
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToGoodsDetModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *StoreNeedOrderNo;//订单号

@property(nonatomic,strong)NSString *StoreName;//所属门店

@property(nonatomic,strong)NSString *CreateTime;//进货时间



//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ToGoodsDetModel *)cellModel;




@end
