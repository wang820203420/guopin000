//
//  TransferViewController.m
//  guoping
//
//  Created by zhisu on 16/6/12.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "TransferViewController.h"
#import "MainViewController.h"
#import "ChangeBtn.h"

@interface TransferViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *mainTableView;         //mainTableView
    UIView *truncationView;             //截断view(弹出的透明遮罩)
    UITableView *leftPopoverTableView;  //左侧弹出的tableview
    UITableView *rightPopoverTableView; //右侧弹出的tableview
    
    ChangeBtn *dropdownBtn;               //点击弹出选择view
    
    NSString *store;    //店铺名
    NSString *date;     //今日、本周、本月
}
@property(nonatomic,retain) NSMutableArray *dataArray;

@end

@implementation TransferViewController
#pragma mark __________________________懒加载_____________________________

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self download];
    [self configureUI];
}
#pragma mark __________________________创建UI_____________________________
- (void)configureUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"门店调货"];
    
    [self createTableview];
    [self createPopoverTableview];
}

- (void)createTableview
{
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+45, ScreenWidth, ScreenHeight-64-45) style:UITableViewStylePlain];
    mainTableView.dataSource = self;
    mainTableView.delegate = self;
    mainTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainTableView];
}

- (void)createPopoverTableview
{
    //1.创建下拉按钮changeBtn
    [self createChangeBtn];
    
    //2.线条
    //上层线条
    UIImageView *topLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 64, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:topLine];
    //中间线条
    UIButton *lineBtn = [MyUtil createBtnFrame:CGRectMake(ScreenWidth/2.01, 64+10, 0.5, 25) image:nil selectedImage:nil target:nil action:nil];
    lineBtn.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:199.0/255.0 blue:204.0/255.0 alpha:1];
    [self.view addSubview:lineBtn];
    //下面线条
    UIImageView *lowLine = [MyUtil createIamgeViewFrame:CGRectMake(0, 64+45, ScreenWidth, 0.5) imageName:@"375x1@2x"];
    [self.view addSubview:lowLine];
    
    //3.创建用来截取子视图的truncation view
    truncationView = [[UIView alloc] initWithFrame:CGRectMake(0, 64+45, ScreenWidth, 0)];
    truncationView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
    truncationView.clipsToBounds = YES;//截断
    [self.view addSubview:truncationView];
    
    //4.创建左边的leftPopoverTableview
    leftPopoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    leftPopoverTableView.dataSource = self;
    leftPopoverTableView.delegate = self;
    [truncationView addSubview:leftPopoverTableView];

    //5.创建右边的rightPopoverTableview
    rightPopoverTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 250) style:UITableViewStylePlain];
    rightPopoverTableView.dataSource = self;
    rightPopoverTableView.delegate = self;
    [truncationView addSubview:rightPopoverTableView];
}



- (void)createChangeBtn
{
    //NSArray *titles = @[store,date];
    NSArray *titles = @[@"全部商店",@"所有日期"];
    for (int i = 0; i < titles.count; i++) {
        dropdownBtn = [ChangeBtn buttonWithType:UIButtonTypeCustom];//注意：该语句是创建了一个新的Btn相当于alloc和init
        dropdownBtn.frame = CGRectMake((ScreenWidth/2)*(i%2)+ScreenWidth/12.5, 64+10, ScreenWidth/3, 30);
        [dropdownBtn setTitle:titles[i] forState:UIControlStateNormal];
        dropdownBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [dropdownBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [dropdownBtn setTitleColor:[UIColor colorWithRed:73.0/255.0 green:150.0/255.0 blue:61.0/255.0 alpha:1] forState:UIControlStateSelected];
        [dropdownBtn setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateNormal];
        [self.view addSubview:dropdownBtn];
        
        [dropdownBtn addTarget:self action:@selector(openView:) forControlEvents:UIControlEventTouchUpInside];
        
        dropdownBtn.tag = i;
    }
    
}

#pragma mark __________________________UITableViewDataSource_____________________________
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num;
    
    if (mainTableView == tableView) {
        num = 30;
    } else if (leftPopoverTableView == tableView) {
        num = 3;
    } else if (rightPopoverTableView == tableView) {
        num = 10;
    }
    
    return num;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (mainTableView == tableView) {
        cell.textLabel.text = [NSString stringWithFormat:@"查询数据－－－[%ld]", indexPath.row];
    } else if (leftPopoverTableView == tableView) {
        cell.contentView.backgroundColor = [UIColor redColor];
        cell.textLabel.text = [NSString stringWithFormat:@"左边的表格－－－[%ld]", indexPath.row];
    } else if (rightPopoverTableView == tableView) {
        cell.contentView.backgroundColor = [UIColor blueColor];
        cell.textLabel.text = [NSString stringWithFormat:@"右边的表格－－－[%ld]", indexPath.row];
    }
    
    return cell;
}


#pragma mark __________________________UITableViewDelegate_____________________________
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 50;
//}
#pragma mark __________________________点击事件_____________________________
- (void)backAction:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)openView:(ChangeBtn *)btn
{
    //1.点击Btn初始化所有btn状态并设置当前btn,关闭mainTableView滚动
    for (ChangeBtn *dropdown in [self.view subviews]) {
        if ([dropdown isKindOfClass:[ChangeBtn class]]) {
            dropdown.selected = NO;
        }
    }
    btn.selected = YES;
    mainTableView.scrollEnabled = NO;
    //2.通过改变truncationView.frame来控制popoverTableView是否显示出来
    CGRect frame = truncationView.frame;
    //3.判断点击的是哪一个btn按需显示对应的view
    switch (btn.tag) {
        case 0:
        {
            if (frame.size.height == 0) {
                leftPopoverTableView.hidden = NO;
                rightPopoverTableView.hidden = YES;
                frame.size.height += ScreenHeight-64-45;
            } else if (!rightPopoverTableView.hidden) {
                leftPopoverTableView.hidden = NO;
                rightPopoverTableView.hidden = YES;
                frame = frame;
            } else {
                frame.size.height -= ScreenHeight-64-45;
            }
        }
            break;
            
        case 1:
        {
            if (frame.size.height == 0) {
                leftPopoverTableView.hidden = YES;
                rightPopoverTableView.hidden = NO;
                frame.size.height += ScreenHeight-64-45;
            } else if (!leftPopoverTableView.hidden) {
                leftPopoverTableView.hidden = YES;
                rightPopoverTableView.hidden = NO;
                frame = frame;
            } else {
                frame.size.height -= ScreenHeight-64-45;
            }
        }
            break;
            
        default:
            break;
    }
    //4.添加动画效果
    if (frame.size.height) {
        [UIView animateWithDuration:0.35f animations:^{
            truncationView.frame = frame;
            [btn setImage:[UIImage imageNamed:@"24x14_famhui@2x"] forState:UIControlStateSelected];
        }];
    } else {
        [UIView animateWithDuration:0.65f animations:^{
            truncationView.frame = frame;
            [btn setImage:[UIImage imageNamed:@"24x14_xiala@2x"] forState:UIControlStateSelected];
        }];
    }
}

#pragma mark __________________________监控触发事件_____________________________
/**
 推出页面的时候让tababr
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl hideTabBar];
}

/**
 将要返回的时候
 */
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
}

#pragma mark __________________________下载_____________________________
- (void)download
{
}



@end
