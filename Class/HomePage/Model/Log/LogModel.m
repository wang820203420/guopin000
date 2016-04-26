//
//  LogModel.m
//  guoping
//
//  Created by zhisu on 15/11/25.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "LogModel.h"

@implementation LogModel

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
    
  
       //if ([_GUID isKindOfClass:[NSNull class]]) {
    
             _GUID = [dict objectForKey:@"GUID"];
    //}
    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    

    [dict setObject:self.GUID forKey:@"GUID"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(LogModel *)cellModel
{
    
    return [cellModel dictionary];
    
}


@end
