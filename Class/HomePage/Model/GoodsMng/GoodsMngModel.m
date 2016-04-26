


//
//  GoodsMngModel.m
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "GoodsMngModel.h"

@implementation GoodsMngModel

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
    _RetailPrice = [dict objectForKey:@"RetailPrice"];
    
    
        _UnitName = [dict objectForKey:@"UnitName"];
        
    
    
   
      _GUID = [dict objectForKey:@"GUID"];
    

         _IsForbidden = [dict objectForKey:@"IsForbidden"];

   
    

   
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.GoodsCode forKey:@"GoodsCode"];
    [dict setObject:self.SaleState forKey:@"SaleState"];
    [dict setObject:self.RetailPrice forKey:@"RetailPrice"];
    [dict setObject:self.UnitName forKey:@"UnitName"];
    [dict setObject:self.GUID forKey:@"GUID"];
     [dict setObject:self.IsForbidden forKey:@"IsForbidden"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(GoodsMngModel *)cellModel
{
    
    return [cellModel dictionary];
    
}



@end
