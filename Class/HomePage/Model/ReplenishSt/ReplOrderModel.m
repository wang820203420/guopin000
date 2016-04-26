//
//  ReplOrderModel.m
//  guoping
//
//  Created by wangqian on 15/11/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ReplOrderModel.h"

@implementation ReplOrderModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}

//@property(nonatomic,strong)NSString *GoodsTypeName;//商品名称
//
//@property(nonatomic,strong)NSString *ShouldIncome;//应收
//
//@property(nonatomic,strong)NSString *LossIncome;//损耗
//
//@property(nonatomic,strong)NSString *RealIncome;//实收
//
//@property(nonatomic,strong)NSString *Origin;//产地
//
//

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
    
    
    _GoodsTypeName= [dict objectForKey:@"GoodsTypeName"];
    _ShouldIncome = [dict objectForKey:@"ShouldIncome"];
    _LossIncome = [dict objectForKey:@"LossIncome"];
    _RealIncome = [dict objectForKey:@"RealIncome"];
    _Origin = [dict objectForKey:@"Origin"];
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GoodsTypeName forKey:@"GoodsTypeName"];
    [dict setObject:self.ShouldIncome forKey:@"ShouldIncome"];
    [dict setObject:self.LossIncome forKey:@"LossIncome"];
    [dict setObject:self.RealIncome forKey:@"RealIncome"];
    [dict setObject:self.Origin forKey:@"Origin"];
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(ReplOrderModel *)cellModel
{
    
    return [cellModel dictionary];
    
}

@end
