//
//  SetUpViewController.m
//  guoping
//
//  Created by zhisu on 15/11/10.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "SetUpViewController.h"
#import "LogViewController.h"
#import "AppDelegate.h"
#import  "HomePageViewController.h"
#import "MainViewController.h"
#import "AboutMeViewController.h"//关于我们

#define Alert(mss) [[[UIAlertView alloc]initWithTitle:[NSString stringWithFormat:@"%lfMB",str/(1024.0*1024.0)] message:mss delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil] show];
@interface SetUpViewController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    
    UITableView *_tableView;
    
    UIButton *_LogBtn;
    
    UIAlertView *alert;
    unsigned long long str;
    unsigned long long strr;
    

}

@end

@implementation SetUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    
    [self createTabelview];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"设置"];

    
   

    
}


-(void)createTabelview
{
    
    //数据
    //_dataArray = [NSMutableArray array];
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    
    
    //_tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    _tableView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];

    
    //退出登录按钮
     _LogBtn= [MyUtil createBtnFrame:CGRectMake(12, ScreenHeight/1.24, ScreenWidth/1.0684, ScreenHeight/13.4) image:@"greenbuttom_670x90@2x" selectedImage:nil target:self action:@selector(LogAction:)];
    
    [_LogBtn setTitle:@"退出登录" forState:UIControlStateNormal];
    
    
    [_tableView addSubview:_LogBtn];
    
    
    
    [self.view addSubview:_tableView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.section == 1) {
        
        //清除缓存
        NSString *path = [CacheManager cacheDirectory];
        
        NSLog(@"%@",path);

    NSFileManager* fileManager = [NSFileManager defaultManager];
        NSArray* allCache = [fileManager contentsOfDirectoryAtPath:path error:nil];
        NSLog(@"%@",allCache);
        
        if (allCache.count != 0 ) {
            
         
            str = [CacheManager AllCacheSize:path];
            
            NSLog(@"%lld",str);
            
            
            
            NSLog(@"%lfMB",str/(1024.0*1024.0));
            
        }else
        {
            
            str = [CacheManager AllCacheSize:path];
            
            NSLog(@"%lld",str);
            
            str = 0;
 
            
        }

  

        Alert(@"确认清除缓存?");
  
        
    }else if (indexPath.section == 2)
    {
        
        AboutMeViewController *abCtrl = [[AboutMeViewController alloc]init];
        
        [self.navigationController pushViewController:abCtrl animated:YES];
        
        
        
    }
        
    
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellID = @"CellID";
 
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 49.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
            UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
            [cell addSubview:Lowimage1];
            
            
            
            
            if (indexPath.section == 0) {
                
                
                UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 16, 80, 20) title:@"版本号" textAlignment:NSTextAlignmentLeft];
                label.font = [UIFont systemFontOfSize:16];
                
                [cell addSubview:label];
                
                
                UILabel *version = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.38, 16, 80, 20) title:@"v1.0" textAlignment:NSTextAlignmentRight];
                  version.font = [UIFont systemFontOfSize:16];
                [cell addSubview:version];
                
            }else if (indexPath.section == 1)
            {
                
                UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 16, 80, 20) title:@"清除缓存" textAlignment:NSTextAlignmentLeft];
                label.font = [UIFont systemFontOfSize:16];
                
                [cell addSubview:label];
                
            }else
            {
                UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 16, 80, 20) title:@"关于我们" textAlignment:NSTextAlignmentLeft];
                label.font = [UIFont systemFontOfSize:16];
                
                [cell addSubview:label];
                
                
            }
            
            
            
            
        }

        
    return cell;
    
    
}

#pragma mark-- 退出登录
-(void)LogAction:(UIButton *)sender
{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"您确定要退出登录吗？" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"style:UIAlertActionStyleCancel handler:nil];
  

    [alertController addAction:[UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
        
        //先删除用户名密码
        [df removeObjectForKey:@"myuser"];
        [df removeObjectForKey:@"pas"];
        
        
        NSString *us = [df objectForKey:@"myuser"];
        
        NSString *ps = [df objectForKey:@"pas"];
        
        NSLog(@"%@,%@",us,ps);
        
        
        
        
        if (us == nil||[us isEqualToString:@""]||ps == nil||[ps isEqualToString:@""]) {
            
            
            //退出到登陆页
            AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            
            [delegate.rootNav setViewControllers:@[delegate.logVC] animated:YES];
            
            
        }else
        {
            
            alert(@"退出失败，请重试！");
            
            
        }
        
        
    }]];
    
    [alertController addAction:cancelAction];
 
    
    [self presentViewController:alertController animated:YES completion:nil];
  
    
 
    
}


#pragma mark -- 提醒
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString* msg = [[NSString alloc] initWithFormat:@"您按下的第%ld个按钮！",buttonIndex];
    
    NSLog(@"%@",msg);
    
    if (msg != 0) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            //清除缓存
            [CacheManager resetCache];
            
            
            
        });
        
        
        
 
        
//        NSString *path = [CacheManager cacheDirectory];
//        
//        NSLog(@"%@",path);
//        
//        str = [CacheManager AllCacheSize:path];
//        
//        NSLog(@"%lld",str);
//        
//        
//        NSLog(@"%lfMB",str/(1024.0*1024.0));
        
   
        
    }
    
    
 
  
    
}


-(void)backAction:(UIButton *)sender
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
