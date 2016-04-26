//
//  RankingModel.m
//  guoping
//
//  Created by zhisu on 15/10/27.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "RankingModel.h"

@implementation RankingModel

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
    
    

    _StoreName = [dict objectForKey:@"StoreName"];
    _TotalSaleMoney = [dict objectForKey:@"TotalSaleMoney"];
    
    
    NSLog(@"%@",dict);
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.TotalSaleMoney forKey:@"TotalSaleMoney"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(RankingModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
