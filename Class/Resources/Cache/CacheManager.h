//
//  CacheManager.h
//  xiaoqu
//
//  Created by wendy on 14/12/3.
//  Copyright (c) 2014年 shenhai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CacheType) {
    
    CacheTypeQuestion = 1,
    CacheTypeImage    = 2
};


@interface CacheManager : NSObject

// 缓存路径
+(NSString*)cacheDirectory;

// 写入缓存
+(void)saveCacheWithObject:(id)object ForURLKey:(NSString*)URLKey AndType:(CacheType)Cachetype;

// 读取缓存
+(id)readCacheWithURLKey:(NSString*)URLKey andType:(CacheType)Cachetype;

// 计算缓存大小
+(unsigned long long) AllCacheSize:(NSString*) CachePath;

// 清楚指定过期缓存
+(void) removeOutTimeCache:(NSTimeInterval) cacheTime;

// 清空
+ (void) resetCache;

// base64
+ (NSString *)base64EncodeString:(NSString *)string;


@end
