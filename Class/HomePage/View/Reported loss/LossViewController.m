//
//  LossViewController.m
//  guoping
//
//  Created by zhisu on 15/9/18.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "LossViewController.h"
#import "MainViewController.h"
#import "ChangeBtn.h"
#import "LossSouchViewController.h"
#import "LossInfoCell.h"
#import "LossInfoModel.h"//报损信息
#import "AllStoreCell.h"//全部店铺
#import "AllStoreModel.h"
@interface LossViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MBProgressHUDDelegate>
{
    
    ChangeBtn *_selectedButton;//颜色赋给btn
    
    UITableView *_tableView;
    UITableView *_popViewTableview;
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
    
    NSString *EntID;
    NSString *date;//今日、本周、本月
    NSString *bgyl;//店铺名
    NSString *storeID;//店铺id
    
    //日期
    UILabel *Today;
    UILabel *Week;
    UILabel *Month;
    
    
    int currPageIndex;
    int s;
    NSString *currPagestr;
    

}

@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *StoreDataArray;
@end



@implementation LossViewController

-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}

-(NSMutableArray *)StoreDataArray
{
    
    if (_StoreDataArray == nil) {
        
        _StoreDataArray = [NSMutableArray array];
        
    }
    
    return _StoreDataArray;
    
}




- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID= [df objectForKey:@"GUID"];
    
    NSString *Date = [NSString stringWithFormat:@"%d",1];
    date = Date;
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    
    [self sharedClient];
    
    [self downloadStore];
    
    
    //[self Caches];
  
    [self createNav];
    [self createTableview];
    [self createPoPviewTableview];
    
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    _selectedButton = [ChangeBtn buttonWithType:UIButtonTypeSystem];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"报损信息"];
    
    
    
    
    [self hid];//隐藏刷新时间
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        
        [self loadData];
        [self downloadMore];
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
    
    
    
    if ([storeID isKindOfClass:[NSNull class]] || storeID == nil) {
        
        
        [_tableView.header endRefreshing];
        return;
        
        
        
    }else
    {
        
    
    currPagestr = [NSString stringWithFormat:@"%d",0];
    currPageIndex = s * 0;
    
  
    [self download];
    [_tableView.header endRefreshing];
        
    }
    
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
    _tableView.showsVerticalScrollIndicator =NO;
    
    //_tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    
    _TopHeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 20, ScreenWidth, 45)];
    
    
    _TopHeaderView.backgroundColor = [UIColor whiteColor];
    
    //[self createScan];
    
    
    
    _tableView.tableHeaderView = _TopHeaderView;
    
    
    
    
    
    
    
}


#pragma maek -popViewTableview
-(void)createPoPviewTableview
{
    
    _view= [[UIView alloc]init];
    _view.frame = CGRectMake(0,111, ScreenWidth, 0);
    _view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    _view.clipsToBounds = YES;//截断
    [self.view  addSubview:_view];
    
    
    _popViewTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    _popViewTableview.delegate = self;
    _popViewTableview.dataSource = self;
    
    [_view addSubview:_popViewTableview];
    
    
    _TwoPopViewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,250) style:UITableViewStylePlain];
    
    _TwoPopViewTableView.delegate = self;
    _TwoPopViewTableView.dataSource = self;
    [_view addSubview:_TwoPopViewTableView];
    
    
    
}




#pragma mark--scan
-(void)createScan
{
    
    //上层线条
    
    UIImageView *TopLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 0, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_TopHeaderView addSubview:TopLine];
    
    //中间的线条
    UIButton  *Linebtn = [MyUtil createBtnFrame:CGRectMake(ScreenWidth/2.01, 10, 0.5, 25) image:nil selectedImage:nil target:nil action:nil];
    
    Linebtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1];
    
    [_TopHeaderView addSubview:Linebtn];
    
    //下面的线条
    UIImageView *LowLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 45, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_TopHeaderView addSubview:LowLine];
    
    
    
    NSArray *images = @[@"24x14_xiala@2x",@"24x14_xiala@2x"];
    
    NSArray *titles = @[bgyl,@"今日"];
    
    CGFloat width = ScreenWidth/2;
    
    for (int i= 0; i<titles.count; i++) {
        
        CGRect frame = CGRectMake((width*(i%2)+ScreenWidth/12.5), 10, ScreenWidth/3, 30);
        
        _chgtn =[ChangeBtn buttonWithType:UIButtonTypeCustom];
        
        //_chgtn.backgroundColor = [UIColor redColor];
        _chgtn.frame = frame;
        [_chgtn setTitle:titles[i] forState:UIControlStateNormal];
        
        _chgtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        
        [_chgtn addTarget:self action:@selector(OpenView:) forControlEvents:UIControlEventTouchUpInside];
        [_TopHeaderView addSubview:_chgtn];
        
        _selectedIndex = 0;
        
        [_chgtn setTitleColor:[UIColor colorWithRed:71.0/255.0 green:161.0/255.0 blue:54.0/255.0 alpha:1] forState:UIControlStateSelected];
        [_chgtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_chgtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        _chgtn.tag = 10+i;
        
    }
    
    
}

-(void)playScan:(UIButton *)sender
{
    NSLog(@"扫描");
}

-(void)openSouchAction:(UIButton *)sender
{
    
    NSLog(@"搜索");
    
    LossSouchViewController *stockShCtrl = [[LossSouchViewController alloc]init];
    
    [self.navigationController pushViewController:stockShCtrl animated:YES];
    
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
    }else if (tableView == _popViewTableview)
    {
        return self.StoreDataArray.count;
        
    }else if (tableView == _TwoPopViewTableView)
    {
        return 3;
    }else
    {
        return 1;
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

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [_souch  resignFirstResponder];
   
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == _tableView) {
   [tableView deselectRowAtIndexPath:indexPath animated:NO];
        
    }else if (tableView == _popViewTableview)
    {
        
        
        
        NSArray *arr = [_TopHeaderView subviews];
        
        NSLog(@"%@",arr);
        
        
        for (_chgtn in arr) {
            
            
            if (_chgtn.tag == 10) {
                
                
                NSLog(@"%@",_chgtn);
                
                //点击cell 修改 btn 文字 并下载数据
                AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];
                
                //EntID = cellModel.EnterpriseID;
                bgyl = cellModel.StoreName;
                storeID = cellModel.GUID;
        
                NSLog(@"%@",bgyl);
    
                NSLog(@"%@",storeID);
                
            
                
                
                [_chgtn setTitle:bgyl forState:UIControlStateNormal];
                
                //改变的时候缩回 然后 下载
                [self changes];
                [self download];
                
                
            }
            
        }
   
        
    }else if (tableView == _TwoPopViewTableView)
    {
        
        NSArray *arr = [_TopHeaderView subviews];
        
        NSLog(@"%@",arr);
        
        
        for (_chgtn in arr) {
            
            
            if (_chgtn.tag == 11) {
                
                
                if (indexPath.row == 0) {
                    
                    
                    NSString *str = [NSString stringWithFormat:@"%@",Today.text];
                    
                    [_chgtn setTitle:str forState:UIControlStateNormal];
                    
                    NSString *strDate = [NSString stringWithFormat:@"%d",1];
                    date = strDate;
                    //选择日期的时候，下载所选日期的的数据
                    [self download];
        
                    
                    
                }else if (indexPath.row == 1)
                {
                    
                    NSString *str = [NSString stringWithFormat:@"%@", Week.text];
                    
                    [_chgtn setTitle:str forState:UIControlStateNormal];
                    NSString *strDate = [NSString stringWithFormat:@"%d",2];
                    date = strDate;
                    //选择日期的时候，下载所选日期的的数据
                    [self download];
             
                    
                    
                }else if (indexPath.row == 2)
                {
                    
                    NSString *str = [NSString stringWithFormat:@"%@", Month.text];
                    
                    [_chgtn setTitle:str forState:UIControlStateNormal];
                    NSString *strDate = [NSString stringWithFormat:@"%d",3];
                    date = strDate;
                    //选择日期的时候，下载所选日期的的数据
                    [self download];
               
                    
                }
                
                
                //改变的时候缩回 然后 下载
                [self changes];
                
                
            }
            
        }
        
        
        
        
        
    }
    

    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    static NSString *popCellID = @"popCellID";
    static NSString *TwoCellID = @"TwoCellID";
    if (tableView == _tableView) {
        LossInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[LossInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];

            
 
        
            
        }
        
        LossInfoModel *cellModel = self.dataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        
        return cell;
        
        
    }else if (tableView == _popViewTableview)
    {
        
        AllStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:popCellID];
        
        
        if (cell == nil) {
            cell = [[AllStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:popCellID];
            
            //            //线条
            //            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            //            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            //            [cell addSubview:Lowimage];
            
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];
        
        cell.cellModel = cellModel;

        
        return cell;
        
        
    }else
    {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoCellID];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellID];
            
            //            //线条
            //            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            //            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            //            [cell addSubview:Lowimage];
            
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            
            if (indexPath.row == 0) {
                Today= [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"今日" textAlignment:NSTextAlignmentLeft];
                
                Today.font = [UIFont systemFontOfSize:15];
                [cell addSubview:Today];
                
            }else if (indexPath.row == 1)
            {
                
                Week= [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"本周" textAlignment:NSTextAlignmentLeft];
                
                Week.font = [UIFont systemFontOfSize:15];
                [cell addSubview:Week];
                
                
            }else
            {
                
                Month= [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"本月" textAlignment:NSTextAlignmentLeft];
                
                Month.font = [UIFont systemFontOfSize:15];
                [cell addSubview:Month];
                
            }
            
            
            
        }
        
        return cell;

        
        
        
    }
    
    
    
}



-(void)OpenView:(ChangeBtn *)btn
{
    
    _tableView.scrollEnabled = NO;
    
    switch (btn.tag-10) {
        case 0:
        {
            
            
            
            _TwoPopViewTableView.hidden = YES;
            _popViewTableview.hidden = NO;
            NSLog(@"%ld",btn.tag);
            
        }
            break;
            
        case 1:
        {
            _popViewTableview.hidden = YES;
            _TwoPopViewTableView.hidden = NO;
            NSLog(@"%ld",btn.tag);
            
        }
            break;
            
        default:
            break;
    }
    
    _btnTag = btn;
    
    
    [self changes];
    
    
    
}


-(void)changes
{
    
    _selectedButton.selected = NO;
    
    _btnTag.selected = YES;
    
    
    
    CGRect frame = _view.frame;
    
    //判断现在点击的btn ，如果上个btn显示就把它收起来
    if (_lastBtn && _lastBtn != _btnTag) {
        if (_isShow) {
            frame.size.height -= ScreenHeight;
            _view.frame = frame;
            //判断最后一个btn是否收起 如果收起就变灰色的箭头
            [_lastBtn setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
            _isShow = NO;
        }
    }
    //设置动画时间
    CGFloat duration = 0.35f;
    if (!_isShow) {
        duration = 0.65f;
        //显示的时候禁用tableview滚动
        //_tableView.scrollEnabled = NO;
    }
    
    _isShow ?(frame.size.height -= ScreenHeight) :(frame.size.height += ScreenHeight);
    
    //如果显示就变红，没有显示就变灰
    if (!_isShow) {
        [_btnTag setImage:[UIImage imageNamed:@"24x14_famhui@2x"] forState:UIControlStateNormal];
    }else {
        [_btnTag setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
        _tableView.scrollEnabled = YES;
    }
    
    //引用计数加1
    __weak typeof (_view) weakView = _view;
    
    //缩回动画
    [UIView animateWithDuration:duration animations:^{
        weakView.frame = frame;
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    //动画执行完成后，就不显示
    _isShow = !_isShow;
    _lastBtn = _btnTag;
    
    _selectedButton =_btnTag;
    
    
    
    
    
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    NSLog(@"触摸");
    if (_isShow) {
        
        [self changes];
        _tableView.scrollEnabled = YES;
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
    

    
    NSString *str = [NSString stringWithFormat:@GetWastageListByPageUrl];
    
    NSDictionary * params = @{@"storeId":storeID,@"dateType":date,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {

         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"4" AndType:CacheTypeQuestion];
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
                   
                         
                         LossInfoModel *model = [[[LossInfoModel alloc]init]initWithDictionary:sssDict];
                         
                         
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


-(void)downloadMore
{

    
    NSString *str = [NSString stringWithFormat:@GetWastageListByPageUrl];
    
    NSDictionary * params = @{@"storeId":storeID,@"dateType":date,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"4" AndType:CacheTypeQuestion];
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
                 
                 //[self.dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     
                     
                     LossInfoModel *model = [[[LossInfoModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                     NSLog(@"======%ld",self.dataArray.count);
                 }
                 [_tableView reloadData];
                 NotSigview.hidden = YES;//隐藏无网络视图
            
             }
         }
         
         
         // }
         
         
         
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


#pragma mark --下载店铺

-(void)downloadStore
{

    
    NSString *str = [NSString stringWithFormat:@GetAllStoreListUrl];
    
    NSDictionary * params = @{@"entId":EntID,@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"8" AndType:CacheTypeQuestion];
         
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
                 
                 if (arr1.count == 0) {
                     
                     return ;
                 }
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     //[self.StoreDataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     AllStoreModel *model = [[[AllStoreModel alloc]init]initWithDictionary:sssDict];
                     bgyl = model.StoreName;
                     
       
                     [self.StoreDataArray addObject:model];
                     NSLog(@"======%ld",self.StoreDataArray.count);
                     
                     
                     
                     
                     
                 }
                 
                    [self createScan];
                 [_popViewTableview  reloadData];
                 
                 //自动选择店铺
                 if ([_popViewTableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                     
                     NSArray *arr = [_TopHeaderView subviews];
                     
                     NSLog(@"%@",arr);
                     
                     
                     for (_chgtn in arr) {
                         
                         if (_chgtn.tag == 10) {
                             
                             NSInteger selectedIndex = 0;
                             NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
                             [_popViewTableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
                             [_popViewTableview.delegate tableView:_popViewTableview didSelectRowAtIndexPath:selectedIndexPath];
                             
                             [self changes];
                             
                         }
                     }
                     
                 }

              
                 
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
    if ([CacheManager readCacheWithURLKey:@"4" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"4" andType:CacheTypeQuestion];
        
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
                    

                    
                    LossInfoModel *model = [[[LossInfoModel alloc]init]initWithDictionary:sssDict];
                    
                    
                    [self.dataArray addObject:model];
              
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
                    
                    if ([CacheManager readCacheWithURLKey:@"4" andType:CacheTypeQuestion]!= nil) {
                        
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
//                 [HUD hide:YES];
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



@end
