//
//  CardModel.h
//  guoping
//
//  Created by zhisu on 16/4/27.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardModel : NSObject


@property(nonatomic,retain)NSString *CardTypeId;// 卡类型ID

@property(nonatomic,strong)NSString *TypeName;//会员卡

@property(nonatomic,strong)NSNumber *Discount;//折扣





//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDiceionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(CardModel *)cellModel;



@end
