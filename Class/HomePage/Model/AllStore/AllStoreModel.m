
//
//  AllStoreModel.m
//  guoping
//
//  Created by zhisu on 15/10/30.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "AllStoreModel.h"

@implementation AllStoreModel

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
    _EnterpriseID = [dict objectForKey:@"EnterpriseID"];
    _GUID = [dict objectForKey:@"GUID"];
    
    NSLog(@"%@",dict);
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];

    
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.EnterpriseID forKey:@"EnterpriseID"];
    [dict setObject:self.GUID forKey:@"GUID"];

    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(AllStoreModel *)cellModel
{
    
    return [cellModel dictionary];
    
}


@end
