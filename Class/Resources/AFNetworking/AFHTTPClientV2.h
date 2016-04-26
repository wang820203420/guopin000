//
//  AFHTTPClientV2.h
//  PAFNetClient
//
//  Created by JK.PENG on 14-11-11.
//  Copyright (c) 2014年 Jecky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef NS_ENUM(NSInteger, HTTPReqMethodTypeE) {
    kHTTPReqMethodTypeGET         = 0,
    kHTTPReqMethodTypePOST        = 1,
    kHTTPReqMethodTypeDELETE      = 2,
};

@class AFHTTPClientV2;


@interface AFHTTPClientV2 : NSObject<NSCopying>

@property (nonatomic, strong) NSDictionary *userInfo;
//下载数据
+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HTTPReqMethodTypeE)httpMethod
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HTTPReqMethodTypeE)httpMethod
                                 userInfo:(NSDictionary*)userInfo
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;


//上传数据
+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                                 userInfo:(NSDictionary*)userInfo
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;

@end
