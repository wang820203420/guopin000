//
//  TransferModel.m
//  guoping
//
//  Created by zhisu on 16/6/20.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferModel.h"

@implementation TransferModel

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
    _OrderNo = [dict objectForKey:@"OrderNo"];
    _StoreName = [dict objectForKey:@"StoreName"];
    _TargetStoreName = [dict objectForKey:@"TargetStoreName"];
    _SendDate = [dict objectForKey:@"SendDate"];
    _StaffName = [dict objectForKey:@"StaffName"];
    _OrderId = [dict objectForKey:@"GUID"];
}

+ (instancetype)cellModelWithDictionary:(NSDictionary *)dict
{
    return [[self alloc]initWithDictionary:dict];
}


//将cellmodel转换成字典
- (NSDictionary *)dictionary
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.OrderNo forKey:@"OrderNo"];
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.TargetStoreName forKey:@"TargetStoreName"];
    [dict setObject:self.SendDate forKey:@"SendDate"];
    [dict setObject:self.StaffName forKey:@"StaffName"];
    [dict setObject:self.OrderId forKey:@"GUID"];
    
    return dict;
}

+ (NSDictionary *)dictionaryWithCellModel:(TransferModel *)cellModel
{
    return [cellModel dictionary];
}


@end
