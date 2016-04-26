//
//  MainViewController.m
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    
    [self createViewControllers];
     self.tabBar.hidden = YES;
    [self createTabBar];
    
    
    
}


-(void)createViewControllers
{
    
    
    NSArray *ctrlArray = @[@"HomePageViewController",@"GoodsViewController",@"ShopViewController",@"MemberViewController"];
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<ctrlArray.count; i++) {
        
        Class cls = NSClassFromString(ctrlArray[i]);
        
        UIViewController *ctrl = [[cls alloc]init];
        
        UINavigationController *navCtrl = [[UINavigationController alloc]initWithRootViewController:ctrl];
        
        
        [array addObject:navCtrl];
        
        self.viewControllers = array;
        
        
        
    }
    
    
    
}
-(void)createTabBar
{
    
    
    
    //添加背景图片
    UIImageView *bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0,ScreenHeight-ScreenHeight/13.4,ScreenWidth, 49)];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"bql_bg@2x" ofType:@"png"];
    bgView.userInteractionEnabled = YES;
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:bgView];
    bgView.tag = 400;
    
    
    NSArray *images = @[@"main_icon_normal@2x",@"sp_icon_normal@2x",@"dp_icon_normal@2x",@"hy_icon_normal@2x"];
    NSArray *selectedImages = @[@"main_icon_click@2x",@"sp_icon_click@2x",@"dp_icon_click@2x",@"hy_icon_click@2x"];
    NSArray *titles = @[@"首页",@"商品",@"店铺",@"会员"];

    
    for (int i = 0; i<images.count; i++) {
        
        NSString *imageName = images[i];
        NSString *selectedImageName = selectedImages[i];
        
        
        CGFloat btnW = ScreenWidth/images.count;
        CGFloat btnH = bgView.bounds.size.height;
        CGFloat btnX = i * btnW;
        CGFloat btnY = 0;
        
        
        CGRect frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
             btn.tag = 300+i;
        btn.frame = frame;
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:selectedImageName] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.5];
        //btn.backgroundColor = [UIColor redColor];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(ScreenHeight/22.23, -8, 0, 19)];

        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 21, 14, 0)];
        [btn setTitleColor:[UIColor colorWithRed:37.0/255.0 green:154.0/255.0 blue:0.0/255.0 alpha:1] forState:UIControlStateSelected];
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
   
        [bgView addSubview:btn];
        
        if (i == 0) {
            btn.selected = YES;
        }
        
        
        
    }
    
    
    self.selectedIndex = 0;
    
    
    
    
    
}

-(void)BtnClick:(UIButton *)btn
{
    
    //取到父视图
    UIView *bgView = btn.superview;
    //父视图上的控件
    UIButton *lastBtn = (UIButton *)[bgView viewWithTag:300+self.selectedIndex];
    //没有选中的时候
    lastBtn.selected = NO;
    btn.selected = YES;
    //下标依次根据btn递减
    self.selectedIndex = btn.tag-300;
    
    
    
    
    
}

-(void)showTabBar
{
    //显示tabbar
    UIView *tabBarView = [self.view viewWithTag:400];
    tabBarView.hidden = NO;
    
}


-(void)hideTabBar
{
    //隐藏tabbar
    UIView *tabBarView = [self.view viewWithTag:400];
    tabBarView.hidden = YES;
    
    
    
}
@end
