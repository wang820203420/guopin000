//
//  StockshModel.m
//  guoping
//
//  Created by zhisu on 15/10/17.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "StockshModel.h"

@implementation StockshModel

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
    
    
    _GoodsName = [dict objectForKey:@"GoodsName"];
    _GoodsCode = [dict objectForKey:@"GoodsCode"];
    _StoreName = [dict objectForKey:@"StoreName"];
    _CurrentInventory = [dict objectForKey:@"CurrentInventory"];
    _GoodsID = [dict objectForKey:@"GoodsID"];
    _UnitName = [dict objectForKey:@"UnitName"];
    
    NSLog(@"%@",dict);
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.GoodsCode forKey:@"GoodsCode"];
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.CurrentInventory forKey:@"CurrentInventory"];
    [dict setObject:self.GoodsID forKey:@"GoodsID"];
    [dict setObject:self.UnitName forKey:@"UnitName"];
    
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(StockshModel *)cellModel
{
    
    return [cellModel dictionary];
    
}


@end
