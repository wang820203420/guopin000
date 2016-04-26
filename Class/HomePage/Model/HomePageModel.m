//
//  HomePageModel.m
//  guoping
//
//  Created by zhisu on 15/10/14.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "HomePageModel.h"

@implementation HomePageModel


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
    
    
    _SaleAmount = [dict objectForKey:@"SaleAmount"];
    _SaleCount = [dict objectForKey:@"SaleCount"];

    NSLog(@"%@",dict);
  
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:self.SaleAmount forKey:@"SaleAmount"];
    [dict setObject:self.SaleCount forKey:@"SaleCount"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(HomePageModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
