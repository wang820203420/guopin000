//
//  ToGoosdModel.m
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ToGoosdModel.h"

@implementation ToGoosdModel

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
    
    
    _StoreNeedOrderNo = [dict objectForKey:@"StoreNeedOrderNo"];
    _StoreName = [dict objectForKey:@"StoreName"];

    //if ([_CreateTime isKindOfClass:[NSNull class]]) {
        _CreateTime = [dict objectForKey:@"CreateTime"];

    //}
    
    _GUID = [dict objectForKey:@"GUID"];
    NSLog(@"%@",dict);
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.StoreNeedOrderNo forKey:@"StoreNeedOrderNo"];
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.CreateTime forKey:@"CreateTime"];
    [dict setObject:self.GUID forKey:@"GUID"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(ToGoosdModel *)cellModel
{
    
    return [cellModel dictionary];
    
}


@end
