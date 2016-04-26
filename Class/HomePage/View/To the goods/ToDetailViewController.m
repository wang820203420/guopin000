//
//  ToDetailViewController.m
//  guoping
//
//  Created by zhisu on 15/9/18.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "ToDetailViewController.h"
#import "MainViewController.h"
#import "ToGoodsDetCell.h"//要货单信息
#import "ToGoodsDetModel.h"
#import "ToGoodsDetailCell.h"//订单明细
#import "ToGoodsDetailModel.h"
#import "ToGoodsCreatUserCell.h"//制单人
#import "ToGoodsCreatUserModel.h"
@interface ToDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;//数据
    NSMutableArray *_DetDataAray;//订单明细数据
    
    //NSMutableArray *_UserDataArray;//制单人
}
@property(nonatomic,retain)NSMutableArray *UserDataArray;
@end

@implementation ToDetailViewController

-(NSMutableArray *)UserDataArray
{
    
    if (_UserDataArray == nil) {
        
        _UserDataArray = [NSMutableArray array];
        
    }
    
    return _UserDataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self download];
    [self downloadDet];
    [self downloadCreateUser];
    [self createNav];
    [self createTableview];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"要货单详情"];
 
    
    
    
}

-(void)createTableview
{
    
    _dataArray = [NSMutableArray array];
    _DetDataAray= [NSMutableArray array];

    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    
    
    _tableView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    
    [self.view addSubview:_tableView];
    
    
    
    
    
    
}

#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
    
    
    
}


    


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
    
    if (section == 0) {
        
        return _dataArray.count;
        
    }else if (section == 1)
    {
        return _DetDataAray.count;
    }else
    {
        
      
    
//        if (self.UserDataArray.count == 0) {
//            return 0;
//        }else
//        {
//            //ToGoodsCreatUserModel *cellmodel = [[ToGoodsCreatUserModel alloc]init];
//      
//            return   [[self.UserDataArray objectAtIndex:0]integerValue];
//
//        }
        

        
        
        return self.UserDataArray.count;
  }
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 35;
    }else if (section == 1)
    {
        return 35;
    }else
    {
        return 1;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 35;
    }else if (section == 1)
    {
        return 20;
    }else
    {
        return 1;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    //其他代码
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 150;
    }else if(indexPath.section == 1)
    {
        
        return 35;
    }else
    {
        return 35;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    
    if (tableView == _tableView) {
        
        if (section == 0) {
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 80, 15) title:@"要货单信息" textAlignment:NSTextAlignmentCenter];
            
            label.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            
            return bgView;
            
        }else if(section == 1)
        {
            
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor whiteColor];
            
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(15, 15, 100, 10) title:@"商品名称" textAlignment:NSTextAlignmentLeft];
            label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label];
            
            
            UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/3.33, 15, 80, 10) title:@"库存" textAlignment:NSTextAlignmentLeft];
            label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label1.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label1];
            
            
            
            UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/2,15, 60, 10) title:@"核定" textAlignment:NSTextAlignmentLeft];
            label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label2.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label2];
            
            
            UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.5,15, 60, 10) title:@"要货量" textAlignment:NSTextAlignmentLeft];
            label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label3.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label3];
            
            
            UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.15,15, 100, 10) title:@"单位" textAlignment:NSTextAlignmentLeft];
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
//         return nil;
//
//   
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    static NSString *cellDetID = @"cellDetID";
     static NSString *cellUserID = @"cellUserID";
    
    if (indexPath.section == 0) {
        
        ToGoodsDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[ToGoodsDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
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
        
        
        ToGoodsDetModel *cellModel = _dataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        
        return cell;
    }else if (indexPath.section == 1)
    {
        
        
        
        ToGoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellDetID];
        
        
        if (cell == nil) {
            cell = [[ToGoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellDetID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
            
        }
        
        
        ToGoodsDetailModel *cellModel1 = _DetDataAray[indexPath.row];
        
        cell.cellModel = cellModel1;
        
        
        return cell;

        
        
        
        
    }else
    {
        
        
        ToGoodsCreatUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellUserID];
        
        
        if (cell == nil) {
            cell = [[ToGoodsCreatUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellUserID];
            
            
            //cell.backgroundColor = [UIColor redColor];
            
            
        }
      
            ToGoodsCreatUserModel *cellModel = self.UserDataArray[indexPath.row];
            
            
            cell.cellModel = cellModel;
    
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
    
    NSLog(@"%@",_GUID);
    
    NSString *str = [NSString stringWithFormat:@GetStoreNeedOrderDetailInfoUrl];
    
    NSDictionary * params = @{@"storeNeedOrderNo":_GUID,@"code":@"gy7412589630"};
    
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
                 
                 NSDictionary *subDict2 = [subDict1 objectForKey:@"Data"];
                 
                 NSDictionary *subDict3 = [subDict2 objectForKey:@"StoreNeedOrder"];
                 NSLog(@"===%@",subDict3);
                 
                 
                 
                 
                 
                 NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:subDict3];
                 
                 NSLog(@"%@",sssDict);
                 
                 
                 //要货单信息
                 ToGoodsDetModel *model = [[[ToGoodsDetModel alloc]init]initWithDictionary:sssDict];
                 [_dataArray addObject:model];
                 NSLog(@"======%ld",_dataArray.count);
                 
                 
    
                 
                 
             }
             [_tableView reloadData];
         }
         
         
     }
      failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


-(void)downloadDet
{
    
    NSLog(@"%@",_GUID);
    NSString *str = [NSString stringWithFormat:@GetStoreNeedOrderDetailInfoUrl];
    
    NSDictionary * params = @{@"storeNeedOrderNo":_GUID,@"code":@"gy7412589630"};
    
    
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
                 
                 NSArray *ListArr = [dicList objectForKey:@"StoreNeedOrderDetail"];
                 
                 NSLog(@"??%@",ListArr);
                 
                 for (NSDictionary *dict in ListArr) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     ToGoodsDetailModel *model = [[[ToGoodsDetailModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [_DetDataAray addObject:model];
               
   
                 }
                 [_tableView reloadData];
                 
                 
                 
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
    
    
    
    
}


-(void)downloadCreateUser
{
    
    NSLog(@"%@",_GUID);
    NSString *str = [NSString stringWithFormat:@GetStoreNeedOrderDetailInfoUrl];
    
    NSDictionary * params = @{@"storeNeedOrderNo":_GUID,@"code":@"gy7412589630"};
    
    
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
                 
                 NSArray *ListArr = [dicList objectForKey:@"StoreNeedOrderDetail"];
                 
                 NSLog(@"??%@",[ListArr objectAtIndex:0]);

                     //创建人
                     ToGoodsCreatUserModel *model1 = [[ToGoodsCreatUserModel alloc]initWithDictionary:[ListArr objectAtIndex:0]];
                     
                     [self.UserDataArray addObject:model1];
                     
                 }
                 [_tableView reloadData];
   
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

@end
