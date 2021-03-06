//
//  SalesMoneyModel.m
//  guoping
//
//  Created by zhisu on 15/10/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "SalesMoneyModel.h"

@implementation SalesMoneyModel


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
    
    
    _TotalMoney = [dict objectForKey:@"TotalMoney"];
    _TotalCutOff = [dict objectForKey:@"TotalCutOff"];

    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.TotalMoney forKey:@"TotalMoney"];
    [dict setObject:self.TotalCutOff forKey:@"TotalCutOff"];
    

    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(SalesMoneyModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
