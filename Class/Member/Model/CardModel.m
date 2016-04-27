//
//  CardModel.m
//  guoping
//
//  Created by zhisu on 16/4/27.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "CardModel.h"

@implementation CardModel


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{}


//初始化模型数据
- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setCellDataWithDictionary:dict];
    }
    return self;
    
}

+ (instancetype)cellModelWithDiceionary:(NSDictionary *)dict
{
    
    return [[self alloc]initWithDictionary:dict];
}

- (void)setCellDataWithDictionary:(NSDictionary *)dict
{
    
    _CardTypeId= [dict objectForKey:@"CardTypeId"];
    
    _TypeName = [dict objectForKey:@"TypeName"];
    
    _Discount = [dict objectForKey:@"Discount"];
    
    
    //[self setValuesForKeysWithDictionary:dict];
    
    
    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.CardTypeId forKey:@"CardTypeId"];
    [dict setObject:self.TypeName forKey:@"TypeName"];
    [dict setObject:self.Discount forKey:@"Discount"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(CardModel *)cellModel
{
    
    return [cellModel dictionary];
    
}


@end
