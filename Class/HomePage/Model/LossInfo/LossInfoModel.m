//
//  LossInfoModel.m
//  guoping
//
//  Created by zhisu on 15/10/19.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "LossInfoModel.h"

@implementation LossInfoModel


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
    _StoreName = [dict objectForKey:@"StoreName"];
    _Wastage = [dict objectForKey:@"Wastage"];
    
    if ([_RetailPrice isKindOfClass:[NSNull class]]) {
        
           _RetailPrice = [dict objectForKey:@"RetailPrice"];
        
    }
    
    
    NSLog(@"%@",dict);
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.Wastage forKey:@"Wastage"];
    [dict setObject:self.RetailPrice forKey:@"RetailPrice"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(LossInfoModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
