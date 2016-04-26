//
//  AllStoreModel.h
//  guoping
//
//  Created by zhisu on 15/10/30.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AllStoreModel : NSObject


@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,retain)NSString *StoreName;//店铺名

@property(nonatomic,strong)NSString *EnterpriseID;//企业ID

@property(nonatomic,strong)NSString *GUID;//店铺id

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(AllStoreModel *)cellModel;

@end
