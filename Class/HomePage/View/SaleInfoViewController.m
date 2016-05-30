//
//  SaleInfoViewController.m
//  guoping
//
//  Created by zhisu on 15/9/15.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SaleInfoViewController.h"
#import "SouchViewController.h"//搜索框
#import "SalesViewController.h"//详情页
#import "MainViewController.h"
#import "ChangeBtn.h"
#import "SalesInformationCell.h"
#import "SalesInformationModel.h"//list显示数据模型

#import "SalesMoneyView.h"//总金额
#import "SalesMoneyModel.h"
#import "SeNumberModel.h"//总笔数

#import "AllStoreCell.h"//popView显示数据
#import "AllStoreModel.h"

#import "AFHTTPSessionManager.h"

@interface SaleInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MBProgressHUDDelegate>
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
    
    ChangeBtn *_chgtn;//点击弹出选择view
    
    UISearchBar *_souch;//查找

    SalesMoneyView *_BarView;
    
    UIButton *_btnq;
    
    //店铺名
    NSString *bgyl;//店铺名
    NSString *EntID;//企业id
    NSString *date;//今日、本周、本月
    NSString *storeId;//店铺id
    
  
    //日期
    UILabel *Today;
    UILabel *Week;
    UILabel *Month;
    
    //菊花
    MBProgressHUD *HUD;
    
    //没有网络的背景图
    UIView *NotSigview;
    
    
    int currPageIndex;
    int s;
    NSString *currPagestr;

    
}

//@property(nonatomic,retain) FMDatabaseQueue *fmQueue;//添加一个队列属性

@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *StoreDataArray;//店铺的数据

@end

@implementation SaleInfoViewController


-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}
-(NSMutableArray *)StoreDataArray
{
    if (_StoreDataArray == nil) {
        
        self.StoreDataArray = [NSMutableArray array];
        
    }
    
    return _StoreDataArray;
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
  
//    // 清除缓存
//    NSString *path = [CacheManager cacheDirectory];
//    
//    NSLog(@"%@",path);
//    
//    NSFileManager* fileManager = [NSFileManager defaultManager];
//    NSArray* allCache = [fileManager contentsOfDirectoryAtPath:path error:nil];
//    NSLog(@"%@",allCache);
//    
//    
//    NSString *ssap = [allCache objectAtIndex:0];
//    
//    NSLog(@"%@",ssap);
//    
//    NSError *ser = nil;
//          [fileManager removeItemAtPath:ssap error:&ser];
//    
//    
//    if (ser) {
//        NSLog(@"move failed:%@",[ser localizedDescription]);
//    }

  
    
//    NSString *strID = [NSString stringWithFormat:@"%03d",3];
//    
//    EntID = strID;
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID= [df objectForKey:@"GUID"];
    
    NSString *Date = [NSString stringWithFormat:@"%d",1];
    
    date = Date;
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;

    //[self sharedClient];//检测实时的网络状况
    
    [self createTableview];
    
    [self createPoPviewTableview];
    
   
    [self downloadStore];
    
  
    

    [self createNav];
   

 
    [self createTabBarView];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
     _selectedButton = [ChangeBtn buttonWithType:UIButtonTypeSystem];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"销售信息"];
    
    
     [self hid];//隐藏刷新时间
    
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        

            [self loadData];
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
    
    if ([storeId isKindOfClass:[NSNull class]] || storeId == nil) {
    
        
       [_tableView.header endRefreshing];
        return;
        
      
        
    }else
    {

        currPagestr = [NSString stringWithFormat:@"%d",0];
        currPageIndex = s * 0;
        
        
        [self download];
        
        [self downloadMoney];
        [self downloadNumber];
        
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

-(void)backAction:(UIButton *)sender
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(void)createTableview
{

    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight-9) style:UITableViewStyleGrouped];
    
    
     _tableView.showsVerticalScrollIndicator =NO;
   // _tableView.backgroundColor = [UIColor redColor];
    
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    [self.view addSubview:_tableView];
 
    
    
    _TopHeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    _TopHeaderView.backgroundColor = [UIColor whiteColor];
    _tableView.tableHeaderView = _TopHeaderView;
    


    
}


#pragma maek -popViewTableview
-(void)createPoPviewTableview
{
    
    _view= [[UIView alloc]init];
    _view.frame = CGRectMake(0,110, ScreenWidth, 0);
    _view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
    _view.clipsToBounds = YES;//截断
    [self.view  addSubview:_view];
    
    
    _popViewTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
   // _popViewTableview.backgroundColor = [UIColor blackColor];
    
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
    

    
    NSLog(@"%@",bgyl);
    
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
            
            [_chgtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:150.0/255.0 blue:61.0/255.0 alpha:1] forState:UIControlStateSelected];
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
    
    SouchViewController *SouchCtrl = [[SouchViewController alloc]init];
    
    [self.navigationController pushViewController:SouchCtrl animated:YES];
    
}



#pragma mark FC合计折扣
#pragma  mark -合计金额
-(void)createTabBarView
{
    _BarView= [[SalesMoneyView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 90)];
    
    _BarView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
    
    
    
    UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(12, 10, 25, 25) imageName:@"wallet@2x"];
    
    
    [_BarView addSubview:image];
    
    
    UIImageView *imageNumber1 = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.80, 10, 27, 27) imageName:@"yen@2x"];
    
    
    [_BarView addSubview:imageNumber1];
    
    
    UIImageView *imageNumber2 = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/1.46, 10, 27, 27) imageName:@"sale@2x"];
    
    
    [_BarView addSubview:imageNumber2];
    
    
    UIImageView *imageLine1 = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/3, 10, 1, 35) imageName:@"line@2x"];
    
    
    [_BarView addSubview:imageLine1];
    
    
    UIImageView *imageLine2 = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/1.5, 10, 1, 35) imageName:@"line@2x"];
    
    
    [_BarView addSubview:imageLine2];
    
    
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/8.0,6,70,20) title:@"销售笔数" textAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor blackColor];
    label.font =[UIFont systemFontOfSize:15];
    [_BarView addSubview:label];
    
    
    UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.35,6,70,20) title:@"合计金额" textAlignment:NSTextAlignmentCenter];
    label1.textColor = [UIColor blackColor];
    label1.font =[UIFont systemFontOfSize:15];
    [_BarView addSubview:label1];
    
    
    UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.33,6,70,20) title:@"折扣总和" textAlignment:NSTextAlignmentCenter];
    label2.textColor = [UIColor blackColor];
    label2.font =[UIFont systemFontOfSize:15];
    [_BarView addSubview:label2];
    
    
    
    [self  Money];
    
    
    
    
    [self.view addSubview:_BarView];
    
    
    
    
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
        
        SalesViewController *SalesCtrl = [[SalesViewController alloc]init];
        
        SalesInformationModel *model = self.dataArray[indexPath.row];
        SalesCtrl.saleId = model.GUID;
        SalesCtrl.storeMoney = model.totalmoney.stringValue;//该值传递给下一个控制器进行显示
  
        

        SalesCtrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.navigationController pushViewController:SalesCtrl animated:YES];
        
        
        [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中状态
        
    }else if (tableView == _popViewTableview)
    {
        

        
        NSArray *arr = [_TopHeaderView subviews];
        
        NSLog(@"%@",arr);
        
        
        for (_chgtn in arr) {
            
            
            if (_chgtn.tag == 10) {
            
      
                NSLog(@"%@",_chgtn);
  
                //点击cell 修改 btn 文字 并下载数据
                AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];
                
                EntID = cellModel.EnterpriseID;
                bgyl = cellModel.StoreName;
             
                storeId = cellModel.GUID;
                NSLog(@"%@",bgyl);
                 NSLog(@"%@",EntID);
                 NSLog(@"%@",storeId);
   
                //选择店铺的时候，下载所选店铺的数据
                [self download];
                [self downloadMoney];
                [self downloadNumber];
        
  
                  [_chgtn setTitle:bgyl forState:UIControlStateNormal];
                
                //改变的时候缩回 然后 下载
                [self changes];
                
                
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
                    [self downloadMoney];
                    [self downloadNumber];
                    
                    
                }else if (indexPath.row == 1)
                {
                    
                    NSString *str = [NSString stringWithFormat:@"%@", Week.text];
                    
                    [_chgtn setTitle:str forState:UIControlStateNormal];
                    NSString *strDate = [NSString stringWithFormat:@"%d",2];
                    date = strDate;
                     //选择日期的时候，下载所选日期的的数据
                    [self download];
                    [self downloadMoney];
                    [self downloadNumber];
                   
                    
                }else if (indexPath.row == 2)
                {
                    
                    NSString *str = [NSString stringWithFormat:@"%@", Month.text];
                    
                    [_chgtn setTitle:str forState:UIControlStateNormal];
                    NSString *strDate = [NSString stringWithFormat:@"%d",3];
                    date = strDate;
                     //选择日期的时候，下载所选日期的的数据
                    [self download];
                    [self downloadMoney];
                    [self downloadNumber];
                    
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
        SalesInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[SalesInformationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
 
            //线条
                    CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
                  UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
                  [cell addSubview:Lowimage];
            
            
            
            UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 41, 10, 15) imageName:@"my_arrow_17X30@2x"];
            [cell addSubview:arrowImage];
     
     
            

        }
   
    
         SalesInformationModel *cellModel = self.dataArray[indexPath.row];
    
    
          cell.cellModel =cellModel;
        

    
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
        
        bgyl = cellModel.StoreName;
        NSLog(@"%@",bgyl);
    
        
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
    
    //显示的时候禁用tableview滚动
    _tableView.scrollEnabled = NO;
//        _selectedButton.selected = NO;
//
//    btn.selected = YES;
//    
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
    
    
    if (_chgtn.tag == 10) {
        
        _btnq= [[UIButton alloc]init];
        
        _btnq = _chgtn;
        
    }

    
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
                [_lastBtn setImage:[UIImage imageNamed:@"shoplist_down_icon_jax"] forState:UIControlStateNormal];
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
    
    //如果显示就变绿，没有显示就变灰
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
 
  
    
    if (_isShow) {
         [self changes];
        
        
        //显示的时候启用tableview滚动
        _tableView.scrollEnabled = YES;
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
                    
                    
                    
                    if (self.dataArray == nil) {
                        
                        NSLog(@"没空");
                      
                    }else
                    {
                        
                      
                        NSLog(@"空了");
                        
                        if ([CacheManager readCacheWithURLKey:@"0" andType:CacheTypeQuestion]) {
                            
                            NSLog(@"在无网情况下，判断db 是否为空。");
                            
                        }else
                        {
                            [HUD hide:YES];
                            NotSigview= [[UIView alloc]init];
                            NotSigview.frame = CGRectMake(0, 90, ScreenWidth, ScreenHeight);
                            
                            [self createbtn];
                            [_tableView addSubview:NotSigview];
                            NSLog(@"不可达的网络(未连接)");
                        }
                        
                     
                    }
       
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    
                    NSLog(@"2G,3G,4G...的网络");
                    break;
                    
                case AFNetworkReachabilityStatusReachableViaWiFi:
                {
//                      NSLog(@"wifi的网络");
//                     [HUD hide:YES];
//                    //[self queryData];
//               
//                    [self downloadMoney];
                    
                    
                }
                  
                    break;
                default:
                    break;
            }
        }];
        //3.开始监听
        [manager startMonitoring];
    
    
    
    
}


#pragma mark --下载店铺

-(void)downloadStore
{
    
    
 
    //[self CachesStore];
    

    
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
    
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 
                 if (arr1.count == 0) {
                     
                     return ;
                 }
                 
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                 
                     //[self.StoreDataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     AllStoreModel *model = [[[AllStoreModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     NSLog(@"%@",bgyl);
                     
                     [self.StoreDataArray addObject:model];
                     NSLog(@"======%ld",self.StoreDataArray.count);
                     
                     
                     
                     //判断断网的时候，店铺名是否为空。如果空的，代表数据缓存清除了。那么_TopHeaderView,就没有加载过。防止
                     bgyl = model.StoreName;
                     storeId = model.GUID;
                     
             
                     
                 }
                 
                 
                 [_popViewTableview  reloadData];
       
                 [self createScan];
                 
                 
                 //自动选择店铺
                 if ([_popViewTableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                     
                     NSArray *arr = [_TopHeaderView subviews];
                     
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




#pragma mark --下载 and 下拉刷新
/**
 *
 *   接口样例:
 *
      {  "Mobile": "343434",
         "GUID": "e2eea4d075e44787b730b57f6bb35088",
         "SaleNo": "031604130002",
         "UpdateUser": "",
         "UpdateTime": null,
         "CreateUser": "ec828d50d9a24507aef40a3fafb4b83c",
         "CreateTime": "2016-05-13 08:45:07",
         "IsDelete": 0,
         "TotalMoney": 27.00,
         "TotalUnitNum": null,
         "SaleDate": "2016-05-13 08:45:07",
         "StoreID": "0d6a1411d71b4643bdc5c13c1e8af117",
         "StoreName": "嘉客来水果大华二路店",
         "UploadUpdateTime": null,
         "UploadCreateTime": null,
         "SourceID": null,
         "EnterpriseID": null,
         "CutOffType": 0,
         "CutOff": null,
         "MemberID": null,
         "TotalCutOff": 4.40  },
 *
 *
 */
-(void)download
{
  
    [self juhua];
    
  
    //1.先查询本地缓存数据，刷新界面，把缓存数据删除。2.走接口，下载数据，缓存到本地，刷新界面。
//    从逻辑上来说 不是要先判断缓存  是要先判断是不是要刷新页面   刷新页面之前先用缓存刷新界面 。 如果走了接口在用接口返回的数据在去刷新界面。
//    第二次刷新界面的时候 数据要缓存 覆盖上一次的数据
    
    //判断是不是要刷新页面   刷新页面之前先用缓存刷新界面
    //[self Caches];
    
#pragma mark 数据解析
 
    
    NSString *str = [NSString stringWithFormat:@GetSaleListByPageUrl];
    
    NSDictionary * params = @{@"storeId":storeId,@"dateType":date,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         
      
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"0" AndType:CacheTypeQuestion];
         
         
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
                     
                 
         
                     
                     SalesInformationModel *model = [[[SalesInformationModel alloc]init]initWithDictionary:sssDict];
                
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

//上拉加载更多 list 页
-(void)loadMoredata
{
    
    //[self juhua];
    
//    NSLog(@"%@",EntID);
//        NSLog(@"%@",date);
    
    //1.先查询本地缓存数据，刷新界面，把缓存数据删除。2.走接口，下载数据，缓存到本地，刷新界面。
    //    从逻辑上来说 不是要先判断缓存  是要先判断是不是要刷新页面   刷新页面之前先用缓存刷新界面 。 如果走了接口在用接口返回的数据在去刷新界面。
    //    第二次刷新界面的时候 数据要缓存 覆盖上一次的数据
    
    //判断是不是要刷新页面   刷新页面之前先用缓存刷新界面
    
       // [self Cachess];

   
    
    //删除指定沙盒文件，上拉加载更多时，先删除缓存。然后加载更新tableview，然后下载更新tableview。
    //                         NSFileManager* fileManager = [NSFileManager defaultManager];
    //
    //                         NSString *path = [CacheManager cacheDirectory];
    //
    //                         NSString *ssap = [NSString stringWithFormat:@"%@/-1",path];
    //
    //                         if ([fileManager fileExistsAtPath:ssap]) {
    //                             NSLog(@"存在");
    //
    //                             [fileManager removeItemAtPath:ssap error:nil];
    //
    //                         }
    




    
    NSString *str = [NSString stringWithFormat:@GetSaleListByPageUrl];
    
    NSDictionary * params = @{@"storeId":storeId,@"dateType":date,@"currPageIndex":currPagestr,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         
         
         //保存下载的数据用于缓存
         //[CacheManager saveCacheWithObject:responseObject ForURLKey:@"-1" AndType:CacheTypeQuestion];
         
         
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
                 
                //[self.dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 
                 if (arr1.count == 0) {
                     
                     NSLog(@"空");
                     
                     
                     
                     //[HUD hide:YES];
                    
                 }
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
            
                     
                     
                     SalesInformationModel *model = [[[SalesInformationModel alloc]init]initWithDictionary:sssDict];
                     
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



#pragma mark --下载

-(void)downloadMoney
{
   
    
    [self Money];
    //[self deleteData];®
    
 
    
    NSString *str = [NSString stringWithFormat:@MoneyUrl];
    
    NSDictionary * params = @{@"storeId":storeId,@"dateType":date,@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"1" AndType:CacheTypeQuestion];
         
         NSError *error = nil;
         
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         
         NSLog(@"%@",dict);
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
                 NSDictionary *subDict2 = [subDict1 objectForKey:@"Data"];
                 NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:subDict2];
                 NSLog(@"%@",sssDict);
                 SalesMoneyModel *model = [[[SalesMoneyModel alloc]init]initWithDictionary:sssDict];

                 [_BarView setCellModel:model];
               
   
                 
             }
         }
         
         
     }
    failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


-(void)downloadNumber
{
    

    
    
    NSString *str = [NSString stringWithFormat:@GetSaleRecordCountUrl];
    
    NSDictionary * params = @{@"storeId":storeId,@"dateType":date,@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         
         NSError *error = nil;
         
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         
         NSLog(@"%@",dict);
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
                 
                 NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:subDict1];
                 
                 NSLog(@"%@",sssDict);
                 
                 
                 SeNumberModel *model1 = [[[SeNumberModel alloc]init]initWithDictionary:sssDict];
                 
                 [_BarView setCellModelNumber:model1];
                 
                 
                 
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

#pragma mark - 菊花加载

-(void)juhua
{
    HUD =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.userInteractionEnabled = NO;
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
  
    [self download];
    [self downloadStore];
    [self downloadMoney];
    [self downloadNumber];
    
    [HUD hide:YES];
    
   
}

#pragma mark-缓存

-(void)Caches
{
    
    if ([CacheManager readCacheWithURLKey:@"0" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"0" andType:CacheTypeQuestion];
        
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
                
                //[self.dataArray removeAllObjects];
                for (NSDictionary *dict in arr1) {
                    
                    NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                    
                    NSLog(@"%@",sssDict);
                    
                    
                    SalesInformationModel *model = [[[SalesInformationModel alloc]init]initWithDictionary:sssDict];
          
                    [self.dataArray addObject:model];
                    
 
                }
                [_tableView reloadData];
                 [HUD hide:YES];
        
            }
        }
        
    }
    
}
//-(void)Cachess
//{
//
//    
//
//
//    if ([CacheManager readCacheWithURLKey:@"-1" andType:CacheTypeQuestion]) {
//        
//        id result = [CacheManager readCacheWithURLKey:@"-1" andType:CacheTypeQuestion];
//        
//        NSError *error = nil;
//        
//        //xml解析
//        NSDictionary *dict = [XMLReader dictionaryForXMLData:result error:&error];
//        
//        NSLog(@"%@",dict);
//        //第一次分离
//        if ([dict isKindOfClass:[NSDictionary class]]) {
//            
//            NSDictionary *subDict = [dict objectForKey:@"string"];
//            NSString *str = [subDict objectForKey:@"text"];
//            NSLog(@"%@",str);
//            
//            
//            //字符串转化成data
//            NSData *jsData = [str dataUsingEncoding:NSUTF8StringEncoding];
//            
//            NSError *error;
//            
//            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableContainers error:&error];
//            
//            NSLog(@"%@",dic);
//            
//            
//            //第二次分离
//            if ([dic isKindOfClass:[NSDictionary class]]) {
//                
//                
//                NSDictionary *subDict1 = [dic objectForKey:@"Value"];
//                
//                NSArray *arr1 = [subDict1 objectForKey:@"Data"];
//                
//             
//                for (NSDictionary *dict in arr1) {
//                    
//                    NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
//                    
//                    NSLog(@"%@",sssDict);
//                    
//                    
//                    SalesInformationModel *model = [[[SalesInformationModel alloc]init]initWithDictionary:sssDict];
//                    
//                    [self.dataArray addObject:model];
//                    
//                    
//                }
//  
//                [_tableView reloadData];
// 
//                [HUD hide:YES];
//                
//            }
//        }
//        
//    }
//    
//}

-(void)CachesStore
{
   
    
    if ([CacheManager readCacheWithURLKey:@"8" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"8" andType:CacheTypeQuestion];
        
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
                
               // [self.StoreDataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据

                for (NSDictionary *dict in arr1) {
                    
                    NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                    
                    NSLog(@"%@",sssDict);
                    
                    //[self.StoreDataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                    
                    AllStoreModel *model = [[[AllStoreModel alloc]init]initWithDictionary:sssDict];
                    bgyl = model.StoreName;//店铺名
                    storeId = model.GUID;//店铺id
                 
                    
                    
                      [self.StoreDataArray addObject:model];
             
                    NSLog(@"%ld",self.StoreDataArray.count);
                    
          
                }
                    [self createScan];
                
                [_popViewTableview  reloadData];
                
            }
        }
        
    }
    
}


-(void)Money
{
    if ([CacheManager readCacheWithURLKey:@"1" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"1" andType:CacheTypeQuestion];
        
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
                NSDictionary *subDict2 = [subDict1 objectForKey:@"Data"];
                NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:subDict2];
                NSLog(@"%@",sssDict);
                SalesMoneyModel *model = [[[SalesMoneyModel alloc]init]initWithDictionary:sssDict];
                [_BarView setCellModel:model];
                
            }
        }
        
    }
}

#pragma mark -- 清除缓存
-(void)deleteData
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //清除缓存
        [CacheManager resetCache];
        
        
        
    });
}




@end
