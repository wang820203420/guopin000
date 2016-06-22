//
//  TransferDetailModel.m
//  guoping
//
//  Created by zhisu on 16/6/22.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferDetailModel.h"

@implementation TransferDetailModel

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
    _GoodsName = [dict objectForKey:@"GoodsName"];
    _UnitName = [dict objectForKey:@"UnitName"];
    _BoxAmount = [dict objectForKey:@"BoxAmount"];
    _BoxPtare = [dict objectForKey:@"BoxPtare"];
    _SendBox = [dict objectForKey:@"SendBox"];
    _SendNumber = [dict objectForKey:@"SendNumber"];
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
    [dict setObject:self.BoxAmount forKey:@"BoxAmount"];
    [dict setObject:self.BoxPtare forKey:@"BoxPtare"];
    [dict setObject:self.SendBox forKey:@"SendBox"];
    [dict setObject:self.SendNumber forKey:@"SendNumber"];
    
    return dict;
}

+ (NSDictionary *)dictionaryWithCellModel:(TransferDetailModel *)cellModel
{
    return [cellModel dictionary];
}


@end
