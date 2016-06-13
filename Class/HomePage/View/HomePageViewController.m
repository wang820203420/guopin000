//
//  HomePageViewController.m
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//
#define kCellID (@"cellID")
#define kCellID1 (@"cellID1")
#import "HomePageViewController.h"
#import "MainViewController.h"
#import "LogViewController.h"
#import "SaleInfoViewController.h"//销售信息
#import "GoodsMngViewController.h"//商品管理
#import "StockViewController.h"//库存查询
#import "ReplenishViewController.h"//进货信息
#import "LossViewController.h"//报损信息
#import "ToTheGoodsViewController.h"//要货信息
#import "RankingViewController.h"//店铺排行
#import "PropretyViewController.h"//财务报表
#import "LossRankViewController.h"//损耗排行
#import "CheckGoodsViewController.h"//门店盘点
#import "TransferViewController.h"//门店调货
#import "MoreInfoViewController.h"//更多信息
#import "AFHTTPClientV2.h"//下载
#import "XMLReader.h"//去掉外围的xml
#import "HomePageModel.h"//每日金额总结
#import "HomeAmountView.h"//每日金额总结view
#import "SetUpViewController.h"//设置

#import "HomePageModel.h"//今日销售总金额
#import "HomeAmountView.h"
@interface HomePageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    
    UICollectionView *_collectionView;
     NSArray *_array;
      NSMutableArray *_dataArray;
    
   // HomeAmountView *_LableView;
    
    HomeAmountView *BackGroundview;//今日销售总金额
    
    NSString *entID;//entid
}
@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    entID = [df objectForKey:@"GUID"];
    
    
    [self download];
    [self createNav];
    [self createCollectionView];
    

    
    [self addNavLabel:CGRectMake(10, ScreenHeight/33.5, ScreenWidth/3, ScreenHeight/16.75)  font:[UIFont systemFontOfSize:18] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft text:@"果品进销存"];
 
    
       [self addNavButton:CGRectMake(ScreenWidth-35, ScreenHeight/25, 25, 25) imageName:@"setting@2x"  target:self action:@selector(SetBtn:)];
    
//    [self addNavButton:CGRectMake(ScreenWidth-85, ScreenHeight/25, 40, 25)  text:@"刷新" target:self action:@selector(rfshAction:)];
//    

    //隐藏刷新时间
    [self hid];
    
     
}

-(void)hid
{
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    
    
    
    header.automaticallyChangeAlpha = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    
    //    [header beginRefreshing];
    
    _collectionView.header = header;
}


-(void)loadNewData
{

    
    [self download];
        [_collectionView.header endRefreshing];
        return;

}


//
//-(void)rfshAction:(UIButton *)sender
//{
//    
//    [self download];
//}

-(void)SetBtn:(UIButton *)btn
{
    NSLog(@"推出设置view");
    
    SetUpViewController *setCtrl = [[SetUpViewController alloc]init];
    
    
    [self.navigationController pushViewController:setCtrl animated:YES];
    
    
}

//创建视图
-(void)createCollectionView
{
    //数据
     _dataArray = [NSMutableArray array];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    
    layout.itemSize = CGSizeMake(ScreenWidth/3.02, ScreenHeight/4.7999);//九宫格
    //layout.itemSize = CGSizeMake(ScreenWidth/4.04, ScreenHeight/4.7999);//十二宫格
    //间距(横向)
    layout.minimumInteritemSpacing = ScreenWidth/ScreenWidth;
    
    //纵向间距
    layout.minimumLineSpacing = ScreenWidth/ScreenWidth;
    layout.sectionInset = UIEdgeInsetsMake(ScreenHeight/5, 0, ScreenHeight/33.5, 0);
    
   
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight/1.21)collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    
    //注册cell
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellID];
    
     [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellID1];
    
    _collectionView.backgroundColor = [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1];
    
    
    [self.view addSubview:_collectionView];
    
    
    BackGroundview = [[HomeAmountView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight/5.1)];
   BackGroundview.backgroundColor = [UIColor colorWithRed:85.0/255.0 green:180.0/255.0 blue:69.0/255.0 alpha:1];
    //BackGroundview.backgroundColor = [UIColor redColor];
    
    [_collectionView addSubview:BackGroundview];
    

    
    
    //获取系统当前时间
    NSDate *NowData = [NSDate date];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"YYYY-MM-dd"];
    
    NSString *time = [dateformatter stringFromDate:NowData];
    
    NSLog(@"%@",time);
    
    
    //时间日期
    UILabel *DayLabel = [MyUtil createLabelFrame:CGRectMake(25, ScreenHeight/74.5, 80, 30) title:time textAlignment:NSTextAlignmentLeft];
    DayLabel.textColor = [UIColor colorWithRed:161.0/255.0 green:161.0/255.0 blue:161.0/255.0 alpha:1];
    DayLabel.font = [UIFont systemFontOfSize:13];
     DayLabel.adjustsFontSizeToFitWidth = YES;
    [BackGroundview addSubview:DayLabel];
    
    //今日销售总额
    
    UILabel *TadayLabel = [MyUtil createLabelFrame:CGRectMake(25, ScreenHeight/15, ScreenWidth/3, 30) title:@"今日销售总金额" textAlignment:NSTextAlignmentLeft];
    TadayLabel.textColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
        //TadayLabel.font = [UIFont systemFontOfSize:16];
    TadayLabel.adjustsFontSizeToFitWidth = YES;
    
    [BackGroundview addSubview:TadayLabel];

    
    
    //今日销售总笔数
    
    UILabel *NumberLabel = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/1.829, ScreenHeight/15, ScreenWidth/3, 30) title:@"今日销售总笔数" textAlignment:NSTextAlignmentLeft];
    NumberLabel.textColor = [UIColor colorWithRed:155.0/255.0 green:155.0/255.0 blue:155.0/255.0 alpha:1];
    NumberLabel.adjustsFontSizeToFitWidth = YES;
    
    [BackGroundview addSubview:NumberLabel];
    

    
    
}


#pragma mark -collectiondelegate


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
        return 12;
    
  
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld",indexPath.item);
    
    
    
    if (indexPath.item == 0)
    {
        
        SaleInfoViewController *saleInfoCtrl = [[SaleInfoViewController alloc]init];
        [self.navigationController pushViewController:saleInfoCtrl animated:YES];
        
    }else if (indexPath.item == 1){
     
        StockViewController *stockCtrl = [[StockViewController alloc]init];
        [self.navigationController pushViewController:stockCtrl animated:YES];
        
    }else if (indexPath.item == 2){
        
        ReplenishViewController *replenCtrl = [[ReplenishViewController alloc]init];
        [self.navigationController pushViewController:replenCtrl animated:YES];
        
    }else if (indexPath.item == 3){
        
        LossViewController *lossCtrl = [[LossViewController alloc]init];
        [self.navigationController pushViewController:lossCtrl animated:YES];
        
    }else if (indexPath.item == 4){
        
        ToTheGoodsViewController *toCtrl = [[ToTheGoodsViewController alloc]init];
        [self.navigationController pushViewController:toCtrl animated:YES];
        
        }
    else if (indexPath.item == 5)

    {
        
        GoodsMngViewController *GoodsMngCtrl = [[GoodsMngViewController alloc]init];
        [self.navigationController pushViewController:GoodsMngCtrl animated:YES];
        
    }else if (indexPath.item == 6)
    {
        
        PropretyViewController *proCtrl = [[PropretyViewController alloc]init];
        [self.navigationController pushViewController:proCtrl animated:YES];
         
    }
    else if (indexPath.item == 7)
    {
        
        RankingViewController *rankCtrl = [[RankingViewController alloc]init];
        [self.navigationController pushViewController:rankCtrl animated:YES];
        
    }else if (indexPath.item == 8)
    {
        
        LossRankViewController *lossCtrl = [[LossRankViewController alloc]init];
        [self.navigationController pushViewController:lossCtrl animated:YES];
        
    } else if (indexPath.item == 9)
    {
        
        TransferViewController *TransferCtrl = [[TransferViewController alloc]init];
        [self.navigationController pushViewController:TransferCtrl animated:YES];
        
    }  else if (indexPath.item == 10)
    {
        
        CheckGoodsViewController *CheckCtrl = [[CheckGoodsViewController alloc]init];
        [self.navigationController pushViewController:CheckCtrl animated:YES];
        
    }  else if (indexPath.item == 11)
    {
        
        MoreInfoViewController *MoreInfoCtrl = [[MoreInfoViewController alloc]init];
        [self.navigationController pushViewController:MoreInfoCtrl animated:YES];
    }


    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
   
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID1 forIndexPath:indexPath];
        
        
        
        cell.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
    
    //删除重复的view
    for (UIImageView *view in cell.subviews) {
        
        [view removeFromSuperview];
    }
    
    
    
    if (indexPath.item == 0) {
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/9.375, ScreenWidth/9.375, ScreenWidth/10.135, ScreenHeight/23.929) imageName:@"xsxx_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, ScreenHeight/67) title:@"销售信息" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
        
        
    }else if (indexPath.item == 1)
    {
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/9.2, ScreenWidth/9.375, ScreenWidth/11.37, ScreenHeight/19.14) imageName:@"kccx_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, ScreenHeight/67) title:@"库存查询" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
      
    }else if (indexPath.item == 2)
    {
        
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/15, ScreenHeight/19.14) imageName:@"jhxx_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, ScreenHeight/67) title:@"进货信息" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
    }else if (indexPath.item == 3)
    {
        
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/11.37, ScreenHeight/19.14) imageName:@"bsxx_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, ScreenHeight/67) title:@"报损信息" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
    }else if (indexPath.item == 4)
    {
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/15, ScreenHeight/20) imageName:@"yhxx_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, ScreenHeight/67) title:@"要货信息" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
   
        
    }else if (indexPath.item == 5)
    {
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/11.37, ScreenHeight/20) imageName:@"spgl_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, ScreenHeight/67) title:@"商品管理" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];

    }else if (indexPath.item == 6)
    {

        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/11.37, ScreenHeight/20) imageName:@"graph-chart-increasing@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/10.714, ScreenHeight/7.445, ScreenWidth/6.69, 20) title:@"财务报表" textAlignment:NSTextAlignmentCenter];
        
       // label.backgroundColor = [UIColor redColor];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
        
    }else if (indexPath.item == 7)
    {
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/13, ScreenHeight/19) imageName:@"yyeph_icon@2X"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/14, ScreenHeight/7.445, ScreenWidth/5.4, 20) title:@"店铺排行" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];

        
    }else if (indexPath.item == 8)
    {
        

        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/13, ScreenHeight/19) imageName:@"shph_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/14, ScreenHeight/7.445, ScreenWidth/5.4, 20) title:@"损耗排行" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
        
        
        
    } else if (indexPath.item == 9)
    {
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/13, ScreenHeight/19) imageName:@"shph_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/14, ScreenHeight/7.445, ScreenWidth/5.4, 20) title:@"门店调货" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
        
        
        
    } else if (indexPath.item == 10)
    {
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/13, ScreenHeight/19) imageName:@"shph_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/14, ScreenHeight/7.445, ScreenWidth/5.4, 20) title:@"门店盘点" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
        
        
        
    } else if (indexPath.item == 11)
    {
        
        
        UIImageView *view= [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/8, ScreenWidth/9.375, ScreenWidth/13, ScreenHeight/19) imageName:@"shph_icon@2x"];
        [cell addSubview:view];
        
        
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(ScreenWidth/14, ScreenHeight/7.445, ScreenWidth/5.4, 20) title:@"更多信息" textAlignment:NSTextAlignmentCenter];
        
        label.font = [UIFont systemFontOfSize:14];
        label.adjustsFontSizeToFitWidth = YES;
        
        [cell addSubview:label];
        
        
        
        
        
    }

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
        
        return cell;
        
        
        
 
    
 
    
    
}


#pragma mark --下载

-(void)download
{
    //[self juhua];
    
    NSLog(@"%@",entID);
    
    NSString *str = [NSString stringWithFormat:@AppHomeUrl];
    
    NSDictionary * params = @{@"entId":entID,@"code":@"gy7412589630"};
    
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
                 
                 HomePageModel *model = [[HomePageModel alloc]initWithDictionary:subDict2];
                 
                 [BackGroundview  setCellModel:model];
                 
                 

                 
                 
                 
             }
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
         
     }];
    
}

//禁止滚动
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    scrollView.showsVerticalScrollIndicator = NO;
//    if (scrollView.contentOffset.y >0|| scrollView.contentOffset.y<0) {
//        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, 0);
//    }
//    
//}



////推出页面的时候让tababr
-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
    
    [self download];
    
    
}


////将要返回的时候
//-(void)viewWillDisappear:(BOOL)animated
//{
//    
//    
//    [super viewWillDisappear:animated];
//    
//    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
//    [tabCtrl showTabBar];
//    
//    [self download];
//    
//    
//}



@end
