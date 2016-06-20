//
//  CheckGoodsViewController.m
//  guoping
//
//  Created by zhisu on 16/6/12.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "CheckGoodsViewController.h"
#import "MainViewController.h"
#import "ChangeBtn.h"

@interface CheckGoodsViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mainTableView;         //mainTableView
    UIView *truncationView;             //截断view(弹出的透明遮罩)
    UITableView *leftPopoverTableView;  //左侧弹出的tableview
    UITableView *rightPopoverTableView; //右侧弹出的tableview
    
    ChangeBtn *dropdownBtn;               //点击弹出选择view
    
    NSString *store;    //店铺名
    NSString *date;     //今日、本周、本月
}
@property(nonatomic,retain)NSMutableArray *dataArray;

@end

@implementation CheckGoodsViewController


#pragma mark __________________________懒加载_____________________________
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self download];
    [self configureUI];
}


#pragma mark __________________________创建UI_____________________________
- (void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"门店盘点"];
    
    [self createTableview];
    [self createPopoverTableview];
}

- (void)createTableview
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+45, ScreenWidth, ScreenHeight-64-45) style:UITableViewStylePlain];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainTableView];
}

- (void)createPopoverTableview
{
    //1.创建下拉按钮changeBtn
    [self createChangeBtn];
    
    //2.线条
    //上层线条
    UIImageView *topLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 64, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:topLine];
    //中间线条
    UIButton *lineBtn = [MyUtil createBtnFrame:CGRectMake(ScreenWidth/2.01, 64+10, 0.5, 25) image:nil selectedImage:nil target:nil action:nil];
    lineBtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1];
    [self.view addSubview:lineBtn];
    //下面线条
    UIImageView *lowLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 64+45, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:lowLine];
    
    //3.创建用来截取子视图的truncation view
    truncationView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+45, ScreenWidth, 0)];
    truncationView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    truncationView.clipsToBounds = YES;//截断
    [self.view addSubview:truncationView];
    
    //4.创建左边的leftPopoverTableview
    leftPopoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    leftPopoverTableView.dataSource = self;
    leftPopoverTableView.delegate = self;
    [truncationView addSubview:leftPopoverTableView];
    
    //5.创建右边的rightPopoverTableview
    rightPopoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    rightPopoverTableView.dataSource = self;
    rightPopoverTableView.delegate = self;
    [truncationView addSubview:rightPopoverTableView];
}

- (void)createChangeBtn
{
    //NSArray *titles = @[store,date];
    NSArray *titles = @[@"全部商店",@"所有日期"];
    for (int i = 0; i < titles.count; i++) {
        dropdownBtn = [ChangeBtn buttonWithType:UIButtonTypeCustom];//注意：该语句是创建了一个新的Btn相当于alloc和init
        dropdownBtn.frame = CGRectMake((ScreenWidth/2)*(i%2)+ScreenWidth/12.5, 64+10, ScreenWidth/3, 30);
        [dropdownBtn setTitle:titles[i] forState:UIControlStateNormal];
        dropdownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [dropdownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [dropdownBtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:150.0/255.0 blue:61.0/255.0 alpha:1] forState:UIControlStateSelected];
        [dropdownBtn setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
        [self.view addSubview:dropdownBtn];
        
        [dropdownBtn addTarget:self action:@selector(openView:) forControlEvents:UIControlEventTouchUpInside];
        
        dropdownBtn.tag = i;
    }
}


#pragma mark __________________________UITableViewDataSource_____________________________
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    
    if (mainTableView == tableView) {
        num = 30;
    } else if (leftPopoverTableView == tableView) {
        num = 3;
    } else if (rightPopoverTableView == tableView) {
        num = 10;
    }
    
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (mainTableView == tableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"查询数据－－－[%ld]", indexPath.row];
    } else if (leftPopoverTableView == tableView) {
        cell.contentView.backgroundColor = [UIColor redColor];
        cell.textLabel.text = [NSString stringWithFormat:@"左边的表格－－－[%ld]", indexPath.row];
    } else if (rightPopoverTableView == tableView) {
        cell.contentView.backgroundColor = [UIColor blueColor];
        cell.textLabel.text = [NSString stringWithFormat:@"右边的表格－－－[%ld]", indexPath.row];
    }
    
    return cell;
}


#pragma mark __________________________UITableViewDelegate_____________________________
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}


#pragma mark __________________________点击事件_____________________________
- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openView:(ChangeBtn *)btn
{
    //1.点击Btn初始化所有btn状态并设置当前btn,关闭mainTableView滚动
    for (ChangeBtn *dropdown in [self.view subviews]) {
        if ([dropdown isKindOfClass:[ChangeBtn class]]) {
            dropdown.selected = NO;
        }
    }
    btn.selected = YES;
    mainTableView.scrollEnabled = NO;
    //2.通过改变truncationView.frame来控制popoverTableView是否显示出来
    CGRect frame = truncationView.frame;
    //3.判断点击的是哪一个btn按需显示对应的view
    switch (btn.tag) {
        case 0:
        {
            if (frame.size.height == 0) {
                leftPopoverTableView.hidden = NO;
                rightPopoverTableView.hidden = YES;
                frame.size.height += ScreenHeight-64-45;
            } else if (!rightPopoverTableView.hidden) {
                leftPopoverTableView.hidden = NO;
                rightPopoverTableView.hidden = YES;
                frame = frame;
            } else {
                frame.size.height -= ScreenHeight-64-45;
            }
        }
            break;
            
        case 1:
        {
            if (frame.size.height == 0) {
                leftPopoverTableView.hidden = YES;
                rightPopoverTableView.hidden = NO;
                frame.size.height += ScreenHeight-64-45;
            } else if (!leftPopoverTableView.hidden) {
                leftPopoverTableView.hidden = YES;
                rightPopoverTableView.hidden = NO;
                frame = frame;
            } else {
                frame.size.height -= ScreenHeight-64-45;
            }
        }
            break;
            
        default:
            break;
    }
    //4.添加动画效果
    if (frame.size.height) {
        [UIView animateWithDuration:0.35f animations:^{
            truncationView.frame = frame;
            [btn setImage:[UIImage imageNamed:@"24x14_famhui@2x"] forState:UIControlStateSelected];
        }];
    } else {
        [UIView animateWithDuration:0.65f animations:^{
            truncationView.frame = frame;
            [btn setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateSelected];
        }];
    }
}


#pragma mark __________________________监控触发事件_____________________________
/**
 推出页面的时候让tababr
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl hideTabBar];
}

/**
 将要返回的时候
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
}


#pragma mark __________________________下载_____________________________
- (void)download
{
}




























//----------------------------------------------------------------------------------------

#if 0
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID= [df objectForKey:@"GUID"];
    
    NSString *Date = [NSString stringWithFormat:@"%d",1];
    date = Date;
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;

    
    //[self downloadStore];
    
    [self createNav];
    [self createTableview];
    [self createPoPviewTableview];
    
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    _selectedButton = [ChangeBtn buttonWithType:UIButtonTypeSystem];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"要货单"];
    
    
    
    [self hid];//隐藏刷新时间
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        //[self loadData]; //(加载数据信息)
        //[self downloadMore];//(添加更多)
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
    
//    
//    if ([storeID isKindOfClass:[NSNull class]] || storeID == nil) {
//        
//        
//        [_tableView.header endRefreshing];
//        return;
//        
//        
//        
//    }else
//    {
//        
//        currPagestr = [NSString stringWithFormat:@"%d",0];
//        currPageIndex = s * 0;
//        
//        
//        [self download];
//        [_tableView.header endRefreshing];
//        
//    }
    
}

//加载的 index
-(void)loadData
{
    
    
    currPagestr = [NSString stringWithFormat:@"%d",0];
    s = currPageIndex +1;
    currPageIndex = s;
    currPagestr = [NSString stringWithFormat:@"%d",s];
    
    
    
}



#pragma mark __________________________创建UI_____________________________
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


#pragma mark __________________________点击事件_____________________________
-(void)playScan:(UIButton *)sender
{
    NSLog(@"扫描");
}

-(void)openSouchAction:(UIButton *)sender
{
    
    NSLog(@"搜索");
    
    SouchCheckViewController *SouchCtrl = [[SouchCheckViewController alloc]init];
    
    [self.navigationController pushViewController:SouchCtrl animated:YES];
    
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



#pragma mark __________________________UITableViewDataSource_____________________________
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView == _tableView) {
        
        return 1;
    }else if (tableView == _popViewTableview)
    {
        return 1;
        
    }else if (tableView == _TwoPopViewTableView)
    {
        return 3;
    }else
    {
        return 1;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    static NSString *cellID = @"cellID";
//    static NSString *popCellID = @"popCellID";
//    static NSString *TwoCellID = @"TwoCellID";
//    if (tableView == _tableView) {
//        ToGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//        
//        
//        if (cell == nil) {
//            cell = [[ToGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//            
//            
//            //线条
//            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
//            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
//            [cell addSubview:Lowimage];
//            
//            //箭头
//            UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 41, 10, 15) imageName:@"my_arrow_17X30@2x"];
//            [cell addSubview:arrowImage];
//            
//        }
//        
//        
//        ToGoosdModel *cellModel = self.dataArray[indexPath.row];
//        
//        cell.cellModel =cellModel;
//        
//        
//        return cell;
//        
//        
//    }else if (tableView == _popViewTableview)
//    {
//        
//        AllStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:popCellID];
//        
//        
//        if (cell == nil) {
//            cell = [[AllStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:popCellID];
//            
//            //            //线条
//            //            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
//            //            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
//            //            [cell addSubview:Lowimage];
//            
//        }
//        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];
//        
//        cell.cellModel = cellModel;
//        
//        //        bgyl = cellModel.StoreName;
//        //        NSLog(@"%@",bgyl);
//        
//        return cell;
//        
//        
//    }else
//    {
//        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoCellID];
//        
//        
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellID];
//            
//            //            //线条
//            //            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
//            //            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
//            //            [cell addSubview:Lowimage];
//            
//            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            
//            
//            if (indexPath.row == 0) {
//                Today= [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"今日" textAlignment:NSTextAlignmentLeft];
//                
//                Today.font = [UIFont systemFontOfSize:15];
//                [cell addSubview:Today];
//                
//            }else if (indexPath.row == 1)
//            {
//                
//                Week= [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"本周" textAlignment:NSTextAlignmentLeft];
//                
//                Week.font = [UIFont systemFontOfSize:15];
//                [cell addSubview:Week];
//                
//                
//            }else
//            {
//                
//                Month= [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"本月" textAlignment:NSTextAlignmentLeft];
//                
//                Month.font = [UIFont systemFontOfSize:15];
//                [cell addSubview:Month];
//                
//            }
//            
//            
//            
//        }
//        
//        return cell;
//        
//        
//        
//        
//    }
//
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_souch  resignFirstResponder];
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

#pragma mark __________________________UITableViewDelegate_____________________________
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
//    
//    if (tableView == _tableView) {
//        [tableView deselectRowAtIndexPath:indexPath animated:NO];
//        ToDetailViewController *ToDetailCtrl = [[ToDetailViewController alloc]init];
//        ToGoosdModel *model = self.dataArray[indexPath.row];
//        ToDetailCtrl.GUID = model.GUID;
//        [self.navigationController pushViewController:ToDetailCtrl animated:YES];
//        
//    }else if (tableView == _popViewTableview)
//    {
//        
//        
//        
//        NSArray *arr = [_TopHeaderView subviews];
//        
//        NSLog(@"%@",arr);
//        
//        
//        for (_chgtn in arr) {
//            
//            
//            if (_chgtn.tag == 10) {
//                
//                
//                NSLog(@"%@",_chgtn);
//                
//                //点击cell 修改 btn 文字 并下载数据
//                AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];
//                
//                // EntID = cellModel.EnterpriseID;
//                bgyl = cellModel.StoreName;
//                storeID = cellModel.GUID;
//                
//                
//                
//                
//                
//                [_chgtn setTitle:bgyl forState:UIControlStateNormal];
//                
//                //改变的时候缩回 然后 下载
//                [self changes];
//                
//                //选择店铺的时候，下载所选店铺的数据
//                [self download];
//                
//                
//                
//            }
//            
//        }
//        
//        
//    }else if (tableView == _TwoPopViewTableView)
//    {
//        
//        NSArray *arr = [_TopHeaderView subviews];
//        
//        NSLog(@"%@",arr);
//        
//        
//        for (_chgtn in arr) {
//            
//            
//            if (_chgtn.tag == 11) {
//                
//                
//                if (indexPath.row == 0) {
//                    
//                    
//                    NSString *str = [NSString stringWithFormat:@"%@",Today.text];
//                    
//                    [_chgtn setTitle:str forState:UIControlStateNormal];
//                    
//                    NSString *strDate = [NSString stringWithFormat:@"%d",1];
//                    date = strDate;
//                    //选择日期的时候，下载所选日期的的数据
//                    [self download];
//                    
//                    
//                    
//                }else if (indexPath.row == 1)
//                {
//                    
//                    NSString *str = [NSString stringWithFormat:@"%@", Week.text];
//                    
//                    [_chgtn setTitle:str forState:UIControlStateNormal];
//                    NSString *strDate = [NSString stringWithFormat:@"%d",2];
//                    date = strDate;
//                    //选择日期的时候，下载所选日期的的数据
//                    [self download];
//                    
//                    
//                    
//                }else if (indexPath.row == 2)
//                {
//                    
//                    NSString *str = [NSString stringWithFormat:@"%@", Month.text];
//                    
//                    [_chgtn setTitle:str forState:UIControlStateNormal];
//                    NSString *strDate = [NSString stringWithFormat:@"%d",3];
//                    date = strDate;
//                    //选择日期的时候，下载所选日期的的数据
//                    [self download];
//                    
//                    
//                }
//                
//                
//                //改变的时候缩回 然后 下载
//                [self changes];
//                
//                
//            }
//            
//        }
//        
//        
//        
//        
//        
//    }
//    
    
    
    
    
}



#endif




@end

