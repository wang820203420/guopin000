//
//  StockDetailsViewController.m
//  guoping
//
//  Created by zhisu on 15/9/17.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "StockDetailsViewController.h"
#import "MainViewController.h"
#import "StockDetModel.h"//库存查询详细
#import "StockDetCell.h"
@interface StockDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
    NSString *entID;
    UITableView *tableVie;
}
@property(nonatomic,retain) NSMutableArray *dataArray;
@end


@implementation StockDetailsViewController

-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    entID = [df objectForKey:@"GUID"];
    
    
    [self download];
    [self createNav];
    [self createTableview];
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    

    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"库存查询"];
    
    
    
    
    
    
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
    return 1;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.dataArray.count;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 150;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";

   
        StockDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[StockDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
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
    
    StockDetModel *cellModel = self.dataArray[indexPath.row];
    
    
    cell.cellModel =cellModel;
    
    
       
    
    
    
        return cell;
        
        
   
    
    
    
}
#pragma mark --下载

-(void)download
{
    //[self juhua];
    NSLog(@"%@",entID);
    
    NSLog(@"%@",_goodsId);
    
    NSString *str = [NSString stringWithFormat:@GetGoodsInventoryDetailInfoUrl];
    
    NSDictionary * params = @{@"entId":entID,@"goodsId":_goodsId,@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         //[CacheManager saveCacheWithObject:responseObject ForURLKey:@"6" AndType:CacheTypeQuestion];
         
         
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
                 
                 StockDetModel *model = [[StockDetModel alloc]initWithDictionary:subDict2];
                 
                 [self.dataArray addObject:model];
                 
                 NSLog(@"%ld",self.dataArray.count);
      
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
