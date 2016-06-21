//
//  TransferModel.h
//  guoping
//
//  Created by zhisu on 16/6/20.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferModel : NSObject

@property(nonatomic,strong)NSString *OrderNo;         //调货单号
@property(nonatomic,strong)NSNumber *StoreName;       //调货门店
@property(nonatomic,strong)NSNumber *TargetStoreName; //收货门店
@property(nonatomic,strong)NSNumber *SendDate;        //调货时间
@property(nonatomic,strong)NSNumber *StaffName;       //操作人

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(TransferModel *)cellModel;

@end
