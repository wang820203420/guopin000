 //
//  AFHTTPClientV2.m
//  PAFNetClient
//
//  Created by JK.PENG on 14-11-11.
//  Copyright (c) 2014年 Jecky. All rights reserved.
//

#import "AFHTTPClientV2.h"

@implementation AFHTTPClientV2

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HTTPReqMethodTypeE)httpMethod
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;
{
    return [self requestWithBaseURLStr:URLString params:params httpMethod:httpMethod userInfo:nil success:success failure:failure];    
}

//下载数据 ：包含2种兼容方式，可以选择自己适合的。
+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                                   params:(NSDictionary *)params
                               httpMethod:(HTTPReqMethodTypeE)httpMethod
                                 userInfo:(NSDictionary*)userInfo
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure;
{
    AFHTTPClientV2 *httpV2 =  [[AFHTTPClientV2 alloc] init];
    httpV2.userInfo = userInfo;
        
    CGFloat  sysVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (sysVersion < 7.0) {
        //包含了常见的HTTP访问web站点的模式，有创建请求，连续的响应，网络类型监视以及安全。要兼容IOS6 or 10.8的应用，可以使用 AFHTTPRequestOperationManager
        AFHTTPRequestOperationManager   *httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        //响应间隔
        httpClient.requestSerializer.timeoutInterval = 20.0f;
        //验证响应数据类型
        httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/xml", @"text/html", @"text/plain",nil];
        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        //get请求
        if (httpMethod == kHTTPReqMethodTypeGET) {
            
            [httpClient GET:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(httpV2, responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(httpV2, error);
                }
            }];
            //post请求
        }else if (httpMethod == kHTTPReqMethodTypePOST){
            
            
            [httpClient POST:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(httpV2, responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(httpV2, error);
                }
            }];
            //删除类型
        }else if (httpMethod == kHTTPReqMethodTypeDELETE){
            
            
            [httpClient DELETE:URLString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (success) {
                    success(httpV2, responseObject);
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                if (failure) {
                    failure(httpV2, error);
                }
            }];
            
        }

    }else{
        //  AFHTTPSessionManager非常方便的请求网络数据，实现了Get/Post 等等诸多方式请求网络数据。同时可以对网络环境变化的监听。对于开发者来说如果开发IOS7 or OSX 10.9的应用最好继承AFHTTPSessionManager使用单例模式返回一个该类的实例，如果要兼容IOS6 or 10.8的应用，可以使用 AFHTTPRequestOperationManager
        
        AFHTTPSessionManager   *httpClient = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        httpClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        httpClient.requestSerializer.timeoutInterval = 20.0f;
        httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/xml", @"text/html", @"text/plain",nil];

        if (httpMethod == kHTTPReqMethodTypeGET) {
            
            [httpClient GET:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(httpV2, responseObject);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) {
                    failure(httpV2, error);
                }
            }];
            
        }else if (httpMethod == kHTTPReqMethodTypePOST){
            
            [httpClient POST:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(httpV2, responseObject);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) {
                    failure(httpV2, error);
                }
            }];
            
        }else if (httpMethod == kHTTPReqMethodTypeDELETE){
            
            [httpClient DELETE:URLString parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
                if (success) {
                    success(httpV2, responseObject);
                }
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                if (failure) {
                    failure(httpV2, error);
                }
            }];            
        }

    }

    return httpV2;
}

//上传数据
+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                                 userInfo:(NSDictionary*)userInfo
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure
{
    AFHTTPClientV2 *httpV2 =  [[AFHTTPClientV2 alloc] init];
    httpV2.userInfo = userInfo;
    
    //获取当前设备版本信息
    CGFloat  sysVersion = [[UIDevice currentDevice].systemVersion floatValue];
    //如果是7.0以下那就执行
    if (sysVersion < 7.0) {
        AFHTTPRequestOperationManager   *httpClient = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/xml", @"text/html", @"text/plain",nil];

        [httpClient POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (success) {
                success(httpV2, responseObject);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if (failure) {
                failure(httpV2, error);
            }
        }];

    }else{
        AFHTTPSessionManager   *httpClient = [[AFHTTPSessionManager alloc] initWithBaseURL:nil];
        httpClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/xml", @"text/html", @"text/plain",nil];

        //    NSURLSessionTask的三种类型:
        
        //        1> NSURLSessionDataTask 处理一般的NSData数据对象, 比如通过GET或POST方式从服务器获取JSON或XML返回等等, 但不支持后台获取.
        //
        //        2> NSURLSessionUploadTask 用于上传文件, 支持后台上传 .
        //
        //        3> NSURLSessionDownloadTask 用于下载文件, 支持后台下载 .
        [httpClient POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(NSURLSessionDataTask *task, id responseObject) {
            if (success) {
                success(httpV2, responseObject);
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (failure) {
                failure(httpV2, error);
            }
        }];
    }
    return httpV2;
}

+ (AFHTTPClientV2 *)requestWithBaseURLStr:(NSString *)URLString
                               parameters:(id)parameters
                constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                                  success:(void (^)(AFHTTPClientV2 *request, id responseObject))success
                                  failure:(void (^)(AFHTTPClientV2 *request, NSError *error))failure
{
    return [self requestWithBaseURLStr:URLString parameters:parameters userInfo:nil constructingBodyWithBlock:block success:success failure:failure];
}

#pragma mark - NSCopying
- (id)copyWithZone:(NSZone *)zone
{
    AFHTTPClientV2  *clientV2 = [[self class] init];
    [clientV2 setUserInfo:[[self userInfo] copyWithZone:zone]];
    return clientV2;
}

@end
