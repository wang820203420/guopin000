//
//  GoodsClassModel.m
//  guoping
//
//  Created by zhisu on 15/12/31.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "GoodsClassModel.h"

@implementation GoodsClassModel



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
    
    
    _GoodsTypeName= [dict objectForKey:@"GoodsTypeName"];
    
    _GUID= [dict objectForKey:@"GUID"];
    
    _TypeNo= [dict objectForKey:@"TypeNo"];
    
    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GUID forKey:@"GUID"];
    [dict setObject:self.GoodsTypeName forKey:@"GoodsTypeName"];
    [dict setObject:self.TypeNo forKey:@"TypeNo"];

    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(GoodsClassModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
