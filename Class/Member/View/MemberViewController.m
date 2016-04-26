//
//  MemberViewController.m
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberViewController.h"
#import "MainViewController.h"
#import "ChangeBtn.h"
#import "MemberDetailViewController.h"//会员详情
#import "MemberCell.h"//会员
#import "MemberModel.h"

@interface MemberViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    
    UITableView *_tableView;
    UITableView *_popViewTableview;
    
    UIView *_TopHeaderView;
    UIView *_view;//弹出的透明遮罩
    
    UIButton *_chgtn;//点击弹出选择view
    
    
    ChangeBtn *_btnTag;
    BOOL _isShow;//有没有显示
    UIButton * _lastBtn;//上一个btn
    ChangeBtn *_selectedButton;//颜色赋给btn
    NSUInteger  _selectedIndex;//下标
    
    
    //没有网络的背景图
    UIView *NotSigview;
    
    //菊花
    MBProgressHUD *HUD;
    
    
    NSString *date;//今日、本周、本月
    NSString *bgyl;//店铺名
    
    
    //日期
    UILabel *Today;
    UILabel *Week;
    UILabel *Month;
    
    
    int currPageIndex;
    int s;
    NSString *currPagestr;
    
}

@property(nonatomic,retain)NSMutableArray *dataArray;


@end

@implementation MemberViewController


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
    _EntID= [df objectForKey:@"GUID"];
    
    
    NSString *Date = [NSString stringWithFormat:@"%d",1];
    date = Date;
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    
    [self sharedClient];
    
    [self download];
    [self createNav];
    [self createTableview];
    [self createPoPviewTableview];
    [self createScan];
    
    _selectedButton = [ChangeBtn buttonWithType:UIButtonTypeSystem];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"会员"];
    
    
    [self hid];//隐藏刷新时间
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadData];
        [self downloadMore];
        [_tableView.footer endRefreshing];
        
    }];
    

}




- (void)hid
{
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    
    _tableView.header = header;
}


-(void)loadNewData
{
    
    currPagestr = [NSString stringWithFormat:@"%d",0];
    currPageIndex = s * 0;
    
    [self download];
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
    
    //_dataArray = [NSMutableArray array];
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-28) style:UITableViewStyleGrouped];
    _tableView.showsVerticalScrollIndicator = NO;
    
    //_tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    
    _TopHeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 60)];
    
    
    _TopHeaderView.backgroundColor = [UIColor whiteColor];
    
    
    
    
    _tableView.tableHeaderView = _TopHeaderView;
    
    
    
    
    
    
    
}

#pragma maek -popViewTableview
-(void)createPoPviewTableview
{
    
    _view= [[UIView alloc]init];
    _view.frame = CGRectMake(0,155, ScreenWidth, 0);
    _view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    _view.clipsToBounds = YES;//截断
    [self.view  addSubview:_view];
    
    
    
}

#pragma mark--scan
-(void)createScan
{
    
    
    
    UIButton *Souchbtn = [MyUtil createBtnFrame:CGRectMake(10, 7, ScreenWidth/1.06, 36) image:@"sousuokuang@2x" selectedImage:nil target:self action:@selector(openSouchAction:)];
    
    [_TopHeaderView addSubview:Souchbtn];
    
    
    
    
    
    
    //上层线条
    
    UIImageView *TopLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 50, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_TopHeaderView addSubview:TopLine];
    
    
    
    
    
    
    
}


-(void)openSouchAction:(UIButton *)sender
{
    
    
//    
//    SearchViewController *mngCtrl = [[SearchViewController alloc]init];
//    
//    [self.navigationController pushViewController:mngCtrl animated:YES];
    
    
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
        return 1;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
    
    
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

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _tableView) {
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, ScreenWidth, 35);
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 5, 70, 30) title:@"所有商品" textAlignment:NSTextAlignmentLeft];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithRed:165.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1];
        
        [bgView addSubview:label];
        
        //线条
        CGRect  Lowframe = CGRectMake(0, 35, ScreenWidth, 0.5);
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
        [bgView addSubview:Lowimage];
        
        //线条
        CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
        UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
        [bgView addSubview:Lowimage1];
        
        
        return bgView;
        
    }else
    {
        return nil;
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (tableView == _tableView) {
        
        MemberDetailViewController *memberCtrl = [[MemberDetailViewController alloc]init];
        
        MemberModel *model = self.dataArray[indexPath.row];
        
        
        memberCtrl.storeId =model.StoreID;
        
        
        memberCtrl.cardType = model.CardType;
        
        [self.navigationController pushViewController:memberCtrl animated:YES];
        
        
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    // static NSString *popCellID = @"popCellID";
    static NSString *TwoCellID = @"TwoCellID";
    if (tableView == _tableView) {
        MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            
            //箭头
            UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 41, 10, 15) imageName:@"my_arrow_17X30@2x"];
            [cell addSubview:arrowImage];
            
        }
        
        MemberModel *cellModel = self.dataArray[indexPath.row];
        
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




#pragma mark --下载(有两个参数没有取值)

-(void)download
{
    _cardType = @"09ec8d0a9cd545f9827381702ed27cba";
    _storeID = @"0d6a1411d71b4643bdc5c13c1e8af117";
    
    [self juhua];
    NSString *str = [NSString stringWithFormat:@GetAllMemberCardToListUrl];
    
    NSDictionary * params = @{@"entId":_EntID,@"storeId":_storeID,@"cardType":_cardType,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"6" AndType:CacheTypeQuestion];
         
         
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
                 
                 
                 [_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                     NSLog(@"======%ld",self.dataArray.count);
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


-(void)downloadMore
{
    
    NSLog(@"%@",_storeID);
    NSLog(@"%@",currPagestr);
    
    _cardType = @"09ec8d0a9cd545f9827381702ed27cba";
    _storeID = @"0d6a1411d71b4643bdc5c13c1e8af117";

    
    [self juhua];
    NSString *str = [NSString stringWithFormat:@GetAllMemberCardToListUrl];
    
    NSDictionary * params = @{@"entId":_EntID,@"storeId":_storeID,@"cardType":_cardType,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"6" AndType:CacheTypeQuestion];
         
         
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
                 
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                     NSLog(@"======%ld",self.dataArray.count);
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






#pragma mark-缓存

-(void)Caches
{
    if ([CacheManager readCacheWithURLKey:@"6" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"6" andType:CacheTypeQuestion];
        
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
                
                
                for (NSDictionary *dict in arr1) {
                    
                    NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                    
                    NSLog(@"%@",sssDict);
                    
                    //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                    
                    MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                    
                    
                    [self.dataArray addObject:model];
                    NSLog(@"======%ld",self.dataArray.count);
                }
                [_tableView reloadData];
                
            }
        }
        
        
        
        
    }else
    {
        
        
        [self download];
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
                    
                    if ([CacheManager readCacheWithURLKey:@"6" andType:CacheTypeQuestion]!= nil) {
                        
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
                //                NSLog(@"wifi的网络");
                //                [self Caches];
                //                [HUD hide:YES];
                
                // [self downloadMoney];
                
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



////推出页面的时候让tababr
//-(void)viewWillAppear:(BOOL)animated
//{
//
//    [super viewWillAppear:animated];
//
//    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
//    [tabCtrl showTabBar];
//
//
//
//}
//
////将要返回的时候
//-(void)viewWillDisappear:(BOOL)animated
//{
//
//
//    [super viewWillDisappear:animated];
//
//    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
//    [tabCtrl showTabBar];
//
//}











- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
