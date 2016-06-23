//
//  StockCheckModel.m
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "StockCheckModel.h"

@implementation StockCheckModel

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
    _StockNo = [dict objectForKey:@"StockNo"];      //盘点编号
    _StoreName = [dict objectForKey:@"StoreName"];  //盘点门店
    _CreateTime = [dict objectForKey:@"CreateTime"];//盘点时间
    _StaffName = [dict objectForKey:@"StaffName"];  //操作人
}

+ (instancetype)cellModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}


//将cellmodel转换成字典
- (NSDictionary *)dictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.StockNo forKey:@"StockNo"];
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.CreateTime forKey:@"CreateTime"];
    [dict setObject:self.StaffName forKey:@"StaffName"];
    
    return dict;
}

+ (NSDictionary *)dictionaryWithCellModel:(StockCheckModel *)cellModel
{
    return [cellModel dictionary];
}


@end
