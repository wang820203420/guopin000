//
//  CacheManager.m
//  xiaoqu
//
//  Created by wendy on 14/12/3.
//  Copyright (c) 2014年 shenhai. All rights reserved.
//

#import "CacheManager.h"

static unsigned long long size = 0;

@implementation CacheManager

+ (void) resetCache
{
    [[NSFileManager defaultManager] removeItemAtPath:[CacheManager cacheDirectory] error:nil];
}

+(unsigned long long) AllCacheSize:(NSString*) CachePath
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* allCache = [fileManager contentsOfDirectoryAtPath:CachePath error:nil];
    NSLog(@"%@",allCache);
    for(NSString* FileName in allCache)
    {
        NSString* fullFilePath = [CachePath stringByAppendingPathComponent:FileName];
        
         NSLog(@"%@",fullFilePath);
        
        BOOL isDir;
        if ([fileManager fileExistsAtPath:fullFilePath isDirectory:&isDir])
        {
            NSDictionary* fileAtrribute = [fileManager attributesOfItemAtPath:fullFilePath error:nil];
            
            NSLog(@"%@",fileAtrribute);
            size += fileAtrribute.fileSize;
        }
//        else
//        {
//            [self AllCacheSize:fullFilePath];
//        }
    }
    return size;
}

+(void)removeOutTimeCache:(NSTimeInterval) cacheTime
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSLog(@"cache directory : %@",[self cacheDirectory]);
    NSArray* allCache = [fileManager contentsOfDirectoryAtPath:self.cacheDirectory error:nil];
    for(NSString* FileName in allCache)
    {
        NSString* fullFilePath = [self.cacheDirectory stringByAppendingPathComponent:FileName];
        BOOL isDir;
        if (![fileManager fileExistsAtPath:fullFilePath isDirectory:&isDir])
        {
            NSDictionary* fileAtrribute = [fileManager attributesOfItemAtPath:fullFilePath error:nil];
            NSDate *modificationDate = [fileAtrribute objectForKey:NSFileModificationDate];
            if ([modificationDate timeIntervalSinceNow] > cacheTime)
            {
                [fileManager removeItemAtPath:fullFilePath error:nil];
            }
        }
//        else
//        {
//            [self removeOutTimeCache:cacheTime];
//        }
    }
}

+(NSString*)cacheDirectory
{
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    
    NSString *cacheDirectory = [paths objectAtIndex:0];
    cacheDirectory = [cacheDirectory stringByAppendingPathComponent:@"66Caches"];
    
    BOOL isDir = YES;
    if (![[NSFileManager defaultManager] fileExistsAtPath:cacheDirectory isDirectory:&isDir]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cacheDirectory
                                  withIntermediateDirectories:NO
                                                   attributes:nil
                                                        error:nil];
    }
    return cacheDirectory;
}

+(void)saveCacheWithObject:(id)object ForURLKey:(NSString*)URLKey AndType:(CacheType)Cachetype
{
    NSString *filepath = [self.cacheDirectory stringByAppendingPathComponent:URLKey];
    [NSKeyedArchiver archiveRootObject:object toFile:filepath];
}

+(id)readCacheWithURLKey:(NSString*)URLKey andType:(CacheType)Cachetype
{
    id readContent  = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSString stringWithFormat:@"%@/%@",self.cacheDirectory ,URLKey]];
    return readContent;
}

+ (NSString *)base64EncodeString:(NSString *)string
{
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

@end
