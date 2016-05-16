//
//  MemberViewController.m
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "MemberViewController.h"
#import "MemberDetailViewController.h"//会员详情
#import "MainViewController.h"
#import "ChangeBtn.h"
#import "MemberCell.h"//会员
#import "MemberModel.h"
#import "Cardcell.h"
#import "CardModel.h"

#import "AllStoreCell.h"//popView显示数据
#import "AllStoreModel.h"

#import "AFHTTPSessionManager.h"

@interface MemberViewController ()<UITableViewDelegate, UITableViewDataSource>

{
    
    UITableView *_tableView;
    UITableView *_popViewTableview;
    UITableView *_TwoPopViewTableView;
    
    UIView *_TopHeaderView;
    UIView *_view;//弹出的透明遮罩
    
    UIButton *_chgtn;//点击弹出选择view
    UIButton *_btnq;
    
    
    ChangeBtn *_btnTag;
    BOOL _isShow;//有没有显示
    UIButton * _lastBtn;//上一个btn
    ChangeBtn *_selectedButton;//颜色赋给btn
    NSUInteger  _selectedIndex;//下标

    
    //没有网络的背景图
    UIView *NotSigview;
    
    //菊花
    MBProgressHUD *HUD;
    
    
    NSString *EntID;//企业id
    NSString *storeId;//店铺id
    NSString *cardType;
    
    NSString *bgyl;//店铺名
    NSString *typeName;//会员卡（类型名汉字）

    
    
    int currPageIndex;
    int s;
    NSString *currPagestr;
    
    UILabel *cards;
    
}

@property(nonatomic,retain)NSMutableArray *dataArray;//会员数据

@property(nonatomic,retain)NSMutableArray *StoreDataArray;//店铺的数据

@property(nonatomic,retain)NSMutableArray *CardDataArray;//会员卡类型



@end

@implementation MemberViewController


-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}

-(NSMutableArray *)StoreDataArray
{
    if (_StoreDataArray == nil) {
        
        _StoreDataArray = [NSMutableArray array];
        
    }
    
    return _StoreDataArray;
    
}

-(NSMutableArray *)CardDataArray
{
    if (_CardDataArray == nil) {
        
        _CardDataArray = [NSMutableArray array];
        
    }
    
    return _CardDataArray;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    EntID= [df objectForKey:@"GUID"];
    
    
    NSString *page = [NSString stringWithFormat:@"%d",0];
    
    currPagestr = page;
    
    [self downloadStore];
    
//    [self sharedClient];//检查实时网络
    
    [self createTableview];
    
    [self createPoPviewTableview];
    

    
    [self createNav];


    
    _selectedButton = [ChangeBtn buttonWithType:UIButtonTypeSystem];
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"会员"];
    
    
    [self hid];//隐藏刷新时间
    
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self loadData];
        [self downloadMore];
        [_tableView.footer endRefreshing];
        
    }];
    

}




- (void)hid
{
    
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    
    _tableView.header = header;
}


-(void)loadNewData
{
    
    if ([storeId isKindOfClass:[NSNull class]] || storeId == nil) {
        
        
        [_tableView.header endRefreshing];
        return;
        
        
        
    }else
    {
        
        currPagestr = [NSString stringWithFormat:@"%d",0];
        currPageIndex = s * 0;
        
        
        [self download];
    
        
        [_tableView.header endRefreshing];
        
        
        
    }
    
    
    
    
    
}





//加载的 index
-(void)loadData
{
    
    
    currPagestr = [NSString stringWithFormat:@"%d",0];
    s = currPageIndex +1;
    currPageIndex = s;
    currPagestr = [NSString stringWithFormat:@"%d",s];
    
    
    
}



-(void)backAction:(UIButton *)sender
{
    
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


-(void)createTableview
{
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 44, ScreenWidth, ScreenHeight-9) style:UITableViewStyleGrouped];
    
    _tableView.showsVerticalScrollIndicator = NO;
    
    //_tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    
    _tableView.separatorStyle = UITableViewCellEditingStyleNone;
    
    [self.view addSubview:_tableView];
    
    
    
    
    _TopHeaderView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 45)];
    
    
    _TopHeaderView.backgroundColor = [UIColor whiteColor];

    _tableView.tableHeaderView = _TopHeaderView;
    
    
    
    
    
    
    
}

#pragma maek -popViewTableview
-(void)createPoPviewTableview
{
    
    _view= [[UIView alloc]init];
    _view.frame = CGRectMake(0,110, ScreenWidth, 0);
    _view.backgroundColor = [[UIColor grayColor]colorWithAlphaComponent:0.5];
    _view.clipsToBounds = YES;//截断
    [self.view  addSubview:_view];
    
    
    
    _popViewTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    
    _popViewTableview.delegate = self;
    _popViewTableview.dataSource = self;
    
    [_view addSubview:_popViewTableview];
    
    
    
    
    _TwoPopViewTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth,250) style:UITableViewStylePlain];
    
    _TwoPopViewTableView.delegate = self;
    _TwoPopViewTableView.dataSource = self;
    [_view addSubview:_TwoPopViewTableView];

    
}


#pragma mark--scan
-(void)createScan
{
    
    
    
    //上层线条
    
    UIImageView *TopLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 0, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_TopHeaderView addSubview:TopLine];
    
    //中间的线条
    UIButton  *Linebtn = [MyUtil createBtnFrame:CGRectMake(ScreenWidth/2.01, 10, 0.5, 25) image:nil selectedImage:nil target:nil action:nil];
    
    Linebtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1];
    
    [_TopHeaderView addSubview:Linebtn];
    
    //下面的线条
    UIImageView *LowLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 45, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [_TopHeaderView addSubview:LowLine];
    
    
    
    NSArray *images = @[@"24x14_xiala@2x",@"24x14_xiala@2x"];
    
    
    NSArray *titles = @[@"所有店铺",@"全部卡型"];
    
    CGFloat width = ScreenWidth/2;
    
    for (int i= 0; i<2; i++) {
        
        CGRect frame = CGRectMake((width*(i%2)+ScreenWidth/12.5), 10, ScreenWidth/3, 30);
        
        _chgtn =[ChangeBtn buttonWithType:UIButtonTypeCustom];
        
        
        _chgtn.frame = frame;
        [
        _chgtn setTitle:titles[i] forState:UIControlStateNormal];
        _chgtn.titleLabel.font = [UIFont systemFontOfSize:15];
        
        
        
        [_chgtn addTarget:self action:@selector(OpenView:) forControlEvents:UIControlEventTouchUpInside];
        [_TopHeaderView addSubview:_chgtn];
        
        _selectedIndex = 0;
        
        [_chgtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:150.0/255.0 blue:61.0/255.0 alpha:1] forState:UIControlStateSelected];
        [_chgtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        
        [_chgtn setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        _chgtn.tag = 10+i;
        
    }
    
    
}





#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    if (tableView == _tableView)
    {
        return self.dataArray.count;
        
    }else if (tableView == _popViewTableview)
    {
        return self.StoreDataArray.count;
        
    }else if (tableView == _TwoPopViewTableView)

    {
        return self.CardDataArray.count;
    }else
    {
        return 1;
        
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView == _tableView) {
        return 100;
    }else
    {
        return 35;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (tableView == _tableView)
    {
        
        MemberDetailViewController *memberCtrl = [[MemberDetailViewController alloc]init];
        
        memberCtrl.model = self.dataArray[indexPath.row];
        
        
//        memberCtrl.storeId = model.StoreID;
//        memberCtrl.mobile = model.Mobile;
//        
//        memberCtrl.cardType = model.CardType;
//        memberCtrl.memberId = model.MemberId;//这个是会员唯一的标示
//        
//        memberCtrl.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self.navigationController pushViewController:memberCtrl animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中状态

        
    }else if (tableView == _popViewTableview)
    {
        
        
        NSArray *arr = [_TopHeaderView subviews];

        
        
        for (_chgtn in arr)
        {
            
            
            if (_chgtn.tag == 10) {
                

                
                //点击cell 修改 btn 文字 并下载数据
                AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];

            //    CardModel *cellModel1 = self.CardDataArray[indexPath.row];
                
                EntID = cellModel.EnterpriseID;
                bgyl = cellModel.StoreName;
                
                
                storeId = cellModel.GUID;
           //     cardType = cellModel1.CardTypeId;
                
                //选择店铺的时候，下载所选店铺的数据
                
                [self download];
                [_chgtn setTitle:bgyl forState:UIControlStateNormal];
                
                //改变的时候缩回 然后 下载
                [self changes];
                
                
            }
            
        }
        
        
        
        
        
    }else if (tableView == _TwoPopViewTableView)
    {
            
        NSArray *arr = [_TopHeaderView subviews];
        

        
            
            for (_chgtn in arr) {
                
                
                if (_chgtn.tag == 11) {
                    
                    NSArray *cardName = @[@"会员卡",@"普卡",@"银卡",@"金卡",@"白金卡",@"钻石卡"];
                    
                    if (indexPath.row == 0) {
                        
                        
                        NSString *str = [NSString stringWithFormat:@"%@",cardName[0]];
                        
                        [_chgtn setTitle:str forState:UIControlStateNormal];
                        
                        
                        cardType = @"28e5a34fdda74ee4a3c46f1621f3c984";
                        //选择卡的类型的时候，下载所选卡类型的的数据
                        [self download];
                        
                    }
                    else if (indexPath.row == 1){
                        
                        NSString *str = [NSString stringWithFormat:@"%@",cardName[1]];
                        
                        [_chgtn setTitle:str forState:UIControlStateNormal];
                        
                        
                        cardType = @"78a120fd89e74f2493a26b6152c25803";
                        //选择卡的类型的时候，下载所选卡类型的的数据
                        [self download];
                    }

                    else if (indexPath.row == 2){
                        
                        NSString *str = [NSString stringWithFormat:@"%@",cardName[2]];
                        
                        [_chgtn setTitle:str forState:UIControlStateNormal];
                        
            
                        cardType = @"09ec8d0a9cd545f9827381702ed27cba";
                        //选择卡的类型的时候，下载所选卡类型的的数据
                        [self download];
                    }
                    else if (indexPath.row == 3){
                        
                        NSString *str = [NSString stringWithFormat:@"%@",cardName[3]];
                        
                        [_chgtn setTitle:str forState:UIControlStateNormal];
                       
                        cardType = @"c0e00b2ed9154aed9259b763d7accd30";
                        //选择卡的类型的时候，下载所选卡类型的的数据
                        [self download];
                    }
                    else if (indexPath.row == 4){
                        
                        NSString *str = [NSString stringWithFormat:@"%@",cardName[4]];
                        
                        [_chgtn setTitle:str forState:UIControlStateNormal];
                        
                        cardType = @"bc560d1d1c3a441a8b794d35ce3af409";
                        //选择卡的类型的时候，下载所选卡类型的的数据
                        [self download];
                    }
                    else if (indexPath.row == 5){
                        
                        NSString *str = [NSString stringWithFormat:@"%@",cardName[5]];
                        
                        [_chgtn setTitle:str forState:UIControlStateNormal];
                        
    
                        cardType = @"2fc57cbc2ab9473e8b0bf743bbb9ac94";
                        //选择卡的类型的时候，下载所选卡类型的的数据
                        [self download];
                    }
                    
                    
                    //改变的时候缩回 然后 下载
                    [self changes];
                    
                    
                }
                
            }
            
            
    
        
        
        
#if 0
        NSArray *arr = [_TopHeaderView subviews];
        
        for (_chgtn in arr) {
            
            
            if (_chgtn.tag == 11) {
                
                

                
                CardModel *cellModel = self.CardDataArray[indexPath.row];
                
                cardType = cellModel.CardTypeId;
                
                typeName = cellModel.TypeName;
                
                
                
                //选择卡的类型的时候，下载所选卡的类型的数据
                [self download];
                
    
                [_chgtn setTitle:typeName forState:UIControlStateNormal];

                
                //改变的时候缩回 然后 下载
                [self changes];
                
                

                
                }
                
                

                
                
            }
#endif
        
        }
    
    
    
    

    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    static NSString *popCellID = @"popCellID";
    static NSString *TwoCellID = @"TwoCellID";
    if (tableView == _tableView) {
        MemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        
        if (cell == nil) {
            cell = [[MemberCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 99.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            
            //箭头
            UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 41, 10, 15) imageName:@"my_arrow_17X30@2x"];
            [cell addSubview:arrowImage];
            
        }
        
        
        MemberModel *cellModel = self.dataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        
        
        return cell;
        
        
    }else if (tableView == _popViewTableview){
        
        AllStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:popCellID];
        
        if (cell == nil) {
            cell = [[AllStoreCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:popCellID];
            
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        AllStoreModel *cellModel = self.StoreDataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        //        bgyl = cellModel.StoreName;
        //        NSLog(@"%@",bgyl);
        
        return cell;
        
    }else{
        
        CardCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoCellID];
    
        if (cell == nil) {
            cell = [[CardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellID];
            
        }
        
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

        
        CardModel *cellModel = self.CardDataArray[indexPath.row];
        
        cell.cellModel = cellModel;
        
        
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TwoCellID];
//        
//        
//        if (cell == nil) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TwoCellID];
//            
//            
//            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//            
//            
//            for (int i = 0; i < self.CardDataArray.count; i++) {
//                if (indexPath.row == i) {
//                    
//                    NSArray *cardName = @[@"全部类型",@"会员卡",@"普卡",@"银卡",@"金卡",@"白金卡",@"钻石卡"];
//                    NSString *cardNameStr = cardName[i];
//
//                    cards = [MyUtil createLabelFrame:CGRectMake(10, 5, 70, 30) title:cardNameStr textAlignment:NSTextAlignmentLeft];
//                    
//                    cards.font = [UIFont systemFontOfSize:15];
//                    
//                    [cell addSubview:cards];
//                }
//            }
//            
//            
//            
//        }
        
        return cell;
    
    }
    
    
    
}





#pragma mark --下载会员信息

-(void)download


{

    
//    [self juhua];
    NSString *str = [NSString stringWithFormat:@GetAllMemberCardToListUrl];
    if (!storeId) {
        storeId = @"";
    }
    if (!cardType) {
        cardType = @"";
    }
    
    NSDictionary * params = @{@"entId":EntID,@"storeId":storeId,@"cardType":cardType,@"currPageIndex":currPagestr,@"pageSize":@"-1",@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"6" AndType:CacheTypeQuestion];
         
         
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
                 
                 
                 [_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];

                     
                     MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                 }
                 
                 
                 [_tableView reloadData];
                 
                 
                 NotSigview.hidden = YES;//隐藏无网络视图
                 [HUD hide:YES];
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


-(void)downloadMore
{
    

    
 //   [self juhua];
    NSString *str = [NSString stringWithFormat:@GetAllMemberCardToListUrl];
    
    NSDictionary * params = @{@"entId":EntID,@"storeId":storeId,@"cardType":cardType,@"currPageIndex":currPagestr,@"pageSize":@"-1",@"code":@"gy7412589630"};
    
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
                     
                     //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                     
                     MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     [self.dataArray addObject:model];
                 }
                 [_tableView reloadData];
                 NotSigview.hidden = YES;//隐藏无网络视图
                 //[HUD hide:YES];
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}



#pragma mark --下载店铺

-(void)downloadStore
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
                 
                 if (arr1.count == 0) {
                     
                     return ;
                 }
                 

                 [self.StoreDataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
//                 AllStoreModel *model = [[AllStoreModel alloc] init];
//                 model.StoreName = @"所有数据";
//                 model.EnterpriseID = EntID;
//                 [self.StoreDataArray addObject:model];
                 
                 
                 NSLog(@"haha--------");
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     
                     AllStoreModel *model = [[[AllStoreModel alloc]init]initWithDictionary:sssDict];

                     
                     [self.StoreDataArray addObject:model];
                     
                     NSLog(@"------------------%ld",_StoreDataArray.count);

                     
                     
                     
//                     //判断断网的时候，店铺名是否为空。如果空的，代表数据缓存清除了。那么_TopHeaderView,就没有加载过。防止
//                     bgyl = model.StoreName;
//                     storeId = model.GUID;
                     
                     
                     
                 }
                 
                 [_popViewTableview  reloadData];
                 
                 
 

                 
                 [self createScan];


                 
                 
                 //自动选择店铺
//                 if ([_popViewTableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//                     
//                     NSArray *arr = [_TopHeaderView subviews];
                 
                     
//                     for (_chgtn in arr) {
                         
//                         if (_chgtn.tag == 10) {
//                             
//                             NSInteger selectedIndex = 0;
//                             NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
//                             [_popViewTableview selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//                             [_popViewTableview.delegate tableView:_popViewTableview didSelectRowAtIndexPath:selectedIndexPath];
//                             
//                             [self changes];
//                             
//                         }
//                         if (_chgtn.tag == 11) {
//                             
//                             NSInteger selectedIndex = 0;
//                             NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
//                             [_TwoPopViewTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//                             [_TwoPopViewTableView.delegate tableView:_popViewTableview didSelectRowAtIndexPath:selectedIndexPath];
//                             
//                             [self changes];
                         
//                         }

//                     }
                     
//                 }
                 
                 
                 
                 
                 
                 
             }
         }
         [self downloadCard];
         

         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
         
         
     }];
    
}






#pragma mark --下载会员卡

-(void)downloadCard
{
    
    NSString *str = [NSString stringWithFormat:@GetAllCardTypeToListUrl];
    
    NSDictionary * params = @{@"entId":EntID,@"code":@"gy7412589630"};
    
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
         
         //保存下载的数据用于缓存
         [CacheManager saveCacheWithObject:responseObject ForURLKey:@"4" AndType:CacheTypeQuestion];
         
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
                 
                 if (arr1.count == 0) {
                     
                     return ;
                 }
                 

                [self.CardDataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                 
                 for (NSDictionary *dict in arr1) {
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     

                     
                     CardModel *model = [[[CardModel alloc]init]initWithDictionary:sssDict];
        
                     
                     [self.CardDataArray addObject:model];
                     

                     
                     
                     
                     //判断断网的时候，店铺名是否为空。如果空的，代表数据缓存清除了。那么_TopHeaderView,就没有加载过。防止
//                     cardType = model.CardTypeId;
                     
                     
                     
                 }
                 
                NSLog(@"%ld", _StoreDataArray.count);
                 
                 [_TwoPopViewTableView  reloadData];
                 

                 
                 
                 
                 //自动选择会员卡类型
//                 if ([_TwoPopViewTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
//                     
//                     NSArray *arr = [_TopHeaderView subviews];
//                     
//                     
//                     for (_chgtn in arr) {
//                         
//                         if (_chgtn.tag == 11) {
//                             
//                             NSInteger selectedIndex = 0;
//                             NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
//                             [_TwoPopViewTableView selectRowAtIndexPath:selectedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
//                             [_TwoPopViewTableView.delegate tableView:_TwoPopViewTableView didSelectRowAtIndexPath:selectedIndexPath];
//                             
//                             [self changes];
//                             
//                         }
//                     }
//                 }
                 
                 
                 
             }
             
         }
         [self download];
         
     }
    failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
         
         
     }];
    
}



-(void)OpenView:(ChangeBtn *)btn
{
    
    //显示的时候禁用tableview滚动
    _tableView.scrollEnabled = NO;
    //        _selectedButton.selected = NO;
    //
    //    btn.selected = YES;
    //
    switch (btn.tag-10) {
        case 0:
        {
            
            
            
            _TwoPopViewTableView.hidden = YES;
            _popViewTableview.hidden = NO;

            
        }
            break;
            
        case 1:
        {
            _popViewTableview.hidden = YES;
            _TwoPopViewTableView.hidden = NO;

            
            
        }
            break;
            
        default:
            break;
    }
    
    _btnTag = btn;
    
    
    [self changes];
    
    
    if (_chgtn.tag == 10) {
        
        _btnq= [[UIButton alloc]init];
        
        _btnq = _chgtn;
        
    }
    
    
}


-(void)changes
{
    
    _selectedButton.selected = NO;
    
    _btnTag.selected = YES;
    
    
    
    CGRect frame = _view.frame;
    
    //判断现在点击的btn ，如果上个btn显示就把它收起来
    if (_lastBtn && _lastBtn != _btnTag) {
        if (_isShow) {
            frame.size.height -= ScreenHeight;
            _view.frame = frame;
            //判断最后一个btn是否收起 如果收起就变灰色的箭头
            [_lastBtn setImage:[UIImage imageNamed:@"shoplist_down_icon_jax"] forState:UIControlStateNormal];
            _isShow = NO;
        }
    }
    //设置动画时间
    CGFloat duration = 0.35f;
    if (!_isShow) {
        duration = 0.65f;
        //显示的时候禁用tableview滚动
        //_tableView.scrollEnabled = NO;
    }
    
    _isShow ?(frame.size.height -= ScreenHeight) :(frame.size.height += ScreenHeight);
    
    //如果显示就变绿，没有显示就变灰
    if (!_isShow) {
        [_btnTag setImage:[UIImage imageNamed:@"24x14_famhui@2x"] forState:UIControlStateNormal];
    }else {
        [_btnTag setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
        
        _tableView.scrollEnabled = YES;
    }
    
    //引用计数加1
    __weak typeof (_view) weakView = _view;
    
    //缩回动画
    [UIView animateWithDuration:duration animations:^{
        weakView.frame = frame;
        
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    //动画执行完成后，就不显示
    _isShow = !_isShow;
    _lastBtn = _btnTag;
    
    _selectedButton =_btnTag;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
    
    if (_isShow) {
        [self changes];
        
        
        //显示的时候启用tableview滚动
        _tableView.scrollEnabled = YES;
    }
    
    
}







#pragma mark-缓存

-(void)Caches
{
    if ([CacheManager readCacheWithURLKey:@"6" andType:CacheTypeQuestion]) {
        
        id result = [CacheManager readCacheWithURLKey:@"6" andType:CacheTypeQuestion];
        
        NSError *error = nil;
        
        //xml解析
        NSDictionary *dict = [XMLReader dictionaryForXMLData:result error:&error];
        

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
                    
                    
                    //[_dataArray removeAllObjects];//每次添加数据前清空所有对象，不然会造成重复数据
                    
                    MemberModel *model = [[[MemberModel alloc]init]initWithDictionary:sssDict];
                    
                    
                    [self.dataArray addObject:model];
                }
                [_tableView reloadData];
                
            }
        }
        
        
        
        
    }else
    {
        
        
        [self download];
    }
    
}




#pragma mark -- 检测实时的网络状况
-(void)sharedClient
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    //2.设置监听
    //-设置网络监听
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
                
            case AFNetworkReachabilityStatusNotReachable:
                
                
                
                if (self.dataArray != nil) {
                    
                    
                    
                    
                    
                    if ([CacheManager readCacheWithURLKey:@"6" andType:CacheTypeQuestion]!= nil) {
                        
                        NSLog(@"在无网情况下，有缓存。");
                        
                        
                        
                    }else
                    {
                        NotSigview= [[UIView alloc]init];
                        NotSigview.frame = CGRectMake(0, 90, ScreenWidth, ScreenHeight);
                        
                        [_tableView addSubview:NotSigview];
                        NSLog(@"不可达的网络(未连接)");
                    }
                    
                    
                }else
                {
                    
                    
                    
                }
                
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                
                NSLog(@"2G,3G,4G...的网络");
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                //                NSLog(@"wifi的网络");
                //                [self Caches];
                //                [HUD hide:YES];
                
                // [self downloadMoney];
                
            }
                
                break;
            default:
                break;
        }
    }];
    //3.开始监听
    [manager startMonitoring];
    
    
    
    
}



-(void)Action:(UIButton *)sender
{
    
    
    [self Caches];
    [HUD hide:YES];
    
    
    
}

#pragma mark - 菊花加载

-(void)juhua
{
    HUD =  [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    HUD.userInteractionEnabled = NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
