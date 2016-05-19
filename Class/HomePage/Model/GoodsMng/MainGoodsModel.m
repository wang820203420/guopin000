//
//  MainGoodsModel.m
//  guoping
//
//  Created by zhisu on 16/1/5.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MainGoodsModel.h"

@implementation MainGoodsModel

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
    
    _GUID= [dict objectForKey:@"GUID"];
    
    _GoodsCode= [dict objectForKey:@"GoodsCode"];
    
    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.GUID forKey:@"GUID"];
    [dict setObject:self.GoodsCode forKey:@"GoodsCode"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(MainGoodsModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
