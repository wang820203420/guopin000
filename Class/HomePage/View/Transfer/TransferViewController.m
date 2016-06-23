//
//  TransferViewController.m
//  guoping
//
//  Created by zhisu on 16/6/12.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferViewController.h"
#import "TransferDetailViewController.h"
#import "MainViewController.h"
#import "ChangeBtn.h"
#import "TransferModel.h"
#import "TransferCell.h"
#import "AllStoreModel.h"
#import "AllStoreCell.h"



@interface TransferViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mainTableView;         //mainTableView
    UIView *popoverView;                //控制上面的选择栏的隐现
    UIView *truncationView;             //截断view(弹出的透明遮罩)
    UITableView *leftPopoverTableView;  //左侧弹出的tableview
    UITableView *rightPopoverTableView; //右侧弹出的tableview
    
    ChangeBtn *dropdownBtn;             //点击弹出选择view
    MBProgressHUD *HUD;                 //菊花
    
    NSString *storeName;                //店铺名
    
    //请求参数
    NSString *EntID;                  //企业ID
    
    NSString *storeId;                //店铺名ID
    NSString *dateType;               //今日、本周、本月
    NSString *currPageIndex;          //当前页码
    
    //监控UIScrollerView的滚动方向
    CGFloat contentOffsetY;
    CGFloat oldContentOffsetY;
    CGFloat newContentOffsetY;
}
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain) NSMutableArray *storeDataArray;

@end

@implementation TransferViewController


#pragma mark __________________________懒加载_____________________________
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)storeDataArray
{
    if (_storeDataArray == nil) {
        _storeDataArray = [NSMutableArray array];
    }
    return _storeDataArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"门店调货"];
    
    [self configureData];
}

- (void)configureData
{
    //1.配置请求参数
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID = [df objectForKey:@"GUID"];
    dateType = @"3";
    currPageIndex = @"0";
    
    //2.下载数据
    [self downloadStore];

    //3.上拉加载，下拉刷新
    
        //a.上拉加载
    mainTableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self downloadMore];
        [mainTableView.footer endRefreshing];
        
    }];
    
        //b.下拉刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    mainTableView.header = header;
}

#pragma mark __________________________创建UI_____________________________
- (void)configureUI
{
    [self createTableview];
    [self createPopoverTableview];
}

- (void)createTableview
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.showsVerticalScrollIndicator = NO;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mainTableView.rowHeight = 125;
    [self.view addSubview:mainTableView];
}

- (void)createPopoverTableview
{
    //1.创建一个popoverView
    popoverView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 45)];
    [self.view addSubview:popoverView];
    
    //2.创建下拉按钮changeBtn
    [self createChangeBtn];
    
    //3.线条
    //上层线条
    UIImageView *topLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 0, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [popoverView addSubview:topLine];
    //中间线条
    UIButton *lineBtn = [MyUtil createBtnFrame:CGRectMake(ScreenWidth/2.01, 10, 0.5, 25) image:nil selectedImage:nil target:nil action:nil];
    lineBtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1];
    [popoverView addSubview:lineBtn];
    //下面线条
    UIImageView *lowLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 45, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [popoverView addSubview:lowLine];
    
    //4.创建用来截取子视图的truncation view
    truncationView = [[UIView alloc] initWithFrame:CGRectMake(0, 45, ScreenWidth, 0)];
    truncationView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    truncationView.clipsToBounds = YES;//截断
    [popoverView addSubview:truncationView];
    
    //5.创建左边的leftPopoverTableview
    leftPopoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    leftPopoverTableView.dataSource = self;
    leftPopoverTableView.delegate = self;
    leftPopoverTableView.separatorStyle = UITableViewCellAccessoryNone;
    [truncationView addSubview:leftPopoverTableView];

    //6.创建右边的rightPopoverTableview
    rightPopoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    rightPopoverTableView.dataSource = self;
    rightPopoverTableView.delegate = self;
    [truncationView addSubview:rightPopoverTableView];
}

- (void)createChangeBtn
{
    //NSArray *titles = @[store,date];
    NSArray *titles = @[@"wode di",@"今日"];
    for (int i = 0; i < titles.count; i++) {
        dropdownBtn = [ChangeBtn buttonWithType:UIButtonTypeCustom];//注意：该语句是创建了一个新的Btn相当于alloc和init
        dropdownBtn.frame = CGRectMake((ScreenWidth/2)*(i%2)+ScreenWidth/12.5, 10, ScreenWidth/3, 30);
        [dropdownBtn setTitle:titles[i] forState:UIControlStateNormal];
        dropdownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [dropdownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [dropdownBtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:150.0/255.0 blue:61.0/255.0 alpha:1] forState:UIControlStateSelected];
        [dropdownBtn setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
        [popoverView addSubview:dropdownBtn];
        
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
    if (mainTableView == tableView) {
        NSLog(@"%ld", self.dataArray.count);
        return self.dataArray.count;
        
    } else if (leftPopoverTableView == tableView) {
         NSLog(@"%ld", self.storeDataArray.count);
        return self.storeDataArray.count;
    } else if (rightPopoverTableView == tableView) {
        return 3;
    } else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    static NSString *leftPopoverCellID = @"leftPopoverCellID";
    static NSString *rightPopoverCellID = @"rightPopoverCellID";
    
    if (mainTableView == tableView) {
        //1.cell的重用机制
        TransferCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[TransferCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        //2.取出数据模型set方法赋值
        TransferModel *cellModel = self.dataArray[indexPath.row];
        cell.cellModel = cellModel;
        
        return cell;
    } else if (leftPopoverTableView == tableView) {
        AllStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:leftPopoverCellID];
        if (cell == nil) {
            cell = [[AllStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftPopoverCellID];
        }
        
        AllStoreModel *cellModel = self.storeDataArray[indexPath.row];
        cell.cellModel = cellModel;
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightPopoverCellID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rightPopoverCellID];
        }
        
        if (indexPath.row == 0) {
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"今日" textAlignment:NSTextAlignmentLeft];
            label.font = [UIFont systemFontOfSize:15];
            [cell addSubview:label];
            
        } else if (indexPath.row == 1) {
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"本周" textAlignment:NSTextAlignmentLeft];
            label.font = [UIFont systemFontOfSize:15];
            [cell addSubview:label];
            
        } else {
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 5, 30, 30) title:@"本月" textAlignment:NSTextAlignmentLeft];
            
            label.font = [UIFont systemFontOfSize:15];
            [cell addSubview:label];
            
        }
        return cell;
    }
}


#pragma mark __________________________UITableViewDelegate_____________________________
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (mainTableView == tableView) {
        return 45;
    } else {
        return 0;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (mainTableView == tableView) {
        TransferDetailViewController *transfer = [[TransferDetailViewController alloc] init];
        TransferModel *model = self.dataArray[indexPath.row];
        transfer.cellModel = model;
        [self.navigationController pushViewController:transfer animated:YES];
    } else if (leftPopoverTableView == tableView) {
        
    } else if (rightPopoverTableView == tableView) {
        
    }
    
}
#pragma mark __________________________UIScrollViewDelegate_____________________________
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //1.记录拖拽初始的值
    contentOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //2.记录拖拽完成的值（完成拖拽，手指离开屏幕，继续滚动）
    oldContentOffsetY = scrollView.contentOffset.y;
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //3.获取当前滚动值
    newContentOffsetY = scrollView.contentOffset.y;
    
      //a.监控滚动方向
    if (newContentOffsetY > oldContentOffsetY && oldContentOffsetY > contentOffsetY) {
        // 向上滚动
        NSLog(@"up");
    } else if (newContentOffsetY < oldContentOffsetY && oldContentOffsetY < contentOffsetY) {
        // 向下滚动
        NSLog(@"down");
    } else {
        NSLog(@"dragging");
    }
    
      //b.监控拖拽方向
    if (scrollView.dragging) {
        if ((scrollView.contentOffset.y - contentOffsetY) > 5.0f) {
            // 向上拖拽
            [UIView animateWithDuration:0.35f animations:^{
                
                popoverView.hidden = YES;
                
            }];

        } else if ((contentOffsetY - scrollView.contentOffset.y) > 5.0f) {
            // 向下拖拽
            popoverView.hidden = NO;
        } else {
        }
    }
}



#pragma mark __________________________点击事件_____________________________
- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openView:(ChangeBtn *)btn
{
    //1.点击Btn初始化所有btn状态并设置当前btn,关闭mainTableView滚动
    for (ChangeBtn *dropdown in [popoverView subviews]) {
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
                mainTableView.scrollEnabled = YES;
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
                mainTableView.scrollEnabled = YES;
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

/**
 *点击cell修改cell的数据源的方法:
 1.设置一个单击触发事件（原因是数据源方法先于代理点击事件方法触发，所有要点击修改就要回调数据源方法）
 2.用一个响应机制监听触发事件（例：if ([_tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) { <#statements#> ｝）
 */
//- (void)btnActionForUserSetting:(id) sender {
//    
//    NSIndexPath *indexPath = [_tableview indexPathForSelectedRow];
//    
//    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
//    cell.textLabel.text = @"abc";
//    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//}


#pragma mark __________________________监控触发事件_____________________________
- (void)juhua
{
    HUD =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.userInteractionEnabled = NO;
}

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


- (void)downloadStore
/**
 *
 *  接口样例:
 *
         {
         "GUID": "0d6a1411d71b4643bdc5c13c1e8af117",
         "EnterpriseID": "05397e04317441009caa9e890947cc70",
         "StoreNo": "0003",
         "StoreType": "",
         "StoreName": "嘉客来水果大华二路店",
         "CheckDateType": null,
         "Address": "上海市宝山区大华二路72号",
         "Telephone": "",
         "Fax": "",
         "Email": "",
         "IsForbidden": false,
         "OperatingState": "",
         "UpdateUser": "05397e04317441009caa9e890947cc70",
         "UpdateTime": "2016-01-20 10:19:04",
         "CreateUser": "05397e04317441009caa9e890947cc70",
         "CreateTime": "2016-01-19 13:22:32",
         "IsDelete": 0,
         "Sequence": 3,
         "UploadUpdateTime": "2016-01-20 10:19:04",
         "UploadCreateTime": "2016-01-19 13:22:32",
         "SourceID": "sys",
         "AskMobile": "13761195868" },
 *
 *
 */
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
                 
                 for (NSDictionary *dict in arr1) {
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     AllStoreModel *model = [[[AllStoreModel alloc]init]initWithDictionary:sssDict];
                     [self.storeDataArray addObject:model];
                 }
                 
                 //这里进行初始化download
                 AllStoreModel *model = _storeDataArray[0];
                 storeId = model.GUID;
                 [self initDownload];
             }
         }
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
}

- (void)initDownload
{
    //3.新数据的解析加载
    NSString *str = [NSString stringWithFormat:@GetTransferListByPageUrl];
    NSDictionary * params = @{@"storeId":storeId,@"dateType":dateType,@"currPageIndex":currPageIndex,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         NSError *error = nil;
        
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         //第一次分离（取出标签内部的text）
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
                 for (NSDictionary *dict in arr1) {
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     TransferModel *model = [[[TransferModel alloc]init] initWithDictionary:sssDict];
                     
                     [self.dataArray addObject:model];
                 }
                 
                 [self configureUI];

             }
         }
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}

- (void)download
/*
 *   接口样例：
 *
 { "StoreName": "嘉客来水果大华二路店",
 "TargetStoreName": "嘉客来水果南华苑店",
 "StaffName": "李军",
 "GUID": "eb7b8d5c3bd44f9a98fb021df71a1e5a",
 "OrderNo": "03160617005",
 "OrderStatus": null,
 "Remark": "",
 "SendDate": "2016-06-17 11:42:03",
 "TotalAmount": null,
 "TotalCost": null,
 "TargetStore": "4023ec9ba14d4e5698e6d4ae61b8e84e",
 "EnterpriseID": "05397e04317441009caa9e890947cc70",
 "StoreID": "0d6a1411d71b4643bdc5c13c1e8af117",
 "UpdateUser": "",
 "UpdateTime": null,
 "CreateUser": "ec828d50d9a24507aef40a3fafb4b83c",
 "CreateTime": "2016-06-17 11:42:03",
 "IsDelete": 0,
 "SourceID": "cfa81059587743a3b6b0dcbbf67ac43f",
 "UploadCreateTime": "2016-06-17 11:42:03",
 "UploadUpdateTime": null },
 *
 *
 */
{
    //1.开启菊花
    [self juhua];
    //2.调用数据缓存
    //3.新数据的解析加载
    NSString *str = [NSString stringWithFormat:@GetTransferListByPageUrl];
    NSDictionary * params = @{@"storeId":storeId,@"dateType":dateType,@"currPageIndex":currPageIndex,@"pageSize":@"10",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         /*
          *
          *
          //保存下载的数据用于缓存
          [CacheManager saveCacheWithObject:responseObject ForURLKey:@"0" AndType:CacheTypeQuestion];
          *
          *
          */
         
         NSError *error = nil;
         
         //xml解析
         NSDictionary *dict = [XMLReader dictionaryForXMLData:responseObject error:&error];
         //第一次分离（取出标签内部的text）
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
                 
                 for (NSDictionary *dict in arr1) {
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     TransferModel *model = [[[TransferModel alloc]init] initWithDictionary:sssDict];
                     
                     [self.dataArray addObject:model];
                 }
                 NSLog(@"%ld",self.dataArray.count);
                 //4.刷新回到主线程
                 [mainTableView reloadData];
                 //5.加载完成，关闭菊花
                 [HUD hide:YES];
             }
         }
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
}


- (void)loadNewData
{
    if ([storeId isKindOfClass:[NSNull class]] || storeId == nil) {
        //店铺ID为nil请求不到数据的
        [mainTableView.header endRefreshing];
        return;
    } else {
        currPageIndex = @"0";
        [self download];
        [mainTableView.header endRefreshing];
    }
}

- (void)downloadMore
{
    NSInteger index = [currPageIndex integerValue];
    index += 1;
    currPageIndex = [NSString stringWithFormat:@"%ld", index];
    
    [self download];
}




@end





#if 0
/**
 *点击cell修改cell的数据源的方法:
 1.设置一个单击触发事件（原因是数据源方法先于代理点击事件方法触发，所有要点击修改就要回调数据源方法）
 2.用一个响应机制监听触发事件（例：if ([_tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) { <#statements#> ｝）
 */
- (void)btnActionForUserSetting:(id) sender {
    
    NSIndexPath *indexPath = [_tableview indexPathForSelectedRow];
    
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = @"abc";
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
#endif

