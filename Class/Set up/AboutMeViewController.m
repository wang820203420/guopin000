//
//  AboutMeViewController.m
//  guoping
//
//  Created by zhisu on 15/11/16.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "AboutMeViewController.h"
#import "MainViewController.h"
@interface AboutMeViewController ()

@end

@implementation AboutMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];

      [self createNav];

    [self createAll];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"关于我们"];
    
    
}



-(void)createAll
{
    
    UIImageView *sax = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.5, ScreenHeight/7.128, ScreenWidth/5.357, ScreenHeight/9.53) imageName:@"logo_150x150@2x"];
    
    UILabel *saxlabel = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.698, ScreenHeight/3.743, ScreenWidth/4.167, 20) title:@"果品进销存" textAlignment:NSTextAlignmentCenter];
    saxlabel.font = [UIFont systemFontOfSize:17];
    saxlabel.adjustsFontSizeToFitWidth = YES;
    saxlabel.textColor = [UIColor colorWithRed:92.0/255.0 green:169.0/255.0 blue:86.0/255.0 alpha:1];
    
    [self.view addSubview:saxlabel];
    [self.view addSubview:sax];
    
    
    
    UITextView *textView = [[UITextView alloc]init];
    textView.backgroundColor = [UIColor clearColor];
    textView.frame = CGRectMake(ScreenWidth/7.212, ScreenHeight/3.2, ScreenWidth/1.384, 315);
    textView.text = @"果品进销存APP项目团队由国内外顶尖的信息技术、互联网技术、电子技术专家组成，具有丰富的零售行业管理经验、前沿的互联网及电子技术，为您的品牌以及环境提供卓越的服务。\n\n果品进销存专卖店管理系统是延续了新架构模式，集合了门店进销存、连锁管理、称重为一体，专门针对食品、果蔬连锁等称重行业专卖店量身定制设计的一体化信息化系统。总部系统包含了企业的商品流、信息流、资金流的所有业务管理思想，它与门店系统、配送中心系统、决策支持系统等相辅相成，共同构筑了企业强大的管理信息网络系统，满足企业“管理规范化、业务自动化、功能先进化”需求。 ";
    
    //动态计算出高度
    CGSize size = [textView sizeThatFits:CGSizeMake(CGRectGetWidth(textView.frame), MAXFLOAT)];
    CGRect frame = textView.frame;
    frame.size.height = size.height+40;
    textView.frame = frame;
    
    
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:13];
    textView.textColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1];
    [self.view addSubview:textView];
    

    
  
    UITextView *userView = [[UITextView alloc]init];
    userView.backgroundColor = [UIColor clearColor];
    userView.frame = CGRectMake(ScreenWidth/7.212, 455, ScreenWidth/1.384, 25);
    userView.text = @"                  休闲食品 水果蔬菜 特色熟食 农副产品等专卖行业。";
    
    //动态计算出高度
    CGSize size1 = [userView sizeThatFits:CGSizeMake(CGRectGetWidth(userView.frame), MAXFLOAT)];
    CGRect frame1 = userView.frame;
    frame1.size.height = size1.height;
    userView.frame = frame1;
    
    userView.editable = NO;
    userView.font = [UIFont systemFontOfSize:13];
    userView.textColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1];
    [self.view addSubview:userView];
    
    
    UILabel *userLabel = [MyUtil createLabelFrame:CGRectMake(51,460, ScreenWidth/5.3, 20) title:@"适用业态:" textAlignment:NSTextAlignmentCenter];
    //userLabel.backgroundColor = [UIColor redColor];
    userLabel.font = [UIFont systemFontOfSize:14];
      userLabel.adjustsFontSizeToFitWidth = YES;
    [userLabel setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [self.view addSubview:userLabel];

    
    UILabel *endLabel = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/6.25, ScreenHeight/1.04, ScreenWidth/1.5, 20) title:@"Copy Right©上海市质尊溯源电子科技有限公司" textAlignment:NSTextAlignmentCenter];
    endLabel.font = [UIFont systemFontOfSize:11];
    endLabel.adjustsFontSizeToFitWidth = YES;
    endLabel.textColor = [UIColor colorWithRed:120.0/255.0 green:120.0/255.0 blue:120.0/255.0 alpha:1];
    [self.view addSubview:endLabel];
    
    
    
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

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
    
}


@end
