//
//  TransferDetailModel.h
//  guoping
//
//  Created by zhisu on 16/6/22.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TransferDetailModel : NSObject

@property (nonatomic,strong) NSString *GoodsName;  //商品名称
@property (nonatomic,strong) NSString *UnitName;   //商品单位
@property (nonatomic,strong) NSNumber *BoxAmount;  //单箱重量
@property (nonatomic,strong) NSNumber *BoxPtare;   //单箱皮重
@property (nonatomic,strong) NSNumber *SendBox;    //调货箱数
@property (nonatomic,strong) NSNumber *SendNumber; //总数量

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;

//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(TransferDetailModel *)cellModel;



@end
