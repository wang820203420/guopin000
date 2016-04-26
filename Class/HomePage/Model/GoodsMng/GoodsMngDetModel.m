//
//  GoodsMngDetModel.m
//  guoping
//
//  Created by zhisu on 15/10/26.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "GoodsMngDetModel.h"

@implementation GoodsMngDetModel

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
    
    
    _GoodsName= [dict objectForKey:@"GoodsName"];
    
    
    
    _GoodsCode = [dict objectForKey:@"GoodsCode"];
    

       _SaleState = [dict objectForKey:@"SaleState"];
    
    
    
 

           _CurrentInventory = [dict objectForKey:@"CurrentInventory"];
    
 

        _RetailPrice = [dict objectForKey:@"RetailPrice"];
        
        
    
  

          _UnitName = [dict objectForKey:@"UnitName"];
    
        
    
    

    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.GoodsCode forKey:@"GoodsCode"];
    [dict setObject:self.SaleState forKey:@"SaleState"];
    [dict setObject:self.CurrentInventory forKey:@"CurrentInventory"];
    [dict setObject:self.RetailPrice forKey:@"RetailPrice"];
    [dict setObject:self.UnitName forKey:@"UnitName"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(GoodsMngDetModel *)cellModel
{
    
    return [cellModel dictionary];
    
}



@end
