//
//  TransferDetailViewController.m
//  guoping
//
//  Created by zhisu on 16/6/21.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferDetailViewController.h"
#import "MainViewController.h"
#import "TransferModel.h"
#import "TransferDetailModel.h"
#import "TransferDetailCell.h"
#import "TransferDetailTwoCell.h"

@interface TransferDetailViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    UITableView *mainTableView;         //mainTableView
    
    //请求参数
    NSString *orderId;                  //企业ID
}

@property(nonatomic,retain) NSMutableArray *dataArray;


@end

@implementation TransferDetailViewController
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
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"调货明细"];
    
    
    orderId = _cellModel.OrderId;
    [self download];
    [self createTableview];

}

- (void)createTableview
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.showsVerticalScrollIndicator = NO;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //mainTableView.separatorStyle = UITableViewCellAccessoryNone;
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *detailCellID = @"detailCellID";
    static NSString *detailTwoCellID = @"detailTwoCellID";
    
    if (indexPath.section == 0) {
        TransferDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:detailCellID];
        
        if (cell == nil) {
            cell = [[TransferDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailCellID];
        }
        
        //添加线条
        for (int i = 0; i < 6; i++) {
            CGRect frameLowline = CGRectMake(0, 50 * i - 0.5, ScreenWidth, 0.5);
            UIImageView *Lowline = [MyUtil createIamgeViewFrame:frameLowline  imageName:@"375x1@2x"];
            [cell addSubview:Lowline];
        }
        
        cell.cellModel = _cellModel;//传送过来的数据模型直接参与赋值
        
        return cell;
        
    } else {
        
        TransferDetailTwoCell *twoCell = [tableView dequeueReusableCellWithIdentifier:detailTwoCellID];
        
        if (twoCell == nil) {
            twoCell = [[TransferDetailTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detailTwoCellID];
        }
        
        TransferDetailModel *cellModel = self.dataArray[indexPath.row];
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
        return 250;
    } else {
        return 40;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == mainTableView) {
        if (section == 0) {
            //创建背景view
            UIView *bgView= [[UIView alloc] init];
            bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 60, 15) title:@"调货信息" textAlignment:NSTextAlignmentCenter];
            label.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            return bgView;
        } else {
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor whiteColor];
            
            //1.商品名称
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 15, 100, 10) title:@"商品名称" textAlignment:NSTextAlignmentLeft];
            label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label];
            
            //2.单箱重量
            UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/3.41, 15, 80, 10) title:@"单箱重量" textAlignment:NSTextAlignmentLeft];
            label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label1.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label1];
            
            //3.单箱皮重
            UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.974,15, 60, 10) title:@"单箱皮重" textAlignment:NSTextAlignmentLeft];
            label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label2.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label2];
            
            //4.调货箱数
            UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.5,15, 60, 10) title:@"调货箱数" textAlignment:NSTextAlignmentLeft];
            label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label3.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label3];
            
            //5.商品单位
            UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.25,15, 100, 10) title:@"商品单位" textAlignment:NSTextAlignmentLeft];
            label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label4.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label4];
            
            //6.总数量
            UILabel *label5 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.05,15, 100, 10) title:@"总数量" textAlignment:NSTextAlignmentLeft];
            label5.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label5.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label5];
            
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
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 60, 15) title:@"调货明细" textAlignment:NSTextAlignmentCenter];
        
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
 *    接口样例:
 *
 {
 "GoodsName": "皇帝蕉",
 "UnitName": "kg",
 "GUID": "7dfe6548b2474263b1fe196a8d2111a2",
 "OrderID": "eb7b8d5c3bd44f9a98fb021df71a1e5a",
 "GoodsID": "85a6139d3a904caeb07f16c0ed8b7a32",
 "BoxAmount": 20.000,
 "BoxPtare": 1.000,
 "SendBox": 15.0,
 "SendNumber": 285.000,
 "DisplayNO": 1,
 "EnterpriseID": "05397e04317441009caa9e890947cc70",
 "StoreID": "0d6a1411d71b4643bdc5c13c1e8af117",
 "UpdateUser": "ec828d50d9a24507aef40a3fafb4b83c",
 "UpdateTime": "2016-06-17 16:08:23",
 "CreateUser": "ec828d50d9a24507aef40a3fafb4b83c",
 "CreateTime": "2016-06-17 11:42:02",
 "IsDelete": 0,
 "SourceID": "cfa81059587743a3b6b0dcbbf67ac43f",
 "UploadCreateTime": "2016-06-17 11:42:03",
 "UploadUpdateTime": "2016-06-17 16:07:06"
 }
 *
 *
 *
 */
{
    NSString *str = [NSString stringWithFormat:@GetTransferDetailInfoUrl];
    
    NSDictionary * params = @{@"orderId":orderId,@"code":@"gy7412589630"};
    
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
                     TransferDetailModel *model = [[[TransferDetailModel alloc]init]initWithDictionary:sssDict];
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
