//
//  MyUtil.m
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "MyUtil.h"

@implementation MyUtil


//添加button的方法
+(UIButton *)createBtnFrame:(CGRect)frame image:(NSString *)imageName selectedImage:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = frame;
    
    
    if (imageName) {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    
    if (selectedImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
    }
    
    
    if (target && action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    
    return btn;
    
    
}




+(UIImageView *)createIamgeViewFrame:(CGRect)frame imageName:(NSString *)imageName
{
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    imageView.image = [UIImage imageNamed:imageName];
    
    
    //开启用户交互
    imageView.userInteractionEnabled = YES;
    
    return imageView;
}


//添加UILabel
+(UILabel *)createLabelFrame:(CGRect)frame title:(NSString *)title textAlignment:(NSTextAlignment)textAlignment
{
    
    UILabel *label = [[UILabel alloc]init];
    label.frame = frame;
    if (title) {
        label.text = title;
    }
    if (textAlignment) {
        label.textAlignment = textAlignment;
        
    }
    
    return label;
    
}


//添加扫描btn
+(UIButton *)createBtnFrame:(CGRect)frame title:(NSString *)title setTitleColor:(UIColor*)setTitleColor backgroundColor:(UIColor *)backgroundColor target:(id)target action:(SEL)action
{
    
    UIButton *btn = [[UIButton alloc]init];
    btn.frame = frame;
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        //        //设置title的上下左右位置
        //        [btn setTitleEdgeInsets:UIEdgeInsetsMake(32, 0, 3, 0)];
        
    }
    if (setTitleColor) {
        [btn setTitleColor:setTitleColor forState:UIControlStateNormal];
    }
    if (backgroundColor) {
        [btn setBackgroundColor:backgroundColor];
    }
    if (target && action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return btn;
    
}

+(BOOL)checkValidSet:(NSDictionary *)dic key:(NSString *)key
{
    if ([[dic objectForKey:key]isEqual:[NSNull null]]) {
        
        return 0;
        
    }else
    {
        return 1;
    }
 
    
    
}


@end
