//
//  ReplCreatModel.m
//  guoping
//
//  Created by wangqian on 15/11/29.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ReplCreatModel.h"

@implementation ReplCreatModel

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
    
    
    _CreateUser= [dict objectForKey:@"CreateUser"];

    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.CreateUser forKey:@"CreateUser"];

    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(ReplCreatModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
