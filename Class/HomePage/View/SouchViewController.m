//
//  SouchViewController.m
//  guoping
//
//  Created by zhisu on 15/9/15.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SouchViewController.h"
#import "MainViewController.h"
@interface SouchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    UITableView *_popViewTableview;
       UIView *_TopHeaderView;
    
    UISearchBar *_souch;//查找
}

@end

@implementation SouchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
        [self createNav];
    [self createTableview];

        [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"搜索"];
    
    
}


-(void)backAction:(UIButton *)sender
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



-(void)createTableview
{
    
    
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    
    
    
    [self.view addSubview:_tableView];
    
    
    _TopHeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 50)];
    
    _TopHeaderView.backgroundColor = [UIColor whiteColor];
    
    [self createSouch];

    _tableView.tableHeaderView = _TopHeaderView;
    
    
    
    
    
}



#pragma mark--Souch
-(void)createSouch
{
    _souch= [[UISearchBar alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth/1.056, 36)];
    
    
    
    _souch.delegate = self;
    
    
    [_souch setBackgroundImage:[UIImage imageNamed:@"624x72_sousuokuang@2x"]];
    
    
    [_souch setSearchFieldBackgroundImage:[UIImage imageNamed:@"624x72_sousuokuang@2x"] forState:UIControlStateNormal];
    
    
    
    [_souch setPlaceholder:@"请输入商品名称/条形码/追溯码"];
    [_TopHeaderView addSubview:_souch];
    
}

#pragma mark--搜索框点击
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"点击");
    
 
    return YES;
}


#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView == _tableView) {
        
        return 10;
    }else
    {
        return 5;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    if (tableView == _popViewTableview) {
        return 0;
    }else
    {
        
        return 50;
    }
    
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";


        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
            
        }
        
        return cell;
        
    
    
    
    
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
    [tabCtrl hideTabBar];

}



@end
