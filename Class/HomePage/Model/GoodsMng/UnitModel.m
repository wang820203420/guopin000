//
//  UnitModel.m
//  guoping
//
//  Created by zhisu on 16/1/5.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "UnitModel.h"

@implementation UnitModel
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
    
    
    _UnitName= [dict objectForKey:@"UnitName"];
      _GUID= [dict objectForKey:@"GUID"];
    
    
    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.UnitName forKey:@"UnitName"];
    [dict setObject:self.GUID forKey:@"GUID"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(UnitModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
