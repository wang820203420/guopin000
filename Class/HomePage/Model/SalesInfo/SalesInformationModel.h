//
//  SalesInformationModel.h
//  guoping
//
//  Created by zhisu on 15/10/15.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalesInformationModel : NSObject

@property(nonatomic,assign,setter=setId:)NSInteger mId;

@property(nonatomic,retain)NSString *saleno;//订单编号

@property(nonatomic,strong)NSString *storename;//店铺地址

@property(nonatomic,strong)NSNumber *totalmoney;//金钱

@property(nonatomic,strong)NSNumber *totalCutOff;//金钱

@property(nonatomic,strong)NSString *saledate;//出售时间

@property(nonatomic,strong)NSString *GUID;
@property(nonatomic,strong)NSString *StoreID;

/**
 *
 *   接口样例:
 *
 {  "Mobile": "343434",
 "GUID": "e2eea4d075e44787b730b57f6bb35088",
 "SaleNo": "031604130002",
 "UpdateUser": "",
 "UpdateTime": null,
 "CreateUser": "ec828d50d9a24507aef40a3fafb4b83c",
 "CreateTime": "2016-05-13 08:45:07",
 "IsDelete": 0,
 "TotalMoney": 27.00,
 "TotalUnitNum": null,
 "SaleDate": "2016-05-13 08:45:07",
 "StoreID": "0d6a1411d71b4643bdc5c13c1e8af117",
 "StoreName": "嘉客来水果大华二路店",
 "UploadUpdateTime": null,
 "UploadCreateTime": null,
 "SourceID": null,
 "EnterpriseID": null,
 "CutOffType": 0,
 "CutOff": null,
 "MemberID": null,
 "TotalCutOff": 4.40  },
 
 *
 *
 */

//创建cell模型的同时设置模型数据
+(instancetype)cellModelWithDictionary:(NSDictionary *)dict;
-(instancetype)initWithDictionary:(NSDictionary *)dict;




//将cellmodel转换成字典
-(NSDictionary *)dictionary;
+(NSDictionary *)dictionaryWithCellModel:(SalesInformationModel *)cellModel;

@end
