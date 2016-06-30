//
//  StockCheckDetailViewController.m
//  guoping
//
//  Created by zhisu on 16/6/23.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "StockCheckDetailViewController.h"
#import "MainViewController.h"
#import "StockCheckModel.h"
#import "StockCheckDetailModel.h"
#import "StockCheckDetailCell.h"
#import "StockCheckDetailTwoCell.h"
@interface StockCheckDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mainTableView;         //mainTableView
    
    //请求参数
    NSString *stockNo;                  //调货单号ID
}

@property(nonatomic,retain) NSMutableArray *dataArray;

@end

@implementation StockCheckDetailViewController
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"盘点明细"];
    
    stockNo = _cellModel.StockNo;
    [self download];
    [self createTableview];
}
#pragma mark __________________________创建UI_____________________________
- (void)createTableview
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.showsVerticalScrollIndicator = NO;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:mainTableView];
}

#pragma mark __________________________UITableViewDataSource_____________________________
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
        return self.dataArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailCellID = @"detailCellID";
    static NSString *detailTwoCellID = @"detailTwoCellID";
    
    if (indexPath.section == 0) {
        StockCheckDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellID];
        
        if (cell == nil) {
            cell = [[StockCheckDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellID];
        }
        
        //添加线条
        for (int i = 0; i < 5; i++) {
            CGRect frameLowline = CGRectMake(0, 50 * i - 0.5, ScreenWidth, 0.5);
            UIImageView *Lowline = [MyUtil createIamgeViewFrame:frameLowline  imageName:@"375x1@2x"];
            [cell addSubview:Lowline];
        }
        
        cell.cellModel = _cellModel;//传送过来的数据模型直接参与赋值
        
        return cell;
        
    } else {
        
        StockCheckDetailTwoCell *twoCell = [tableView dequeueReusableCellWithIdentifier:detailTwoCellID];
        
        if (twoCell == nil) {
            twoCell = [[StockCheckDetailTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailTwoCellID];
        }
        
        StockCheckDetailModel *cellModel = self.dataArray[indexPath.row];
        twoCell.cellModel =cellModel;
        
        return twoCell;
    }
}

#pragma mark __________________________UITableViewDelegate_____________________________

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    } else {
        return 30;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == mainTableView) {
        if (section == 0) {
            //1.创建背景view
            UIView *bgView= [[UIView alloc] init];
            bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 60, 15) title:@"盘点信息" textAlignment:NSTextAlignmentCenter];
            label.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            //2.补全下划线
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:CGRectMake(0, 34.5, ScreenWidth, 0.5) imageName:@"375x1@2x"];
            [bgView addSubview:Lowimage];
            
            return bgView;
        } else {
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor whiteColor];
            
            //1.商品名称
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/60, 15, 60, 10) title:@"商品名称" textAlignment:NSTextAlignmentCenter];
            label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label];
            
            //2.盘点箱数
            UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/4.55, 15, 60, 10) title:@"盘点箱数" textAlignment:NSTextAlignmentCenter];
            label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label1.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label1];
            
            //3.盘点重量
            UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2.4, 15, 60, 10) title:@"盘点重量" textAlignment:NSTextAlignmentCenter];
            label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label2.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label2];
            
            //4.商品单位
            UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.6, 15, 60, 10) title:@"商品单位" textAlignment:NSTextAlignmentCenter];
            label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label3.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label3];
            
            //5.库存差异
            UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.22, 15, 60, 10) title:@"库存差异" textAlignment:NSTextAlignmentCenter];
            label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label4.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label4];
            
            //6.补全下划线
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:CGRectMake(0, 0, ScreenWidth, 0.5) imageName:@"375x1@2x"];
            [bgView addSubview:Lowimage];
            
            return bgView;
        }
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        //创建背景view
        UIView *bgView= [[UIView alloc]init];
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 60, 15) title:@"订单明细" textAlignment:NSTextAlignmentCenter];
        
        label.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:label];
        
        return bgView;
        
    } else {
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中状态
}

#pragma mark __________________________点击事件_____________________________
- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark __________________________下载_____________________________
- (void)download
/*
 *
 *
 *   接口样例:
 {
     "GoodsName": "进口半蕉",
     "UnitName": "kg",
     "GUID": "70ab38e2152c4b73b1507a7c32ff3666",
     "StockNo": "03160429001",
     "GoodsID": "e3349f17e8944605b8b620827c757892",
     "BoxNum": 20.00,
     "BoxAmount": 45.00,
     "BoxPtare": 0.00,
     "TotalAmount": 900.00,
     "CurrentInventory": 1000.00,
     "DiffAmount": -100.00,
     "StoreID": "0d6a1411d71b4643bdc5c13c1e8af117",
     "EnterpriseID": "05397e04317441009caa9e890947cc70",
     "UpdateUser": "",
     "UpdateTime": null,
     "CreateUser": "ec828d50d9a24507aef40a3fafb4b83c",
     "CreateTime": "2016-04-29 11:44:02",
     "IsDelete": 0,
     "SourceID": "cfa81059587743a3b6b0dcbbf67ac43f",
     "UploadCreateTime": "2016-04-29 11:44:01",
     "UploadUpdateTime": null
 }
 *
 *
 *
 */
{
    NSString *str = [NSString stringWithFormat:@GetStockcheckDetailInfoUrl];
    
    NSDictionary * params = @{@"stockNo":stockNo,@"code":@"gy7412589630"};
    
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
             NSLog(@"%@",str);
             
             
             //字符串转化成data
             NSData *jsData = [str dataUsingEncoding:NSUTF8StringEncoding];
             
             NSError *error;
             
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableContainers error:&error];
             
             NSLog(@"%@",dic);
             
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr = [subDict1 objectForKey:@"Data"];
                 for (NSDictionary *dict in arr) {
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     StockCheckDetailModel *model = [[[StockCheckDetailModel alloc]init]initWithDictionary:sssDict];
                     [self.dataArray addObject:model];
                 }
                 //刷新数据返回主线程
                 [mainTableView reloadData];
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
    [tabCtrl hideTabBar];
    
}



@end
