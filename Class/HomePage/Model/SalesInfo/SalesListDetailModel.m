//
//  SalesListDetailModel.m
//  guoping
//
//  Created by zhisu on 15/10/16.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SalesListDetailModel.h"

@implementation SalesListDetailModel

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


+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDictionary:dict];
}

-(void)setCellDataWithDictionary:(NSDictionary *)dict
{
    
    
    _saleno = [dict objectForKey:@"SaleNo"];
    _storename = [dict objectForKey:@"StoreName"];
    _saledate = [dict objectForKey:@"SaleDate"];
    _totalcutoff = [dict objectForKey:@"TotalCutOff"];
    _memberID = [dict objectForKey:@"MemberID"];
//    _GoodsName = [dict objectForKey:@"GoodsName"];
//    _SalePrice = [dict objectForKey:@"SalePrice"];
//    _SaleNumber = [dict objectForKey:@"SaleNumber"];
//    _UnitName = [dict objectForKey:@"UnitName"];
//    _Amount = [dict objectForKey:@"Amount"];
    
    NSLog(@"%@",dict);
    
}



//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.saleno forKey:@"SaleNo"];
    [dict setObject:self.storename forKey:@"StoreName"];
    [dict setObject:self.saledate forKey:@"SaleDate"];
    [dict setObject:self.totalcutoff forKey:@"TotalCutOff"];
    [dict setObject:self.memberID forKey:@"MemberID"];
//    [dict setObject:self.GoodsName forKey:@"GoodsName"];
//    [dict setObject:self.SalePrice forKey:@"SalePrice"];
//    [dict setObject:self.SaleNumber forKey:@"SaleNumber"];
//    [dict setObject:self.UnitName forKey:@"UnitName"];
//    [dict setObject:self.Amount forKey:@"Amount"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(SalesListDetailModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
