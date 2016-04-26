//
//  PropretyViewController.m
//  guoping
//
//  Created by zhisu on 15/9/30.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "PropretyViewController.h"
#import "MainViewController.h"
@interface PropretyViewController ()

@end

@implementation PropretyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
    
    [self createNav];
    [self createbtn];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];

    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"财务报表"];
    
}


-(void)createbtn
{
    //喇叭
    UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.5, ScreenHeight/2.68, ScreenWidth/5.357, ScreenHeight/9.571) imageName:@"laba@2x"];
    [self.view addSubview:image];
    
    
    //即将开放
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.42, ScreenHeight/2.09, ScreenWidth/6.25, ScreenHeight/22.3) title:@"即将开放" textAlignment:NSTextAlignmentCenter];
    label.font = [UIFont systemFontOfSize:14];
   label.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:label];
    
    //敬请期待
    UILabel *jqLabel =[MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.42, ScreenHeight/1.953, ScreenWidth/6.25, ScreenHeight/22.3) title:@"敬请期待" textAlignment:NSTextAlignmentCenter];
    jqLabel.font = [UIFont systemFontOfSize:13];
    jqLabel.textColor = [UIColor grayColor];
     jqLabel.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:jqLabel];
    
    
    //返回首页
    
    UIImageView *imgback = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.679, ScreenHeight/1.796, ScreenWidth/4.2, ScreenHeight/16.75) imageName:@"buttom_180x88@2x"];
    
    [self.view addSubview:imgback];
    
    UIButton * btn = [UIButton  buttonWithType:UIButtonTypeCustom];
    
    btn.frame =CGRectMake(ScreenWidth/2.42, ScreenHeight/1.777, ScreenWidth/6, ScreenHeight/21);
    
    //btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回首页"  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(ibackAction:) forControlEvents:UIControlEventTouchUpInside];
     //btn.adjustsFontSizeToFitWidth = YES;
    [self.view addSubview:btn];
    
    
    
}


-(void)ibackAction:(UIButton *)btn
{
      NSLog(@"11");
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}




-(void)backAction:(UIButton *)btn
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
//推出页面的时候让tababr
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl hideTabBar];
    
    
    
}

//将要返回的时候
-(void)viewWillDisappear:(BOOL)animated
{
    
    
    [super viewWillDisappear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
    
}


@end
