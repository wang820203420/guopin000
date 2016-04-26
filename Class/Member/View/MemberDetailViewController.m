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
#import "MemberModel.h"//因为无需MemberDetailModel所以可用同一模型替代

@interface MemberDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>


{
    
    
    UITableView *_tableview;
    UIButton *Savebtn;
    
    BOOL BtnAction;
    BOOL xiugai;
    
    NSString *strRET;
    
}


@property(nonatomic,retain)NSMutableArray *dataArray;


@end

@implementation MemberDetailViewController


-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        self.dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self download];
    [self createNav];
    [self createTableView];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"会员详情"];
    
    
   
}






-(void)createTableView
{
    
    
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    
    
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
        return self.dataArray.count;
    }else
    {
        return 1;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        return 200;
    }else
    {
        return  50;
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];// 取消选中状态
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    static NSString *cellID = @"cellID";
    static NSString *cellstateID = @"statecellID";
    
    if (indexPath.section == 0) {
        MemberDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (cell == nil) {
            
            cell = [[GoodsMngDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        
        GoodsMngDetModel *cellModel = self.dataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        
        //cell.userInteractionEnabled = NO;
        
        cell.RetailPrice.delegate = self;
        return cell;
        
    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstateID];
        
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstateID];
            
            
            
            UILabel *GoodsAction = [MyUtil createLabelFrame:CGRectMake(10, 15, 80, 20) title:@"上架" textAlignment:NSTextAlignmentLeft];
            GoodsAction.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            GoodsAction.font = [UIFont systemFontOfSize:16];
            [cell addSubview:GoodsAction];
            
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            
            UISwitch *mySwitch = [[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 9, 30, 30)];
            
            //mySwitch.backgroundColor = [UIColor grayColor];
            
            mySwitch.onTintColor = [UIColor colorWithRed:73.0/255.0 green:160.0/255.0 blue:61.0/255.0 alpha:1];
            
            [mySwitch addTarget:self action:@selector(MyAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            
            //判断状态，修改上下架
            NSNumber  *floatNumber = [NSNumber numberWithFloat:1];
            
            if ([_Forbidden isKindOfClass:[NSNull class]]) {
                
                
                
                
            }else
            {
                if ([_Forbidden isEqualToNumber:floatNumber] == YES ) {
                    
                    
                    mySwitch.on = NO;
                    
                    
                } else {
                    
                    mySwitch.on = YES;
                    
                    
                }
                
            }
            
            
            
            [cell addSubview:mySwitch];
            
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 49, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            
            //线条
            CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
            UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
            [cell addSubview:Lowimage1];
            
            
            
            
        }
        
        
        
        
        return cell;
        
        
        
    }
    
    
    
    
}
//发送到服务端
-(void)MyAction:(id)sender
{
    UISwitch *mySwitch = (UISwitch *)sender;
    
    if (mySwitch.isOn) {
        
        NSLog(@"上架");
        
        NSString *str = [NSString stringWithFormat:@UpdateGoodsStateByIdUrl];
        NSDictionary * params = @{@"id":_GUID,@"state":@"2",@"code":@"gy7412589630"};
        
        [AFHTTPClientV2 requestWithBaseURLStr:str
                                       params:params
                                   httpMethod:kHTTPReqMethodTypePOST
                                     userInfo:nil
                                      success:^(AFHTTPClientV2 *request, id responseObject)
         {
             NSLog(@"%@",responseObject);
             NSLog(@"%@", NSStringFromClass([responseObject class]));
             
             NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"%@", str);
             
         }
                                      failure:^(AFHTTPClientV2 *request, NSError *error)
         {
             NSLog(@"%@",error);
         }];
        
    }else
    {
        
        
        
        NSString *str = [NSString stringWithFormat:@UpdateGoodsStateByIdUrl];
        NSDictionary * params = @{@"id":_GUID,@"state":@"1",@"code":@"gy7412589630"};
        
        [AFHTTPClientV2 requestWithBaseURLStr:str
                                       params:params
                                   httpMethod:kHTTPReqMethodTypePOST
                                     userInfo:nil
                                      success:^(AFHTTPClientV2 *request, id responseObject)
         {
             NSLog(@"%@",responseObject);
             NSLog(@"%@", NSStringFromClass([responseObject class]));
             
             NSString * str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
             NSLog(@"%@", str);
             
         }
                                      failure:^(AFHTTPClientV2 *request, NSError *error)
         {
             NSLog(@"%@",error);
         }];
        
        NSLog(@"下架");
        
        
        
        
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
    
    
    NSString *str = [NSString stringWithFormat:@GetGoodsInfoByIdUrl];
    
    NSDictionary * params = @{@"id":_GUID,@"code":@"gy7412589630"};
    
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
             
             
             [self.dataArray removeAllObjects];
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSDictionary *subDict2 = [subDict1 objectForKey:@"Data"];
                 
                 
                 
                 NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:subDict2];
                 
                 NSLog(@"%@",sssDict);
                 
                 
                 
                 GoodsMngDetModel *model = [[[GoodsMngDetModel alloc]init]initWithDictionary:sssDict];
                 
                 
                 [self.dataArray addObject:model];
                 NSLog(@"======%ld",self.dataArray.count);
                 
                 
                 
             }
             [_tableview reloadData];
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}




#pragma mark -- uitextview 代理 修改售价
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self resignFirstResponder];
}

-(void)editorAction:(UIButton *)sender
{
    
    
    
    BtnAction = YES;
    
    
    //自动选择店铺
    if ([_tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        
        NSInteger selectedIndex = 0;
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [_tableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_tableview.delegate tableView:_tableview didSelectRowAtIndexPath:selectedIndexPath];
        
        
    }
    
    
    
    
    
}



-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    
    xiugai = YES;
    
    
    //自动选择店铺
    if ([_tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        
        
        NSInteger selectedIndex = 0;
        NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        [_tableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
        [_tableview.delegate tableView:_tableview didSelectRowAtIndexPath:selectedIndexPath];
        
        
    }
    
    
    if ([text isEqualToString:@"\n"]) {
        
        
        
        
        BtnAction = NO;
        
        
        //自动选择店铺
        if ([_tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            
            
            NSInteger selectedIndex = 0;
            NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
            [_tableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            [_tableview.delegate tableView:_tableview didSelectRowAtIndexPath:selectedIndexPath];
            
            
        }
        
        //过滤非法字符
        NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+ "];
        
        strRET = [[strRET componentsSeparatedByCharactersInSet: doNotWant]componentsJoinedByString:@""];
        
        
        //保存数据，上传服务器
        
        
        NSString *str = [NSString stringWithFormat:@UpdateGoodsPriceByIdUrl];
        
        NSDictionary * params = @{@"id":_GUID,@"retailPrice":strRET,@"code":@"gy7412589630"};
        
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
                     
                     
                     
                     NSDictionary *subDict1 = [dic objectForKey:@"Result"];
                     
                     
                     NSString *sre = [NSString stringWithFormat:@"%@",subDict1];
                     int str = [sre intValue];
                     
                     if ( str == 1) {
                         
                         
                         NSLog(@"成功");
                         
                         
                         [self download];
                         
                         
                         
                         
                     }else
                     {
                         
                         NSLog(@"成功");
                     }
                     
                 }
                 
                 
                 
             }
             
             
             
             
         }
                                      failure:^(AFHTTPClientV2 *request, NSError *error)
         {
             NSLog(@"%@",error);
         }];
        
        
        return NO;
    }
    return YES;
}

////正则表达式的判断
//- (BOOL) regexFlagWith:(NSString *)regex withParameter:(NSString *)parameter{
//
//    NSPredicate *pass = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
//
//    return [pass evaluateWithObject:parameter];
//
//}


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










- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
