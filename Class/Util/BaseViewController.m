//
//  BaseViewController.m
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
{
    
    UIImageView *_bgImageView;
    
}
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.navigationController.navigationBarHidden = YES;
    
  
    
    
}

//创建导航栏
-(void)createNav
{
    
    
    _bgImageView = [MyUtil createIamgeViewFrame:CGRectMake(0, 0, ScreenWidth, 64) imageName:@"dh_bg@2x"];
    
   
    [self.view addSubview:_bgImageView];
    
    
}
//在导航上添加按钮
-(void)addNavButton:(CGRect)frame imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName target:(id)target action:(SEL)action
{
    
    UIButton *btn = [MyUtil createBtnFrame:frame image:imageName selectedImage:selectedImageName target:target action:action];
    
    [_bgImageView addSubview:btn];
    
    
}

//添加btn和设置图片
-(void)addNavButton:(CGRect)frame imageName:(NSString *)imageName target:(id)target action:(SEL)action
{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    //btn.backgroundColor = [UIColor redColor];

    
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (target && action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    [_bgImageView addSubview:btn];
    
    
}


//在导航上添加文字
-(UILabel *)addNavLabel:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment text:(NSString *)text
{
    
    UILabel *label = [MyUtil createLabelFrame:frame title:text textAlignment:textAlignment];
    label.font = font;
    label.textColor = textColor;
    
    [_bgImageView addSubview:label];
    
    return label;
    
}


//在导航栏上添加图片
-(void)addNavImage:(CGRect)frame imageName:(NSString *)imageName
{
    
    
    UIImageView *imageView = [MyUtil createIamgeViewFrame:frame imageName:imageName];
    [_bgImageView addSubview:imageView];
    
}

-(void)addNavButton:(CGRect)frame text:(NSString *)text target:(id)target action:(SEL)action
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    [btn setTitle:text forState:UIControlStateNormal];
    
    if (target && action) {
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    
    [_bgImageView addSubview:btn];
    

    
}




@end
