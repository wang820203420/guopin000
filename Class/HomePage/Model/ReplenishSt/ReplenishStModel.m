//
//  ReplenishStModel.m
//  guoping
//
//  Created by zhisu on 15/10/20.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ReplenishStModel.h"

@implementation ReplenishStModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{}


//@property(nonatomic,strong)NSString *StoreIncomeNo;//商品名称
//
//@property(nonatomic,strong)NSString *StoreName;//水果一号店
//
//@property(nonatomic,strong)NSString *IncomeDate;//订单时间


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
    
    
    _StoreIncomeNo= [dict objectForKey:@"StoreIncomeNo"];
    _StoreName = [dict objectForKey:@"StoreName"];
    _IncomeDate = [dict objectForKey:@"IncomeDate"];
    _GUID= [dict objectForKey:@"GUID"];
    
    
    NSLog(@"%@",dict);
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.StoreIncomeNo forKey:@"StoreIncomeNo"];
    [dict setObject:self.StoreName forKey:@"StoreName"];
    [dict setObject:self.IncomeDate forKey:@"IncomeDate"];
    [dict setObject:self.GUID forKey:@"GUID"];
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(ReplenishStModel *)cellModel
{
    
    return [cellModel dictionary];
    
}


@end
