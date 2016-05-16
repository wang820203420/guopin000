//
//  SalesInformationModel.m
//  guoping
//
//  Created by zhisu on 15/10/15.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SalesInformationModel.h"

@implementation SalesInformationModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}


//初始化模型数据
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setCellDataWithDictionary:dict];
    }
    return self;
    
}


+(instancetype)cellModelWithDictionary:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDictionary:dict];
}

//从字典中取值设置cell的数据
-(void)setCellDataWithDictionary:(NSDictionary *)dict
{
    
    
    _saleno = [dict objectForKey:@"SaleNo"];
    _storename = [dict objectForKey:@"StoreName"];
    
    _totalmoney = [dict objectForKey:@"TotalMoney"];
#pragma mark  ----20160512
    _totalCutOff = [dict objectForKey:@"TotalCutOff"];
    
    _saledate = [dict objectForKey:@"SaleDate"];
    
    _GUID = [dict objectForKey:@"GUID"];
    
    _StoreID = [dict objectForKey:@"StoreID"];
    
  
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.saleno forKey:@"SaleNo"];
    [dict setObject:self.storename forKey:@"StoreName"];
    [dict setObject:self.totalmoney forKey:@"TotalMoney"];
    [dict setObject:self.totalCutOff forKey:@"TotalCutOff"];
    
    [dict setObject:self.saledate forKey:@"SaleDate"];
    [dict setObject:self.GUID forKey:@"GUID"];
    [dict setObject:self.StoreID forKey:@"StoreID"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(SalesInformationModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
