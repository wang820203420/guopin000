//
//  ShopViewController.m
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "ShopViewController.h"
#import "RankingViewController.h"//店铺排行
#import "StockViewController.h"//库存查询
#import "SaleInfoViewController.h"//销售信息
#import "ToTheGoodsViewController.h"//要货信息
#import "LossViewController.h"//报损信息
#import "ReplenishViewController.h"//进货信息
@interface ShopViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    
}
@end

@implementation ShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
      [self createNav];
      [self createTableview];

    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"我的店铺"];
    
}


-(void)createTableview
{
    
    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    
    //_tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
  
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];

    
}



#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 6;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 75;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        RankingViewController *ranVc = [[RankingViewController alloc]init];
        
        [self.navigationController pushViewController:ranVc animated:YES];
        
    }else if (indexPath.row == 1)
    {
        SaleInfoViewController *ranVc = [[SaleInfoViewController alloc]init];
        
        [self.navigationController pushViewController:ranVc animated:YES];
        
    }else if (indexPath.row == 2)
    {
        StockViewController *ranVc = [[StockViewController alloc]init];
        
        [self.navigationController pushViewController:ranVc animated:YES];
    }else if (indexPath.row == 3)
    {
        ReplenishViewController *ranVc = [[ReplenishViewController alloc]init];
        
        [self.navigationController pushViewController:ranVc animated:YES];
        
    }else if (indexPath.row == 4)
    {
        LossViewController *ranVc = [[LossViewController alloc]init];
         
        [self.navigationController pushViewController:ranVc animated:YES];
    }else
    {
        ToTheGoodsViewController *ranVc = [[ToTheGoodsViewController alloc]init];
        
        [self.navigationController pushViewController:ranVc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        
        cell.backgroundColor = [UIColor whiteColor];
        
        NSArray *images = @[@"dianpu@2x",@"dollar-coins@2x",@"box-closed-2@2x",@"clipboard@2x",@"baosun@2x",@"clipboard-2@2x"];
        NSArray *titles = @[@"店铺排行",@"销售信息",@"库存查询",@"进货信息",@"报损信息",@"要货信息"];
        NSArray *images1 = @[@"20x35_dianji@2x",@"20x35_dianji@2x",@"20x35_dianji@2x",@"20x35_dianji@2x",@"20x35_dianji@2x",@"20x35_dianji@2x",@"20x35_dianji@2x"];
        
        NSArray *Lowimages = @[@"375x1@2x",@"375x1@2x",@"375x1@2x",@"375x1@2x",@"375x1@2x",@"375x1@2x"];
        
        NSArray *titles2 = @[@"个门店营业额及损耗排行",@"最近新增销售¥1500",@"剩余库存查询",@"商品/供应商进货消息",@"商品报损情况查询",@"出货单管理"];
        
        CGFloat width = 30;
        for (NSInteger i= indexPath.row*1; i<indexPath.row*1+1; i++) {
            
            CGRect frame = CGRectMake((width*(i%1))+20, 17, 45,45);
            CGRect frame1 = CGRectMake((width*(i%1))+80, 18, 60,20);
             CGRect Remingframe = CGRectMake((width*(i%1))+80, 40, 200,20);
            CGRect frame2 = CGRectMake((width*(i%1))+ScreenWidth/1.08, 28, 10,16);
            CGRect  Lowframe = CGRectMake((width *(i%1)), 74, ScreenWidth, 0.5);
            
            UIImageView *image = [MyUtil createIamgeViewFrame:frame imageName:images[i]];
            [cell addSubview:image];
            
            UILabel *label = [MyUtil createLabelFrame:frame1 title:titles[i] textAlignment:NSTextAlignmentCenter];
            label.font = [UIFont systemFontOfSize:15];
            [cell addSubview:label];
            
            UILabel *label2 = [MyUtil createLabelFrame:Remingframe title:titles2[i] textAlignment:NSTextAlignmentLeft];
            label2.font = [UIFont systemFontOfSize:13];
            label2.textColor = [UIColor colorWithRed:157.0/255.0 green:157.0/255.0 blue:157.0/255.0 alpha:1];
            [cell addSubview:label2];
            
            
            UIImageView *image2 = [MyUtil createIamgeViewFrame:frame2 imageName:images1[i]];
            [cell addSubview:image2];
            
            
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:Lowimages[i]];
            [cell addSubview:Lowimage];
            
            
            
        }
        
    }
    
    
    
    
    return cell;
    
    
    
    
}




@end
