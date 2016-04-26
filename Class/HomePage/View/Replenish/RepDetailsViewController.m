//
//  RepDetailsViewController.m
//  guoping
//
//  Created by zhisu on 15/9/18.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "RepDetailsViewController.h"
#import "MainViewController.h"
#import "RepleDetCell.h"//进货详细
#import "ReplDetModel.h"
#import "ReplOrderCell.h"//订单详细
#import "ReplOrderModel.h"
#import "ReplCreatCell.h"//创建人
#import "ReplCreatModel.h"
@interface RepDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *tableVie;
}
@property(nonatomic,retain) NSMutableArray *dataArray;
@property(nonatomic,retain) NSMutableArray *OderdataArray;
@property(nonatomic,retain) NSMutableArray *cratedataArray;
@end

@implementation RepDetailsViewController


-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}
-(NSMutableArray *)OderdataArray
{
    
    if (_OderdataArray == nil) {
        
        _OderdataArray = [NSMutableArray array];
        
    }
    
    return _OderdataArray;
    
}

-(NSMutableArray *)cratedataArray
{
    
    if (_cratedataArray == nil) {
        
        _cratedataArray = [NSMutableArray array];
        
    }
    
    return _cratedataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    [self download];
    [self downloadOrder];
    [self downloadCreat];
    [self createNav];
    [self createTableview];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"进货详情"];
    
    
    
    
    
}


-(void)createTableview
{
    
    
    
    tableVie= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    
    
    //_tableView.backgroundColor = [UIColor redColor];
    
    tableVie.delegate = self;
    tableVie.dataSource = self;
    
    
    tableVie.separatorStyle = UITableViewCellEditingStyleNone;
    
    
    [self.view addSubview:tableVie];
    
    
    
    
    
    
}

#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        
        return self.dataArray.count;
    }else if(section == 1)
    {
        
        return self.OderdataArray.count;
    }else
    {
        
        return self.cratedataArray.count;
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 1;
    }
    else
    {
          return 35;
    }
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    if (section == 2) {
        return 1;
        
    }else if (section == 1)
    {
        return 10;
    }
    else
    {
        return 35;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中状态
    //其他代码
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else
    {
        
        return 40;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
    if (tableView == tableVie) {
        
        if (section == 0) {
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 60, 15) title:@"进货信息" textAlignment:NSTextAlignmentCenter];
            
            label.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            
            return bgView;
            
        }else if(section ==1)
        {
            
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor whiteColor];
            
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(20, 15, 100, 10) title:@"商品名称" textAlignment:NSTextAlignmentLeft];
            label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label];
            
            
            UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/3.7, 15, 80, 10) title:@"应收(元)" textAlignment:NSTextAlignmentLeft];
            label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label1.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label1];
            
            
            
            UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2,15, 60, 10) title:@"损耗" textAlignment:NSTextAlignmentLeft];
            label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label2.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label2];
            
            
            UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.5,15, 60, 10) title:@"实收(元)" textAlignment:NSTextAlignmentLeft];
            label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label3.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label3];
            
            
            UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.16,15, 60, 10) title:@"产地" textAlignment:NSTextAlignmentLeft];
            label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label4.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label4];
            
            return bgView;
            
            
            
        }else
        {
            return nil;
        }
        
        
    }else
    {
        return nil;
    }


}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
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
        
    }else
    {
        
        return nil;
        
    }
    
    
    
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    
//    return nil;
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    static NSString *OrderID = @"OrderID";
    static NSString *userNameID = @"userNameID";
    
    if (indexPath.section == 0) {
        
        RepleDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[RepleDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
            //线条
            CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
            UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
            [cell addSubview:Lowimage1];
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            
            
            //线条
            CGRect  Lowframe2 = CGRectMake(0, 49.5, ScreenWidth, 0.5);
            UIImageView *Lowimage2 = [MyUtil createIamgeViewFrame:Lowframe2 imageName:@"375x1@2x"];
            [cell addSubview:Lowimage2];
            
            //线条
            CGRect  Lowframe3 = CGRectMake(0, 149.5, ScreenWidth, 0.5);
            UIImageView *Lowimage3 = [MyUtil createIamgeViewFrame:Lowframe3 imageName:@"375x1@2x"];
            [cell addSubview:Lowimage3];
            
            
        }
        
        ReplDetModel *model = self.dataArray[indexPath.row];
        
        cell.cellModel = model;
        
          return cell;
    }else if (indexPath.section == 1)
    {
        ReplOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderID];
        
        
        if (cell == nil) {
            cell = [[ReplOrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:OrderID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
            
        }
        
        ReplOrderModel *model = self.OderdataArray[indexPath.row];
        
        cell.cellModel = model;
        
          return cell;
        
    }else
    {
        ReplCreatCell *cell = [tableView dequeueReusableCellWithIdentifier:userNameID];
        
        
        if (cell == nil) {
            cell = [[ReplCreatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:userNameID];
            
    
            
            
        }
        
        ReplCreatModel *creatmodel = self.cratedataArray[indexPath.row];
        
        cell.cellModel = creatmodel;

          return cell;
    }

    
  
    
    
    
    
    
    
}

#pragma mark --下载

-(void)download
{
    
    NSLog(@"%@",_storeIncomeNo);
    
    
    NSString *str = [NSString stringWithFormat:@GetStoreIncomeDetailInfoUrl];
    
    NSDictionary * params = @{@"storeIncomeNo":_storeIncomeNo,@"code":@"gy7412589630"};
    
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
                 
                 NSDictionary *dicList = [subDict1 objectForKey:@"Data"];
                 
                 
                 NSDictionary *dicSaleInfo = [dicList objectForKey:@"StoreIncome"];
                 
                 ReplDetModel *model = [[ReplDetModel alloc]initWithDictionary:dicSaleInfo];
                 
                 [self.dataArray addObject:model];
                 

                 
             }
         }
         [tableVie reloadData];
         
         
     }
      failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}

-(void)downloadOrder
{
    
    NSLog(@"%@",_storeIncomeNo);
    
    
    NSString *str = [NSString stringWithFormat:@GetStoreIncomeDetailInfoUrl];
    
    NSDictionary * params = @{@"storeIncomeNo":_storeIncomeNo,@"code":@"gy7412589630"};
    
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
                 
                 NSDictionary *dicList = [subDict1 objectForKey:@"Data"];
                 
                 NSArray *arr1 = [dicList objectForKey:@"StoreIncomeDetail"];
                 
                
                 for (NSDictionary *dicOredr in arr1) {
                     
                     
                     
                     ReplOrderModel *model = [[ReplOrderModel alloc]initWithDictionary:dicOredr];
                     
                     [self.OderdataArray addObject:model];
                     
                 }
             }
         }
         [tableVie reloadData];
         
         
     }
     failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}



-(void)downloadCreat
{
    
    NSLog(@"%@",_storeIncomeNo);
    
    
    NSString *str = [NSString stringWithFormat:@GetStoreIncomeDetailInfoUrl];
    
    NSDictionary * params = @{@"storeIncomeNo":_storeIncomeNo,@"code":@"gy7412589630"};
    
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
                 
                 NSDictionary *dicList = [subDict1 objectForKey:@"Data"];
                 
                 
                 NSDictionary *dicSaleInfo = [dicList objectForKey:@"StoreIncome"];
                 
                 ReplCreatModel *model = [[ReplCreatModel alloc]initWithDictionary:dicSaleInfo];
                 
                 [self.cratedataArray addObject:model];
                 
             
                 
                 
             }
         }
         [tableVie reloadData];
         
         
     }
    failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


-(void)backAction:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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


@end
