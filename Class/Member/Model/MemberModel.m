//
//  MemberModel.m
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel

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
    
    _StaffName = [dict objectForKey:@"StaffName"];
    
    _Sex = [dict objectForKey:@"Sex"];
    
    _Mobile = [dict objectForKey:@"Mobile"];
    
    _MemberId = [dict objectForKey:@"MemberId"];
    
    _CardType = [dict objectForKey:@"CardType"];
    
    _CardTypeName = [dict objectForKey:@"CardTypeName"];
    
    _Amount = [dict objectForKey:@"Amount"];
    
    _Points = [dict objectForKey:@"Points"];
    
    _SourceID = [dict objectForKey:@"SourceID"];
    
    _CreateTime = [dict objectForKey:@"CreateTime"];
    
    _CreateUser = [dict objectForKey:@"CreateUser"];
    
    
    
    
    _GUID = [dict objectForKey:@"Enterprise"];
    _StoreID = [dict objectForKey:@"StoreID"];//这里有值
    
    
    _Discount = [dict objectForKey:@"Discount"];
    
    //[self setValuesForKeysWithDictionary:dict];
    

    
    
}

//将cellmodel转换成字典
-(NSDictionary *)dictionary
{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:self.StaffName forKey:@"StaffName"];
    [dict setObject:self.Sex forKey:@"Sex"];
    [dict setObject:self.Mobile forKey:@"Mobile"];
    [dict setObject:self.MemberId forKey:@"MemberId"];
    [dict setObject:self.CardType forKey:@"CardType"];
    [dict setObject:self.Amount forKey:@"Amount"];
    [dict setObject:self.Points forKey:@"Points"];
    [dict setObject:self.SourceID forKey:@"SourceID"];
    [dict setObject:self.CreateTime forKey:@"CreateTime"];
    [dict setObject:self.CreateUser forKey:@"CreateUser"];
    [dict setObject:self.GUID forKey:@"Enterprise"];
    [dict setObject:self.StoreID forKey:@"StoreID"];
    [dict setObject:self.Discount forKey:@"Discount"];
    [dict setObject:self.CardTypeName forKey:@"CardTypeName"];
    
    return dict;
    
}
+(NSDictionary *)dictionaryWithCellModel:(MemberModel *)cellModel
{
    
    return [cellModel dictionary];
    
}




@end
