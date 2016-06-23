//
//  StockCheckDetailModel.m
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "StockCheckDetailModel.h"

@implementation StockCheckDetailModel

//初始化模型数据
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setCellDataWithDictionary:dict];
    }
    return self;
}

- (void)setCellDataWithDictionary:(NSDictionary *)dict
{
    _GoodsName = [dict objectForKey:@"GoodsName"];    //商品名称
    _UnitName = [dict objectForKey:@"UnitName"];      //商品单位
    _BoxNum = [dict objectForKey:@"BoxNum"];          //盘点箱数
    _TotalAmount = [dict objectForKey:@"TotalAmount"];//盘点重量
    _DiffAmount = [dict objectForKey:@"DiffAmount"];  //库存差异
}

+ (instancetype)cellModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}

//将cellmodel转换成字典
- (NSDictionary *)dictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.UnitName forKey:@"UnitName"];
    [dict setObject:self.BoxNum forKey:@"BoxNum"];
    [dict setObject:self.TotalAmount forKey:@"TotalAmount"];
    [dict setObject:self.DiffAmount forKey:@"DiffAmount"];
    
    return dict;
}

+ (NSDictionary *)dictionaryWithCellModel:(StockCheckDetailModel *)cellModel
{
    return [cellModel dictionary];
}


@end
