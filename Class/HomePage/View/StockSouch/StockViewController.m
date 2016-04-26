//
//  StockViewController.m
//  guoping
//
//  Created by zhisu on 15/9/17.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "StockViewController.h"
#import "MainViewController.h"
#import "ChangeBtn.h"
#import "StockSouchViewController.h"//搜索
#import "StockDetailsViewController.h"//详情
#import "StockshModel.h"
#import "StockshCell.h"
@interface StockViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MBProgressHUDDelegate>

{
    
    ChangeBtn *_selectedButton;//颜色赋给btn
    
    UITableView *_tableView;
    UITableView *_TwoPopViewTableView;
    
    NSUInteger  _selectedIndex;//下标
    
    
    UIView *_TopHeaderView;
    UIView *_view;//弹出的透明遮罩
    
    BOOL _isShow;//有没有显示
    UIButton * _lastBtn;//上一个btn
    UIButton *_btn;
    ChangeBtn *_btnTag;
    
    UIButton *_chgtn;//点击弹出选择view
    
    UISearchBar *_souch;//查找
    
    //没有网络的背景图
    UIView *NotSigview;
    
    //菊花
    MBProgressHUD *HUD;
    
    NSString *entID;
       NSString *EntID;
    
    //NSMutableArray *_dataArray;//数据
    
    
    int currPageIndex;
    int s;
    NSString *currPagestr;
    
    
    
}
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation StockViewController

-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    entID= [df objectForKey:@"GUID"];
    
    NSLog(@"%@",entID);
    
//    NSString *strID = [NSString stringWithFormat:@"%03d",3];
//    
//    EntID = strID;
    

    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    

    [self sharedClient];
 
    [self download];
    [self createNav];
    [self createTableview];


    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
   
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"库存查询"];
    
    
    
    
    [self hid];//隐藏刷新时间
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        
        [self loadMoredata];
        [_tableView.footer endRefreshing];
        
    }];
    
    
}


-(void)hid
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //    [header beginRefreshing];
    
    _tableView.header = header;
}

-(void)loadNewData
{
    
    //currPagestr = [NSString stringWithFormat:@"%d",0];
    currPageIndex = s * 0;
    
    [self download];
    //[HUD hide:YES];

    
  
    [_tableView.header endRefreshing];
    
}

//加载的 index
-(void)loadData
{
    
    
    currPagestr = [NSString stringWithFormat:@"%d",0];
    s = currPageIndex +1;
    currPageIndex = s;
    currPagestr = [NSString stringWithFormat:@"%d",s];
    
    
    
}


-(void)createTableview
{
    
    //_dataArray= [NSMutableArray array];
    

    
    
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-28) style:UITableViewStyleGrouped];
    
   _tableView.showsVerticalScrollIndicator =NO;
    //_tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    
    [self.view addSubview:_tableView];
    

    
    
    
    
    
    
}











#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_souch  resignFirstResponder];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StockDetailsViewController *StockCtrl = [[StockDetailsViewController alloc]init];
    StockshModel *model =self.dataArray[indexPath.row];
    StockCtrl.goodsId = model.GoodsID;
    [self.navigationController pushViewController:StockCtrl animated:YES];
    
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    static NSString *TwoCellID = @"TwoCellID";
    if (tableView == _tableView) {
        
        
        StockshCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[StockshCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
      
            
            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            
            
            //箭头
            UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 41, 10, 15) imageName:@"my_arrow_17X30@2x"];
            [cell addSubview:arrowImage];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        StockshModel *cellModel = self.dataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        
        return cell;
        
        
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoCellID];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellID];
            
            
            cell.backgroundColor = [UIColor cyanColor];
            
            
            
            
        }
        
       return cell;
        
        
        
    }
    
    
    
}



-(void)backAction:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}
#pragma mark --下载
-(void)download
{
   
 
    [self juhua];
    
    [self Caches];
    
    NSString *str = [NSString stringWithFormat:@GetGoodsInventoryListByPageUrl];
    
    //NSDictionary *params = @{@"X-SWC-Token":@"0dc1f6e1-c7f1-41ac-8ce2-32b6b3e57aa3"};
    
    NSDictionary * params = @{@"entId":entID,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"2" AndType:CacheTypeQuestion];
         
         NSError *error = nil;
         
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         
  
         //第一次分离
         if ([dict isKindOfClass:[NSDictionary class]]) {
             
             NSDictionary *subDict = [dict objectForKey:@"string"];
             NSString *str = [subDict objectForKey:@"text"];
        
             
             
             //字符串转化成data
             NSData *jsData = [str dataUsingEncoding:NSUTF8StringEncoding];
             
             NSError *error;
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableContainers error:&error];
             

             
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 
                        [self.dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
            
   
               
                     StockshModel *model = [[[StockshModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                 
                 }
                 [_tableView reloadData];
                   NotSigview.hidden = YES;//隐藏无网络视图
                 [HUD hide:YES];
                 
                 
             }
         }
         
         
     }
      failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


-(void)loadMoredata
{
   // [self juhua];
    NSString *str = [NSString stringWithFormat:@GetGoodsInventoryListByPageUrl];
    
    NSDictionary * params = @{@"entId":entID,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         //[CacheManager saveCacheWithObject:responseObject ForURLKey:@"2" AndType:CacheTypeQuestion];
         
         NSError *error = nil;
         
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         
     
         //第一次分离
         if ([dict isKindOfClass:[NSDictionary class]]) {
             
             NSDictionary *subDict = [dict objectForKey:@"string"];
             NSString *str = [subDict objectForKey:@"text"];
          
             
             
             //字符串转化成data
             NSData *jsData = [str dataUsingEncoding:NSUTF8StringEncoding];
             
             NSError *error;
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableContainers error:&error];
     
             
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 
                 [self.dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
             
                     
                     
                     StockshModel *model = [[[StockshModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
           
                 }
                 [_tableView reloadData];
                 NotSigview.hidden = YES;//隐藏无网络视图
                 //[HUD hide:YES];
                 
                 
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
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

#pragma mark-缓存

-(void)Caches
{
    if ([CacheManager readCacheWithURLKey:@"2" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"2" andType:CacheTypeQuestion];
        
        
        NSError *error = nil;
        
        //xml解析
        NSDictionary *dict = [XMLReader dictionaryForXMLData:result error:&error];
        
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
             
                [self.dataArray  removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据

                for (NSDictionary *dict in arr1) {
                    
                    NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                    
                    NSLog(@"%@",sssDict);
                    
                    
                    StockshModel *model = [[[StockshModel alloc]init]initWithDictionary:sssDict];
                    
                    
                    [self.dataArray addObject:model];
                    NSLog(@"======%ld",self.dataArray.count);
                }
  
                 [_tableView reloadData];
           
                //[HUD hide:YES];
                
                
            }
        }

        
    }
    
}



#pragma mark -- 检测实时的网络状况
-(void)sharedClient
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //2.设置监听
    //-设置网络监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                
                
                                if (self.dataArray != nil) {
                
                            
                                    
                                    NSLog(@"%@",self.dataArray);
                                    
                                    if ([CacheManager readCacheWithURLKey:@"2" andType:CacheTypeQuestion]!= nil) {
                                        
                                        NSLog(@"在无网情况下，有缓存。");
                                        
                                 
                                        
                                    }else
                                    {
                                        NotSigview= [[UIView alloc]init];
                                        NotSigview.frame = CGRectMake(0, 90, ScreenWidth, ScreenHeight);
                                        
                                        [self createbtn];
                                        [_tableView addSubview:NotSigview];
                                        NSLog(@"不可达的网络(未连接)");
                                    }
                                    
                
                                }else
                                {
                
                
                                
                                    
                           
                
                                }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"2G,3G,4G...的网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {

                
                [HUD hide:YES];

                
            }
                
                break;
            default:
                break;
        }
    }];
    //3.开始监听
    [manager startMonitoring];
    
    
    
    
}


#pragma mark - 没有网络的时候

-(void)createbtn
{
    //喇叭
    UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.5, ScreenHeight/4.47, ScreenWidth/5.357, ScreenHeight/9.571) imageName:@"xinhao@2x"];
    [NotSigview addSubview:image];
    
    
    //即将开放
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.42, ScreenHeight/3.04, ScreenWidth/6.25, ScreenHeight/22.3) title:@"网络不好" textAlignment:NSTextAlignmentCenter];
    label.font = [UIFont systemFontOfSize:14];
    label.adjustsFontSizeToFitWidth = YES;
    [NotSigview addSubview:label];
    
    //敬请期待
    UILabel *jqLabel =[MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.6, ScreenHeight/2.735, ScreenWidth/4.6875, ScreenHeight/33.5) title:@"请联网后再试" textAlignment:NSTextAlignmentCenter];
    jqLabel.font = [UIFont systemFontOfSize:14];
    jqLabel.textColor = [UIColor grayColor];
    jqLabel.adjustsFontSizeToFitWidth = YES;
    [NotSigview addSubview:jqLabel];
    
    
    //返回首页
    
    UIImageView *imgback = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.679, ScreenHeight/2.48, ScreenWidth/4.2, ScreenHeight/16.75) imageName:@"buttom_180x88@2x"];
    
    [NotSigview addSubview:imgback];
    
    UIButton * btn = [UIButton  buttonWithType:UIButtonTypeCustom];
    
    btn.frame =CGRectMake(ScreenWidth/2.42, ScreenHeight/2.44, ScreenWidth/6, ScreenHeight/21);
    
    //btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"刷新"  forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
    //btn.adjustsFontSizeToFitWidth = YES;
    [NotSigview addSubview:btn];
    
    
    
}

-(void)Action:(UIButton *)sender
{
    
    [self Caches];
    [HUD hide:YES];
    
    
}

#pragma mark - 菊花加载

-(void)juhua
{
    HUD =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.userInteractionEnabled = NO;
}
@end
