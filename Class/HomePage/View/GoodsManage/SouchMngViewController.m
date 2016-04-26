//
//  SouchMngViewController.m
//  guoping
//
//  Created by zhisu on 15/11/26.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "SouchMngViewController.h"
#import "MainViewController.h"
#import "GoodsMngCell.h"// 商品管理
#import "GoodsMngModel.h"
#import "GoodsDetailsViewController.h"
@interface SouchMngViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    UITableView *_tableView;
    UITableView *_popViewTableview;
    UIView *_TopHeaderView;
    
    UISearchBar *_souch;//查找
    
    NSString *InputData;
    
    
    NSString *EntID;

    int currPageIndex;
    int s;
    NSString *currPagestr;
  
}
@property(nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation SouchMngViewController

-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID= [df objectForKey:@"GUID"];
    

    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    
 
    [self createNav];
    [self createTableview];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"搜索"];
}

-(void)backAction:(UIButton *)sender
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
    
    [self createNav];
    [self createTableview];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"搜索"];
    
    
}



-(void)createTableview
{
    
    
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    
    

    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
 
    
    [self.view addSubview:_tableView];
    
    
    _TopHeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 50)];
    
    //_TopHeaderView.backgroundColor = [UIColor redColor];
    
    [self createSouch];
    
    _tableView.tableHeaderView = _TopHeaderView;
    
    
    
    
    
}



#pragma mark--Souch
-(void)createSouch
{
    _souch= [[UISearchBar alloc]initWithFrame:CGRectMake(10, 7, ScreenWidth/1.056, 36)];
    
    
    
    _souch.delegate = self;
    
    [_souch becomeFirstResponder];
    
    [_souch setBackgroundImage:[UIImage imageNamed:@"624x72_sousuokuang@2x"]];
    
    
    [_souch setSearchFieldBackgroundImage:[UIImage imageNamed:@"624x72_sousuokuang@2x"] forState:UIControlStateNormal];
    
    
    [_souch setPlaceholder:@"请输入商品名称/商品简码"];
    [_TopHeaderView addSubview:_souch];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_souch resignFirstResponder];
}
#pragma mark--搜索框点击
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    NSLog(@"点击");
    
    
    
    
    return YES;
}


-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@""])
    {
        
          [self.dataArray removeAllObjects];
        
        [_tableView reloadData];
        
    }
  
    return YES;
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",EntID);
  
    InputData = [NSString stringWithFormat:@"%@",_souch.text];
    NSLog(@"%@",InputData);
    
    //收集到的数据，不断的请求服务器，然后请求下载数据，然后解析，显示在tableview 上
    
    if ([InputData isEqualToString:@""]) {
        [self.dataArray removeAllObjects];
        
        [_tableView reloadData];
        return;
    }
    
    NSString *str = [NSString stringWithFormat:@GetGoodsInfoLisByPageUrl];
    
    NSDictionary * params = @{@"enId":EntID,@"goodCodeOrName":InputData,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         //[CacheManager saveCacheWithObject:responseOject ForURLKey:@"6" AndType:CacheTypeQuestion];
         
         
         NSError *error = nil;
         
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         
         NSLog(@"%@",dict);
         //第一次分离
         if ([dict isKindOfClass:[NSDictionary class]]) {
             
             NSDictionary *subDict = [dict objectForKey:@"string"];
             NSString *str = [subDict objectForKey:@"text"];
             NSLog(@"%@",str);
             
             
             //字符串转化成data
             NSData *jsData = [str dataUsingEncoding:NSUTF8StringEncoding];
             
             NSError *error;
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableContainers error:&error];
             
             NSLog(@"%@",dic);
             
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 
                 
                 [self.dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     GoodsMngModel *model = [[[GoodsMngModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                     NSLog(@"======%ld",self.dataArray.count);
                 }
                 [_tableView reloadData];
                 //NotSigview.hidden = YES;//隐藏无网络视图
                 //[HUD hide:YES];
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];

    
    
    
    
    
    
    
    
}



#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView == _tableView) {
        
        return self.dataArray.count;
    }else
    {
        return 5;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableView) {
        return 100;
    }else
    {
        return 35;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    
    if (tableView == _popViewTableview) {
        return 0;
    }else
    {
        
        return 0;
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GoodsDetailsViewController *goodsCtrl = [[GoodsDetailsViewController alloc]init];
    
    GoodsMngModel *model = self.dataArray[indexPath.row];
    goodsCtrl.GUID =model.GUID;
    
    [self.navigationController pushViewController:goodsCtrl animated:YES];
    
    
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    
    
    GoodsMngCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[GoodsMngCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        
        //线条
        CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
        [cell addSubview:Lowimage];
        
        //箭头
        UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 41, 10, 15) imageName:@"my_arrow_17X30@2x"];
        [cell addSubview:arrowImage];
        
    }
    
    GoodsMngModel *cellModel = self.dataArray[indexPath.row];
    
    cell.cellModel = cellModel;
    
    
    
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
