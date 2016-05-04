//
//  MemberDetailViewController.m
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberDetailViewController.h"
#import "MainViewController.h"

#import "MemberDetailCell.h"//商品详细
#import "MemberDetaiTwoCell.h"//商品详细
#import "MemberModel.h"//因为无需MemberDetailModel所以可用同一模型替代

@interface MemberDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>


{
    
    
    UITableView *_tableview;
    NSMutableArray *_dataArray;
//    UIButton *Savebtn;
    
//    BOOL BtnAction;
//    BOOL xiugai;
//
//    NSString *strRET;
    
//    int currPageIndex;
    NSString *currPagestr;
    NSString *EntId;
    
    



}



@end

@implementation MemberDetailViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    UILabel *label0 = [MyUtil createLabelFrame:CGRectMake(0, 64, self.view.frame.size.width, 40) title:@"会员信息:" textAlignment:NSTextAlignmentLeft];
    label0.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:label0];
    UILabel *label1 = [MyUtil createLabelFrame:CGRectMake(0, 64+label0.frame.size.height, self.view.frame.size.width, 40) title:[NSString stringWithFormat:@"会员名字：%@", self.model.StaffName] textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label1];
    UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(0, CGRectGetMaxY(label1.frame), self.view.frame.size.width, 40) title:[NSString stringWithFormat:@"手机号：%@", self.model.Mobile] textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label2];
    
#if 0
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntId= [df objectForKey:@"GUID"];
    
    

    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;

    
    [self download];
    [self createNav];
    [self createTableView];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"会员详情"];
    
#endif
   
}




#if 0

-(void)createTableView
{
     _dataArray = [NSMutableArray array];
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 65, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    
    _tableview.delegate = self;
    _tableview.dataSource = self;
    
    [self.view addSubview:_tableview];
    
    
    
}





#pragma mark --UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return 1;
    }else
    {
        NSLog(@"%ld", _dataArray.count);
        return 1;//_dataArray.count;
    }
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, ScreenWidth, 35);
        
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 9, 80, 20) title:@"会员信息" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        
        [bgView addSubview:label];
        
        
        return bgView;
    }else
    {
        
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, ScreenWidth, 35);
        
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 9, 80, 20) title:@"会员明细" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        
        [bgView addSubview:label];
        
        
        return bgView;
    }
    
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中状态
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        return 100;
        
    }else
    {
        return  40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *cellID = @"cellID";
    static NSString *cellstateID = @"statecellID";
    
    if (indexPath.section == 0) {
        MemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == 0) {
            
            cell = [[MemberDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
//            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
#pragma mark_________________________________________________________________
//        MemberModel *cellModel = _dataArray[indexPath.row];
//        
//        cell.cellModel = cellModel;
//        
        
//        cell.userInteractionEnabled = NO;
        
        return cell;
        
    }else
    {
        MemberDetaiTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == 0) {
            
            cell = [[MemberDetaiTwoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            
        }
        
        
        
        
        return cell;
        
        
        
    }
    
    
    
    
}






-(void)backAction:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}



#pragma mark --下载


#pragma mark --下载(有两个参数没有取值)

-(void)download
{
    _cardType = @"09ec8d0a9cd545f9827381702ed27cba";
    _storeId = @"0d6a1411d71b4643bdc5c13c1e8af117";
    
    NSString *str = [NSString stringWithFormat:@GetAllMemberCardToListUrl];
    
    NSDictionary * params = @{@"entId":EntId,@"storeId":_storeId,@"cardType":_cardType,@"currPageIndex":currPagestr,@"pageSize":@"-1",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
//         //保存下载的数据用于缓存
//         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"6" AndType:CacheTypeQuestion];
         
         
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
                 
                 
//                 [_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [_dataArray addObject:model];
                     NSLog(@"======%ld",_dataArray.count);
                 }
                 [_tableview reloadData];

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








#endif

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
