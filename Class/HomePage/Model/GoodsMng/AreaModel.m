
//
//  AreaModel.m
//  guoping
//
//  Created by zhisu on 16/1/7.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "AreaModel.h"

@implementation AreaModel
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
    
    
    _REGION_CODE = [dict objectForKey:@"REGION_CODE"];
    _REGION_NAME = [dict objectForKey:@"REGION_NAME"];
    
    
    
    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.REGION_CODE forKey:@"REGION_CODE"];
    [dict setObject:self.REGION_NAME forKey:@"REGION_NAME"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(AreaModel *)cellModel
{
    
    return [cellModel dictionary];
    
}
@end
