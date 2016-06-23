//
//  StockCheckModel.h
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockCheckModel : NSObject

@property(nonatomic,strong)NSString *StockNo;       //盘点编号
@property(nonatomic,strong)NSString *StoreName;     //盘点门店
@property(nonatomic,strong)NSString *CreateTime;    //盘点时间
@property(nonatomic,strong)NSString *StaffName;     //操作人

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(StockCheckModel *)cellModel;

@end
