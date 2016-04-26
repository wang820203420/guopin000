//
//  BaseViewController.h
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


-(void)createNav;

//在导航栏上添加button

-(void)addNavButton:(CGRect)frame imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action;

//在导航栏上添加图片
-(void)addNavImage:(CGRect)frame imageName:(NSString *)imageName;

//在导航栏上添加文字
- (UILabel *)addNavLabel:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text;

//添加btn和设置图片--灵敏度高的btn
-(void)addNavButton:(CGRect)frame imageName:(NSString *)imageName target:(id)target action:(SEL)action;

//添加编辑
-(void)addNavButton:(CGRect)frame text:(NSString *)text target:(id)target action:(SEL)action;

@end
