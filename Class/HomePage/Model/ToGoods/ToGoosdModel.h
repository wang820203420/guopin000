//
//  ToGoosdModel.h
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToGoosdModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,strong)NSString *StoreNeedOrderNo;//订单号

@property(nonatomic,strong)NSString *StoreName;//所属门店

@property(nonatomic,strong)NSString *CreateTime;//创建时间

@property(nonatomic,strong)NSString *GUID;

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(ToGoosdModel *)cellModel;



@end
