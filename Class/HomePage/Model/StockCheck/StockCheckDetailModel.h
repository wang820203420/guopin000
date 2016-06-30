//
//  StockCheckDetailModel.h
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockCheckDetailModel : NSObject

@property (nonatomic, strong) NSString *GoodsName;    //商品名称
@property (nonatomic, strong) NSString *UnitName;     //商品单位
@property (nonatomic, strong) NSNumber *BoxNum;       //盘点箱数
@property (nonatomic, strong) NSNumber *TotalAmount;  //盘点重量
@property (nonatomic, strong) NSNumber *DiffAmount;   //库存差异


//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(StockCheckDetailModel *)cellModel;


@end
