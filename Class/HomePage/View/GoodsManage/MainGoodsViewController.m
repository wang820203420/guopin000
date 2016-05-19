//
//  MainGoodsViewController.m
//  guoping
//
//  Created by zhisu on 16/1/5.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MainGoodsViewController.h"
#import "MainGoodsModel.h"
#import "AddViewController.h"
@interface MainGoodsViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *pkview;
    NSString *entID;//entid
    
    NSMutableArray *arrar ;
    
    NSString *className;
    NSString *Guidstr;//guid
    NSString *goodsCode;
}
@property(nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation MainGoodsViewController
-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    entID = [df objectForKey:@"GUID"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    
    
    [self createPkview];
    
    [self download];
    
    
    
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"所属主商品"];
    
    
}



-(void)backAction:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)saveAction:(UIButton *)sender
{
    
    self.block(className);
    self.guid(Guidstr);
    [self.navigationController popViewControllerAnimated:YES];
    
}




-(void)createPkview{
    
    [self createHeaderView];
    [self createBackgroundView];
    
    pkview = [[UIPickerView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2-150, ScreenWidth, 300)];
    pkview.dataSource = self;
    pkview.delegate = self;
    
    [self.view addSubview:pkview];
    
}

//创建一个headerView
- (void)createHeaderView
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, ScreenWidth, 40)];
    headerView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    [self.view addSubview:headerView];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(ScreenWidth-60, 30, 50, 30);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize: 14.0];
    
    [btn addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
    
}

- (void)createBackgroundView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 180, ScreenWidth, 300)];
    bgView.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.1];
    //把view倒角依据半径倒圆角
    bgView.layer.cornerRadius = 30.0;
    bgView.layer.masksToBounds = YES;
    [self.view addSubview:bgView];
    
    
    
    
    
}








#pragma mark -- pkview代理

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    
    
    return self.dataArray.count;
    
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 45;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    MainGoodsModel *model = [self.dataArray objectAtIndex:row];
    
    Guidstr = [NSString stringWithFormat:@"%@",model.GUID];
    className = [NSString stringWithFormat:@"%@",model.GoodsName];
    goodsCode = [NSString stringWithFormat:@"%@",model.GoodsCode];
    
    NSString *str = [NSString stringWithFormat:@"%@-%@", goodsCode, className];

    
    
    return  str;
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    
    MainGoodsModel *model = [self.dataArray objectAtIndex:row];
    
    
    Guidstr = [NSString stringWithFormat:@"%@",model.GUID];
    className = [NSString stringWithFormat:@"%@",model.GoodsName];
    goodsCode = [NSString stringWithFormat:@"%@",model.GoodsCode];
 
    
    
    
    
    
}

#pragma mark--- 下载
-(void)download
{
    
    NSLog(@"%@",entID);
    
    
    NSString *str = [NSString stringWithFormat:@GetGoodNot2LeaveListUrl];
    
    NSDictionary * params = @{@"entId":entID,@"code":@"gy7412589630"};
    
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
             
             
             //[dataArray removeAllObjects];
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 if (arr1.count == 0) {
                     
                     return ;
                 }
                 for (NSDictionary *dict in arr1) {
                     
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     
                     
                     MainGoodsModel  *model = [[[MainGoodsModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     
                     [self.dataArray addObject:model];
                     
                     
                     
                 }
                 
                 
                 
             }
             
  
             
             [pkview reloadComponent:0];
            
            //; className = [self.dataArray objectAtIndex:0];
             
   
             
         }
         
         
     }
      failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}



@end
