//
//  MemberDetailViewController.m
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "MainViewController.h"

@implementation MemberDetailViewController





- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    
    [self createView];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"会员详情"];
}


- (void)createView
{
    [self createBackgroundColorView:64 with:@"会员信息"];//数字64代表y点坐标

//    [self createLabelOne:94 with:@"会员姓名" and:self.model.Name];//上一个选中的单元格数据传递过来的模型值
//    [self createLabelOne:124 with:@"手机号码" and:self.model.Mobile];
//    [self createLabelOne:154 with:@"会员卡类型" and:self.model.CardTypeName];
//    
//    [self createBackgroundColorView:184 with:@"会员明细"];
    
    [self createLabelTwo:99 with:@"会员姓名" and:self.model.Name];
    
    
    if([self.model.Sex  isEqual: @"1"]){
        NSString *str = @"男";
        [self createLabelTwo:139 with:@"性别" and:str];}
    else if([self.model.Sex  isEqual: @"0"]){
        NSString *str = @"女";
        [self createLabelTwo:139 with:@"性别" and:str];}
    
    
    [self createLabelTwo:179 with:@"手机号" and:self.model.Mobile];
    [self createLabelTwo:219 with:@"会员卡号" and:self.model.MemberCode];
    [self createLabelTwo:259 with:@"会员类型" and:self.model.CardTypeName];
    [self createLabelTwo:299 with:@"账户余额" and:self.model.Amount.description];
    [self createLabelTwo:339 with:@"账户积分" and:self.model.Discount.description];
    [self createLabelTwo:379 with:@"办卡地点" and:self.model.StoreName];
    [self createLabelTwo:419 with:@"办理时间" and:self.model.CreateTime];
    [self createLabelTwo:459 with:@"办理人" and:self.model.StaffName];
    
    [self line];//填补两条缺失的线条
}

- (void)line
{
    UIImageView *line1 = [MyUtil createIamgeViewFrame:CGRectMake(0, 64, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:line1];
//    UIImageView *line2 = [MyUtil createIamgeViewFrame:CGRectMake(0, 184, ScreenWidth, 0.5) imageName:@"375x1@2x"];
//    [self.view addSubview:line2];
}

//用来创建导航文字的背景
- (void)createBackgroundColorView:(CGFloat)y with:(NSString *)title
{
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, y, ScreenWidth, 35)];
    bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
    UIImageView *line = [MyUtil createIamgeViewFrame:CGRectMake(0, y + 35, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:line];

    
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 9, 80, 20) title:title textAlignment:NSTextAlignmentLeft];
    label.textColor = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:14];
    
    [bgView addSubview:label];
    [self.view addSubview:bgView];
}



//创建格式一的label＋数据的传输
- (void)createLabelOne:(CGFloat)y with:(NSString *)title and:(NSString *)text
{
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, y, ScreenWidth, 35) title:[NSString stringWithFormat:@"%@：%@", title, text] textAlignment:NSTextAlignmentLeft];
    label.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label];
}


//创建格式二的label＋数据的传输
- (void)createLabelTwo:(CGFloat)y with:(NSString *)title and:(NSString *)text
{
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, y, 100, 40) title:title textAlignment:NSTextAlignmentLeft];
    label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
    label.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label];
    
    UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(100, y, ScreenWidth - 120, 40) title:text textAlignment:NSTextAlignmentRight];
    label1.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:label1];
    
    UIImageView *line = [MyUtil createIamgeViewFrame:CGRectMake(0, y + 40, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:line];
}




- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}



//推出页面的时候让tababr隐藏
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl hideTabBar];
}


//将要返回的时候
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



@end
