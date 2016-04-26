//
//  RankingViewController.m
//  guoping
//
//  Created by zhisu on 15/9/18.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "RankingViewController.h"
#import "MainViewController.h"
#import "ChangeEndBtn.h"
#import "HMSegmentedControl.h"
#import "RankingCell.h"//店铺排行
#import "RankingModel.h"
#import "AllStoreCell.h"//全部店铺
#import "AllStoreModel.h"
@interface RankingViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    UITableView *_tableView;
    UITableView *_popViewTableview;
    
    UITableView *_LeftTableview;
    
    UITableView *_RightTableview;
    
    //UIView *_TopHeaderView;
    UIView *_HeaderView;
    UIView *_view;//弹出的透明遮罩
    
    UIButton *_chgtn;//点击弹出选择view
    
    
    ChangeEndBtn *_btnTag;
    BOOL _isShow;//有没有显示
    UIButton * _lastBtn;//上一个btn
    ChangeEndBtn *_selectedButton;//颜色赋给btn
    NSUInteger  _selectedIndex;//下标
    
    
    UIScrollView *_scrView;
     //UIButton *_TopTitlebtn;//顶部标题btn
      //UIButton *_Topbtn;//顶部btn
      //UIButton *_TopselectedTitle;
    // UIButton *_TopselectedBtn;
     NSInteger _index;//偏移量
    
    UIView *_slidvView;
    
    HMSegmentedControl *segmentedControl4;
    
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

@property (nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation RankingViewController

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
    EntID= [df objectForKey:@"GUID"];
    
    NSString *Date = [NSString stringWithFormat:@"%d",1];
    date = Date;
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    
    
    
    [self Caches];
    
    //[self download];
    [self createNav];
   
    //[self createTableview];
     [self createScrollerView];
    [self createPoPviewTableview];
    
  
    
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    _selectedButton = [ChangeEndBtn buttonWithType:UIButtonTypeSystem];


    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"店铺排行"];
    
    
    //top view
    _HeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, 89)];
    [self createScan];
      [self createTopBtn];
   // _HeaderView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_HeaderView];
    
    
    
}
 //水平滚动条
-(void)createTopBtn
{
    

    //水平滚动条
    segmentedControl4 = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    segmentedControl4.sectionTitles = @[@"店铺排行",@"损耗排行"];
    segmentedControl4.selectedSegmentIndex = 0;
    segmentedControl4.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:149.0/256.0 green:149.0/256.0 blue:149.0/256.0 alpha:1.0]};
    segmentedControl4.selectedTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor colorWithRed:0.0/255.0 green:148.0/255.0 blue:0.0/255.0 alpha:1]};
    segmentedControl4.selectionIndicatorColor =[UIColor colorWithRed:76.0/256.0 green:159.0/256.0 blue:53.0/256.0 alpha:1.0];
    segmentedControl4.selectionIndicatorHeight = 2.0f;
    segmentedControl4.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl4.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
 
    __weak typeof(self) weakSelf = self;
    [segmentedControl4 setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(ScreenWidth * index, 0, ScreenWidth, 200) animated:YES];
    }];
    
    [_HeaderView addSubview:segmentedControl4];
    
    
    
    
}

#pragma mark-创建滚动视图
-(void)createScrollerView
{
    
   self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 153, ScreenWidth, ScreenHeight-150)];
    
    
    self.scrollView.backgroundColor = [UIColor redColor];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth *2, ScreenHeight - 150);
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.delegate = self;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.scrollView];
    
    //tableview 左
    
    //_dataArray = [NSMutableArray array];
    _LeftTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-150) style:UITableViewStylePlain];
    
    
    //_LeftTableview.backgroundColor = [UIColor cyanColor];
    
    _LeftTableview.delegate = self;
    
    _LeftTableview.dataSource = self;
    
    [self.scrollView addSubview:_LeftTableview];
    
    
    
    //tableview 右
    
    _RightTableview = [[UITableView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight-150) style:UITableViewStylePlain];
   // _RightTableview.backgroundColor = [UIColor yellowColor];
    
    _RightTableview.delegate = self;
    _RightTableview.dataSource = self;
    _RightTableview.scrollEnabled = NO;
    
    
    [self.scrollView addSubview:_RightTableview];
    
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
   
    
    [UIView animateWithDuration:0.3 animations:^{
        _index = _scrView.contentOffset.x/_scrView.bounds.size.width;
        
        
        NSInteger page = scrollView.contentOffset.x / ScreenWidth;
        [segmentedControl4 setSelectedSegmentIndex:page animated:YES];
        
        
        
    } completion:^(BOOL finished) {
        
        
        
        
    }];

    

   
    
    
}


#pragma maek -popViewTableview
-(void)createPoPviewTableview

{
    
    _view= [[UIView alloc]init];
    _view.frame = CGRectMake(0,154, ScreenWidth, 0);
    _view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.4];
    _view.clipsToBounds = YES;//截断
    [self.view  addSubview:_view];
    
    
    _popViewTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
   // _popViewTableview.backgroundColor = [UIColor blackColor];
    
    _popViewTableview.delegate = self;
    _popViewTableview.dataSource = self;
    
    [_view addSubview:_popViewTableview];
    
    
    
    
}

#pragma mark--scan
-(void)createScan
{

    
    //上层线条
    
    UIImageView *TopLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 50, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_HeaderView addSubview:TopLine];
    
    
    //下面的线条
    UIImageView *LowLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 89, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_HeaderView addSubview:LowLine];
    
    
    
    CGRect frame = CGRectMake(ScreenWidth/2.344, 55, ScreenWidth/1.76, 30);
    
    _chgtn =[ChangeEndBtn buttonWithType:UIButtonTypeCustom];
    
   //_chgtn.backgroundColor = [UIColor redColor];
    _chgtn.frame = frame;
    
    [_chgtn setTitle:@"今天" forState:UIControlStateNormal];
    
    _chgtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
      // _chgtn.imageEdgeInsets = UIEdgeInsetsMake(50, 10, 20, 0);
    
    
    [_chgtn addTarget:self action:@selector(OpenView:) forControlEvents:UIControlEventTouchUpInside];
    [_HeaderView addSubview:_chgtn];
    
    
    _selectedIndex = 0;
    
    [_chgtn setTitleColor:[UIColor colorWithRed:71.0/255.0 green:161.0/255.0 blue:54.0/255.0 alpha:1] forState:UIControlStateSelected];
    [_chgtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
  
    [_chgtn setImage:[UIImage imageNamed:@"24x14_xiala"] forState:UIControlStateNormal];
    
   
    
    
    
}



-(void)OpenView:(ChangeEndBtn *)btn
{
    
    _btnTag = btn;
    
    [self changes];
    
    
    
    
    
}


-(void)changes
{
    
    _selectedButton.selected = NO;
    
    
    
    
    
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
        _tableView.scrollEnabled = NO;
    }
    
    _isShow ?(frame.size.height -= ScreenHeight) :(frame.size.height += ScreenHeight);
    
    //如果显示就变绿，没有显示就变灰
    if (!_isShow) {
        [_btnTag setImage:[UIImage imageNamed:@"24x14_famhui@2x"] forState:UIControlStateNormal];
        _btnTag.selected = YES;
    }else {
        [_btnTag setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
        _btnTag.selected = NO;
        
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if (_isShow) {
         [self changes];
    }
   
}


#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    
    if (tableView == _LeftTableview) {
        
        return self.dataArray.count;
        
    }else if(tableView == _RightTableview)
    {
        
        return 1;
    }else
    {
        return 3;
    }
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//    
//    
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _RightTableview) {
        
        return 530;
    }else
    {
        return 40;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView ==_tableView) {
        
        
         [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }else if (tableView == _popViewTableview)
    {
        
        NSArray *arr = [_HeaderView subviews];
        
        NSLog(@"%@",arr);
        
        
     
         
                
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
 
   
   
             static NSString *TwoCellID = @"TwoCellID";
    if (tableView == _tableView) {
        
           static NSString *cellID = @"cellID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
            
        }
        
        return cell;
        
        
    }else if (tableView == _popViewTableview)
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
                Today= [MyUtil createLabelFrame:CGRectMake(10, 10, 30, 30) title:@"今日" textAlignment:NSTextAlignmentLeft];
                
                Today.font = [UIFont systemFontOfSize:15];
                [cell addSubview:Today];
                
            }else if (indexPath.row == 1)
            {
                
                Week= [MyUtil createLabelFrame:CGRectMake(10, 10, 30, 30) title:@"本周" textAlignment:NSTextAlignmentLeft];
                
                Week.font = [UIFont systemFontOfSize:15];
                [cell addSubview:Week];
                
                
            }else
            {
                
                Month= [MyUtil createLabelFrame:CGRectMake(10, 10, 30, 30) title:@"本月" textAlignment:NSTextAlignmentLeft];
                
                Month.font = [UIFont systemFontOfSize:15];
                [cell addSubview:Month];
                
            }
            
            
            
        }
        
        return cell;

        
        
        
    }else if (tableView == _LeftTableview)
    {
         static NSString *LeftCellID = @"LeftCellID";
        RankingCell *Leftcell = [tableView dequeueReusableCellWithIdentifier:LeftCellID];
        
        
        if (Leftcell == nil) {
            Leftcell = [[RankingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LeftCellID];
            //判断数据里面有多少个店铺对象  然后利用店铺对象来排行
            for (int i = 1; i< self.dataArray.count+1; i++) {
                NSLog(@"%d",i);
             
                //然后根据i的值来判断 哪行
                if (indexPath.row == i-1) {
                    
                    UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(40, 15, 50, 10) title:[NSString stringWithFormat:@"%d.",i] textAlignment:NSTextAlignmentLeft];
                    label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
                    label1.font = [UIFont systemFontOfSize:15];
                    [Leftcell addSubview:label1];
                    
                    
                    //排名前三的👑
                    if (i == 1) {
                        
                        UIImageView *imgWang = [MyUtil createIamgeViewFrame:CGRectMake(10, 10, 20, 20) imageName:@"one"];
                        [Leftcell addSubview:imgWang];
                        
                    }else if (i == 2)
                        
                    {
                        UIImageView *imgWang = [MyUtil createIamgeViewFrame:CGRectMake(10, 10, 20, 20) imageName:@"two"];
                        [Leftcell addSubview:imgWang];
                        
                        
                    }else if (i == 3)
                        
                    {
                        UIImageView *imgWang = [MyUtil createIamgeViewFrame:CGRectMake(10, 10, 20, 20) imageName:@"three"];
                        [Leftcell addSubview:imgWang];
                        
                    }
                    
                    
                    
              
                }
                
   
            }
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 40, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [Leftcell addSubview:Lowimage];

        
            
            
        }
        
           _LeftTableview.separatorStyle = NO;
        
        RankingModel *cellModel = self.dataArray[indexPath.row];
        
        Leftcell.cellModel = cellModel;
        
        return Leftcell;
        
        
    }else
    {
        static NSString *RightCellID = @"RightCellID";
        
        UITableViewCell *Rightcell = [tableView dequeueReusableCellWithIdentifier:RightCellID];
        
        
        if (Rightcell == nil) {
            Rightcell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:RightCellID];
            
            
            //Rightcell.backgroundColor = [UIColor greenColor];
            
                _RightTableview.separatorStyle = NO;
            
            //喇叭
            UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.5, ScreenHeight/3.4, ScreenWidth/5.357, ScreenHeight/9.571) imageName:@"laba@2x"];
            [Rightcell addSubview:image];
            
            //即将开放
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.42, ScreenHeight/2.5, ScreenWidth/6.25, ScreenHeight/22.3) title:@"即将开放" textAlignment:NSTextAlignmentCenter];
            label.font = [UIFont systemFontOfSize:14];
            label.adjustsFontSizeToFitWidth = YES;
            [Rightcell addSubview:label];
            
            //敬请期待
            UILabel *jqLabel =[MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.42, ScreenHeight/2.3, ScreenWidth/6.25, ScreenHeight/22.3) title:@"敬请期待" textAlignment:NSTextAlignmentCenter];
            jqLabel.font = [UIFont systemFontOfSize:13];
            jqLabel.textColor = [UIColor grayColor];
            jqLabel.adjustsFontSizeToFitWidth = YES;
            [Rightcell addSubview:jqLabel];

            
            
            
        }
        
        return Rightcell;
        
        
        
        
        
    }
    
    
    
}



-(void)backAction:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}



#pragma mark --下载

-(void)download
{
    NSString *str = [NSString stringWithFormat:@GetStoreSaleTop10Url];
    
    NSDictionary * params = @{@"entId":EntID,@"dateType":date,@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"7" AndType:CacheTypeQuestion];
         
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
                     
                     
                     RankingModel *model = [[[RankingModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                     NSLog(@"======%ld",self.dataArray.count);
                 }
                 [_LeftTableview reloadData];
                 
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
    if ([CacheManager readCacheWithURLKey:@"7" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"7" andType:CacheTypeQuestion];

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
                    
                    RankingModel *model = [[[RankingModel alloc]init]initWithDictionary:sssDict];
                    
                    
                    [self.dataArray addObject:model];
                    NSLog(@"======%@",self.dataArray);
                }
                [_LeftTableview reloadData];
                
            }
        }

    }else
    {
        
        [self download];
    }
  
    
}

@end
