//
//  MyUtil.h
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyUtil : NSObject


//添加button的方法
+(UIButton *)createBtnFrame:(CGRect)frame image:(NSString *)imageName selectedImage:(NSString *)selectedImageName target:(id)target action:(SEL)action;

//创建UIImageView的方法
+(UIImageView *)createIamgeViewFrame:(CGRect)frame imageName:(NSString *)imageName;

//创建label的方法
+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment;

//创建tabbar二维码扫描btn
+(UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title setTitleColor:(UIColor*)setTitleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action;

+(BOOL)checkValidSet:(NSDictionary *)dic key:(NSString *)key;


@end
