//
//  SalesViewController.m
//  guoping
//
//  Created by zhisu on 15/9/14.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "SalesViewController.h"
#import "ChangeLeftBtn.h"
#import "MainViewController.h"
#import "SalesListDetailModel.h"//模型
#import "SelesListDetallCell.h"//cell
#import "SalesListDetailTwoModel.h"
#import "SelesListDetallTwoCell.h"
@interface SalesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    UITableView *_tableView;
    
    NSMutableArray *_dataArray;
    NSMutableArray *_ListDataArray;
    
    
    NSString *EntID;//企业id
    NSString *date;//今日、本周、本月
    NSString *storeId;//店铺id
    NSString *currPagestr;
}
@end

@implementation SalesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID= [df objectForKey:@"GUID"];
    
    
    NSString *Date = [NSString stringWithFormat:@"%d",0];
    
    date = Date;
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    
    
    NSLog(@"%@",storeId);

    [self download];
    [self downloadList];
    [self createNav];
    [self createTableView];
    [self createTabBarView];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"销售单详细"];
    
    

}

-(void)backAction:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma  mark -合计金额
-(void)createTabBarView
{
    
    
    
    
    UIView *BarView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-50, ScreenWidth, 50)];
    
    BarView.backgroundColor = [UIColor colorWithRed:228.0/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1];
    
    
    
    UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(23, 15, 20, 20) imageName:@"je_icon@2x"];
    
    [BarView addSubview:image];
    
    
    UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/6.82,15,65,20) title:@"合计金额" textAlignment:NSTextAlignmentCenter];
    label.textColor = [UIColor colorWithRed:74.0/255.0 green:159.0/255.0 blue:60.0/255.0 alpha:1];
    label.font =[UIFont systemFontOfSize:16];
    [BarView addSubview:label];
    
    
    
    //合计金额
    
    UILabel *Moneylabel = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.1,15,80,20) title:[NSString stringWithFormat:@"¥ %@",_storeMoney] textAlignment:NSTextAlignmentCenter];
    Moneylabel.textColor = [UIColor colorWithRed:74.0/255.0 green:159.0/255.0 blue:60.0/255.0 alpha:1];
    Moneylabel.font =[UIFont systemFontOfSize:18];
    [BarView addSubview:Moneylabel];
    
    
    //金额
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:18]};
    
    //动态计算出宽度
    CGSize size1 = [Moneylabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 = Moneylabel.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.1-size1.width;
    
    Moneylabel.frame = frame1;
    
    
    
    
    

    
    [self.view addSubview:BarView];
    
    
    
    
}

-(void)createTableView
{
    
    _dataArray = [NSMutableArray array];
    
    _ListDataArray = [NSMutableArray array];
    
     _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight-88) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;

    
    [self.view addSubview:_tableView];

    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
 
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        return _dataArray.count;
   
        
    }else

    {
        return _ListDataArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 35;
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
    
    
    
    if (tableView == _tableView) {
    
        if (section == 0) {
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
            
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 10, 60, 15) title:@"销售信息" textAlignment:NSTextAlignmentCenter];
            
            label.textColor = [UIColor colorWithRed:163.0/255.0 green:163.0/255.0 blue:163.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:14];
            [bgView addSubview:label];
            
            
            return bgView;
            
        }else
        {
            
            //创建背景view
            UIView *bgView= [[UIView alloc]init];
            bgView.backgroundColor = [UIColor whiteColor];
            
         
            UILabel *label = [MyUtil createLabelFrame:CGRectMake(13, 15, 100, 10) title:@"商品名称" textAlignment:NSTextAlignmentLeft];
            label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label];
            
            
            UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/3.41, 15, 80, 10) title:@"售价(元)" textAlignment:NSTextAlignmentLeft];
            label1.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label1.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label1];
            
            
            
            UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.974,15, 60, 10) title:@"数量" textAlignment:NSTextAlignmentLeft];
            label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label2.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label2];
            
            
            UILabel *label3 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.5,15, 60, 10) title:@"单位" textAlignment:NSTextAlignmentLeft];
            label3.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label3.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label3];
            
            
            UILabel *label4 = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.25,15, 100, 10) title:@"小计(元)" textAlignment:NSTextAlignmentLeft];
            label4.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            label4.font = [UIFont systemFontOfSize:13];
            [bgView addSubview:label4];
            
            return bgView;
            
            
            
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *cellSaleID = @"cellID";
    static NSString *cellOrderID = @"OrderID";
    
    if (indexPath.section == 0) {
        
        SelesListDetallCell *cell = [tableView dequeueReusableCellWithIdentifier:cellSaleID];
        
        if (cell == 0) {
            
            cell = [[SelesListDetallCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellSaleID];
            
            
            
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
        
        
        SalesListDetailModel *cellModel = _dataArray[indexPath.row];
        
        
        cell.cellModel = cellModel;
        
        
        
        
        return cell;
        
    }else
    {
        
        SelesListDetallTwoCell *Ordercell = [tableView dequeueReusableCellWithIdentifier:cellOrderID];
        
        if (Ordercell == 0) {
            
            Ordercell = [[SelesListDetallTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellOrderID];
            
            
           _tableView.separatorStyle = UITableViewCellAccessoryNone;
            

        }
        
        SalesListDetailTwoModel *cellModel = _ListDataArray[indexPath.row];
        
        
        Ordercell.cellModel =cellModel;
      
        
        
        return Ordercell;
        
    }
    

    
    
    
    
    
}


#pragma mark --下载

-(void)download
{
    
    NSLog(@"%@",storeId);
    NSLog(@"%@",_saleId);

    
    NSString *str = [NSString stringWithFormat:@GetSaleDetailInfoUrl];
    
    NSDictionary * params = @{@"saleId":_saleId,@"code":@"gy7412589630"};
    
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
                 
          
                 NSDictionary *dicSaleInfo = [dicList objectForKey:@"SaleInfo"];
        
                     //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     SalesListDetailModel *model = [[[SalesListDetailModel alloc]init]initWithDictionary:dicSaleInfo];
                     
                     
                     [_dataArray addObject:model];
            
                 
                
                 [_tableView reloadData];
                 
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}

-(void)downloadList
{
    NSString *str = [NSString stringWithFormat:@GetSaleDetailInfoUrl];
    
    NSDictionary * params = @{@"saleId":_saleId,@"code":@"gy7412589630"};
    
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
                 
                 NSArray *ListArr = [dicList objectForKey:@"SaleDetailList"];
                 
                 NSLog(@"??%@",ListArr);
                 
                 for (NSDictionary *dict in ListArr) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     SalesListDetailTwoModel *model = [[[SalesListDetailTwoModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [_ListDataArray addObject:model];
                     NSLog(@"======%ld",_ListDataArray.count);
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
