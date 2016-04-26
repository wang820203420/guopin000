//
//  ToGoodsDetailModel.m
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ToGoodsDetailModel.h"

@implementation ToGoodsDetailModel


//@property(nonatomic,strong)NSString *GoodsTypeName;//商品名称
//
//@property(nonatomic,strong)NSString *NeedNumber;//库存
//
//@property(nonatomic,strong)NSString *CurrentInventory;//核定
//
//@property(nonatomic,strong)NSString *CurrentCheckInventory;//进货量

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
    
    
    _GoodsName = [dict objectForKey:@"GoodsName"];
    
    
          _NeedNumber = [dict objectForKey:@"NeedNumber"];
    

    _CurrentInventory = [dict objectForKey:@"CurrentInventory"];
  
    
    
    _CurrentCheckInventory = [dict objectForKey:@"CurrentCheckInventory"];
    
    _UnitName = [dict objectForKey:@"UnitName"];
    
    
    
       
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.GoodsName forKey:@"GoodsName"];
    [dict setObject:self.NeedNumber forKey:@"NeedNumber"];
    [dict setObject:self.CurrentInventory forKey:@"CurrentInventory"];
    [dict setObject:self.CurrentCheckInventory forKey:@"CurrentCheckInventory"];
    [dict setObject:self.UnitName forKey:@"UnitName"];

    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(ToGoodsDetailModel *)cellModel
{
    
    return [cellModel dictionary];
    
}



@end
