//
//  AddViewController.m
//  guoping
//
//  Created by zhisu on 15/12/23.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "AddViewController.h"
#import "MainViewController.h"
#import "GoodsClassViewController.h"//商品类别
#import "MainGoodsViewController.h"//所属主商品
#import "UnitViewController.h"//度量单位
#import "SBJson4Writer.h"
#import "ProvincesModel.h"//省
#import "CityModel.h"//城市
#import "AreaModel.h"//区
@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
{
    
    
    UITableView *_tableView;
    UIView *view1;
    //int  buttonY;
    NSArray *provinces, *cities, *areas;
    UIPickerView *pkview;
    UILabel *origin1;
    
    UITextField *jianmatext;//商品简码
    UITextField *unitPricetext;//单价
    UITextField *costtext;//成本价
    UITextField *inventorytext;//额定库存
    UITextField *discounttext;//折扣率
    UITextField *basetext;//种植基地
    
    UITextField *GoodSName;//商品名称
    UILabel *Goodsclass;//商品类别
    UILabel *Mainclass;//请选择主商品
    UILabel *Unitclass;//度量单位
    
       NSString *entID;//entid
    
    NSString *ProvinceCode;//省编码
     NSString *CityCode;//市编码
    
    NSString *ProStr;//所选省
     NSString *CityStr;//所选城
     NSString *AreaStr;//所选城
    
    
    NSString *guid;//所属主商品guid
      NSString *Classguid;//类别guid
      NSString *Untguid;//度量单位guid
    
    
    MBProgressHUD *Hud;
    
    BOOL show;
 
}
@property (copy, nonatomic) NSString *state;
@property (copy, nonatomic) NSString *city;
@property (copy, nonatomic) NSString *district;
@property(nonatomic,retain)NSMutableArray *dataArray;
@property(nonatomic,retain)NSMutableArray *CityDataArray;
@property(nonatomic,retain)NSMutableArray *AreaDataArray;
@end

@implementation AddViewController
-(NSMutableArray *)dataArray
{
    
    if (_dataArray == nil) {
        
        _dataArray = [NSMutableArray array];
        
    }
    
    return _dataArray;
    
}
-(NSMutableArray *)CityDataArray
{
    
    if (_CityDataArray == nil) {
        
        _CityDataArray = [NSMutableArray array];
        
    }
    
    return _CityDataArray;
    
}
-(NSMutableArray *)AreaDataArray
{
    
    if (_AreaDataArray == nil) {
        
        _AreaDataArray = [NSMutableArray array];
        
    }
    
    return _AreaDataArray;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    entID = [df objectForKey:@"GUID"];
    
    NSLog(@"%@",entID);
    
    [self createNav];
    [self createTableview];
    [self createPkview];
    
    [self download];
//    [self downloadCity];
//    [self downloadArea];
   

    
    
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    
  
    
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"商品管理"];
    
    
    
  

    
}
-(void)createTableview
{

    _tableView= [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight-28) style:UITableViewStyleGrouped];
    //_tableView.showsVerticalScrollIndicator =NO;

    _tableView.delegate = self;
    _tableView.dataSource = self;

    [self.view addSubview:_tableView];
    
    
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 130)];
    
    footView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    
    
    UIButton *btn = [MyUtil createBtnFrame:CGRectMake(12, 35, ScreenWidth-24, 45) image:@"save@2x" selectedImage:nil target:self action:@selector(saveAction:)];
    
    [footView addSubview:btn];
    
    _tableView.tableFooterView = footView;
    

    view1= [[UIView alloc]init];
    view1.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 0);
    view1.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    [self.view addSubview:view1];
    //buttonY=(int)view1.frame.origin.y;
    
    
    
    UIButton *combtn = [MyUtil createBtnFrame:CGRectMake(ScreenWidth/1.172, 10, 30, 30) title:@"完成" setTitleColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]backgroundColor:nil target:self action:@selector(comAction:)];
    combtn.titleLabel.font = [UIFont systemFontOfSize:15];
    
    [view1 addSubview:combtn];
    
    
    

}


////固定住 view 的位置
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    NSLog(@"%d",(int)view1.frame.origin.y);
//    view1.frame = CGRectMake(view1.frame.origin.x, buttonY+_tableView.contentOffset.y , view1.frame.size.width, view1.frame.size.height);
//}


#pragma mark--UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
  
        return 11;
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, ScreenWidth, 35);
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 5, 70, 30) title:@"所有商品" textAlignment:NSTextAlignmentLeft];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor colorWithRed:165.0/255.0 green:165.0/255.0 blue:165.0/255.0 alpha:1];
        
        [bgView addSubview:label];
        
        //线条
        CGRect  Lowframe = CGRectMake(0, 35, ScreenWidth, 0.5);
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
        [bgView addSubview:Lowimage];
        
        //线条
        CGRect  Lowframe1 = CGRectMake(0, 0, ScreenWidth, 0.5);
        UIImageView *Lowimage1 = [MyUtil createIamgeViewFrame:Lowframe1 imageName:@"375x1@2x"];
        [bgView addSubview:Lowimage1];
        
        
        return bgView;
        
  
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
    
    if (indexPath.row == 10) {
        
//        OrininViewController *originCtrl = [[OrininViewController alloc]init];
//        
//  
//        
//        [self.navigationController pushViewController:originCtrl animated:YES];
//        
        

        [UIView animateWithDuration:0.2 animations:^{
          
            view1.frame = CGRectMake(0, ScreenHeight/1.7, ScreenWidth, 300);
        
                   }];

   
    }else if (indexPath.row == 2){
        
        
                GoodsClassViewController *GoodsCtrl = [[GoodsClassViewController alloc]init];
        
        
        //反向传值过来修改 商品类别的text
        GoodsCtrl.block = ^(NSString *str)
        {
            
            [Goodsclass setText:str];
            
             [Goodsclass setTextColor:[UIColor blackColor]];
            
        };
        
        
        GoodsCtrl.Class = ^(NSString *Classstr)
        {
            Classguid = Classstr;
            
        };
       
        
                [self.navigationController pushViewController:GoodsCtrl animated:YES];
        
        
        
    }else if (indexPath.row == 3){
        
        
        
        MainGoodsViewController *mainCtrl = [[MainGoodsViewController alloc]init];
        //反向传值过来修改 商品类别的text
        mainCtrl.block = ^(NSString *Mainstr)
        {
            
            
               NSLog(@"%@",Mainstr);//额定库存
            [Mainclass setText:Mainstr];
            
            [Mainclass setTextColor:[UIColor blackColor]];
            
        };
        
        //反向传值过来修改 商品类别的guid
        mainCtrl.guid = ^(NSString *GUIDstr)
        {
            
            
            guid = GUIDstr;
 
            
        };
        
        
        [self.navigationController pushViewController:mainCtrl animated:YES];
        
        
    }else if (indexPath.row == 4){
        
        
        
        UnitViewController *UnitCtrl = [[UnitViewController alloc]init];
        //反向传值过来修改 商品类别的text
        UnitCtrl.block = ^(NSString *Unitstr)
        {
            
            NSLog(@"%@",Unitstr);
            
            [Unitclass setText:Unitstr];
            
            [Unitclass setTextColor:[UIColor blackColor]];
            
        };
        
        //反向传值过来修改 商品类别的guid
        UnitCtrl.UntGuid = ^(NSString *UntGUIDstr)
        {
            
              NSLog(@"%@",UntGUIDstr);
            Untguid = UntGUIDstr;
          
            
            
        };
        [self.navigationController pushViewController:UnitCtrl animated:YES];
        
        
    }else if (indexPath.row == 5){
        
        
        
     
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"cellID";

        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
  
    
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
            
        
            //线条
            CGRect  Lowframe = CGRectMake(0, 49.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
            

            

            if (indexPath.row == 0) {
                
                
                UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(10, 23, 6, 6) imageName:@"xinghao"];
                [cell addSubview:image];
                
                UILabel *goods = [MyUtil createLabelFrame:CGRectMake(18, 10, 80, 30) title:@"商品简码" textAlignment:NSTextAlignmentLeft];
                
                [goods setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                goods.font = [UIFont systemFontOfSize:15];
                [cell addSubview:goods];
                
                
              jianmatext = [[UITextField alloc]init];
                
                jianmatext.frame = CGRectMake(103, 10, ScreenWidth-107, 30);
                jianmatext.delegate = self;
                //text.backgroundColor = [UIColor redColor];
                jianmatext.placeholder= @"例如:11212";
                jianmatext.clearButtonMode = UITextFieldViewModeWhileEditing;
     
                jianmatext.returnKeyType = UIReturnKeyDone;
                [cell addSubview:jianmatext];
                
                
            }else if (indexPath.row == 1){
                
                
                UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(10, 23, 6, 6) imageName:@"xinghao"];
                [cell addSubview:image];
                
                UILabel *name = [MyUtil createLabelFrame:CGRectMake(18, 10, 80, 30) title:@"商品名称" textAlignment:NSTextAlignmentLeft];
                
                [name setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                name.font = [UIFont systemFontOfSize:15];
                [cell addSubview:name];
                
                GoodSName = [[UITextField alloc]init];
                GoodSName.delegate = self;
                GoodSName.frame = CGRectMake(103, 10, ScreenWidth/1.415, 30);
                GoodSName.placeholder= @"例如:美国车厘子";
                GoodSName.clearButtonMode = UITextFieldViewModeWhileEditing;
                
                GoodSName.returnKeyType = UIReturnKeyDone;
                [cell addSubview:GoodSName];
                
                
            }else if (indexPath.row == 2){
                
                
                UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(10, 23, 6, 6) imageName:@"xinghao"];
                [cell addSubview:image];
                
                UILabel *class = [MyUtil createLabelFrame:CGRectMake(18, 10, 80, 30) title:@"商品类别" textAlignment:NSTextAlignmentLeft];
                
                [class setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                class.font = [UIFont systemFontOfSize:15];
                [cell addSubview:class];
                
                
                 
                
                Goodsclass = [MyUtil createLabelFrame:CGRectMake(100, 10, 100, 30) title:@"请选择类别" textAlignment:NSTextAlignmentLeft];
                
                [Goodsclass setTextColor:[UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1]];
                
                Goodsclass.font = [UIFont systemFontOfSize:16];
                [cell addSubview:Goodsclass];
                
                
                //箭头
                UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 19, 10, 15) imageName:@"my_arrow_17X30@2x"];
                [cell addSubview:arrowImage];
                
                
                
 
            }else if (indexPath.row == 3){
                
                UILabel *main = [MyUtil createLabelFrame:CGRectMake(10, 10, 90, 30) title:@"所属主商品" textAlignment:NSTextAlignmentLeft];
                
                [main setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                main.font = [UIFont systemFontOfSize:14];
                [cell addSubview:main];
                
               Mainclass = [MyUtil createLabelFrame:CGRectMake(100, 10, 100, 30) title:@"请选择主商品" textAlignment:NSTextAlignmentLeft];
                
                [Mainclass setTextColor:[UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1]];
                
                Mainclass.font = [UIFont systemFontOfSize:16];
                [cell addSubview:Mainclass];
                
                
                //箭头
                UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 19, 10, 15) imageName:@"my_arrow_17X30@2x"];
                [cell addSubview:arrowImage];
                
                
                
            }else if (indexPath.row == 4){

                
                UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(10, 23, 6, 6) imageName:@"xinghao"];
                [cell addSubview:image];
                UILabel *unit = [MyUtil createLabelFrame:CGRectMake(18, 10, 90, 30) title:@"度量单位" textAlignment:NSTextAlignmentLeft];
                
                [unit setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                unit.font = [UIFont systemFontOfSize:15];
                [cell addSubview:unit];
                
                Unitclass = [MyUtil createLabelFrame:CGRectMake(100, 10, 120, 30) title:@"请选择计量单位" textAlignment:NSTextAlignmentLeft];
                
                [Unitclass setTextColor:[UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1]];
                
                Unitclass.font = [UIFont systemFontOfSize:16];
                [cell addSubview:Unitclass];
                
                
                //箭头
                UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 19, 10, 15) imageName:@"my_arrow_17X30@2x"];
                [cell addSubview:arrowImage];
                
                
            }else if (indexPath.row == 5){
                
                
                UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(10, 23, 6, 6) imageName:@"xinghao"];
                [cell addSubview:image];
                UILabel *unitPrice = [MyUtil createLabelFrame:CGRectMake(18, 10, 90, 30) title:@"单价(元)" textAlignment:NSTextAlignmentLeft];
                
                [unitPrice setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                unitPrice.font = [UIFont systemFontOfSize:15];
                [cell addSubview:unitPrice];
                
                
               unitPricetext = [[UITextField alloc]init];
                
                unitPricetext.frame = CGRectMake(103, 10, ScreenWidth-107, 30);
                unitPricetext.delegate = self;
                //text.backgroundColor = [UIColor redColor];
                unitPricetext.placeholder= @"¥0.00";
                unitPricetext.clearButtonMode = UITextFieldViewModeWhileEditing;
                 unitPricetext.returnKeyType = UIReturnKeyDone;
                [cell addSubview:unitPricetext];
                
                
            }else if (indexPath.row == 6){
                
                UILabel *cost = [MyUtil createLabelFrame:CGRectMake(10, 10, 90, 30) title:@"成本价" textAlignment:NSTextAlignmentLeft];
                
                [cost setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                cost.font = [UIFont systemFontOfSize:14];
                [cell addSubview:cost];
                
                
                costtext = [[UITextField alloc]init];
                costtext.frame = CGRectMake(103, 10, ScreenWidth-107, 30);
                costtext.placeholder= @"¥0.00";
                costtext.delegate = self;
                costtext.clearButtonMode = UITextFieldViewModeWhileEditing;
                  costtext.returnKeyType = UIReturnKeyDone;
                [cell addSubview:costtext];
                
                
                
            }else if (indexPath.row == 7){
                
                UILabel *inventory = [MyUtil createLabelFrame:CGRectMake(10, 10, 90, 30) title:@"额定库存" textAlignment:NSTextAlignmentLeft];
                
                [inventory setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                inventory.font = [UIFont systemFontOfSize:14];
                [cell addSubview:inventory];
                
                 inventorytext= [[UITextField alloc]init];
                inventorytext.delegate = self;
                inventorytext.frame = CGRectMake(103, 10, ScreenWidth-107, 30);
                inventorytext.placeholder= @"库存重量/数量";
                inventorytext.clearButtonMode = UITextFieldViewModeWhileEditing;
                  inventorytext.returnKeyType = UIReturnKeyDone;
                [cell addSubview:inventorytext];
                
                
                
            }else if (indexPath.row == 8){
                
                UILabel *discount = [MyUtil createLabelFrame:CGRectMake(10, 10, 100, 30) title:@"折扣率(-%)" textAlignment:NSTextAlignmentLeft];
                
                [discount setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                discount.font = [UIFont systemFontOfSize:14];
                [cell addSubview:discount];
                
                
                discounttext = [[UITextField alloc]init];
                discounttext.delegate = self;
                discounttext.frame = CGRectMake(103, 10, ScreenWidth-107, 30);
                discounttext.placeholder= @"例如8.8";
                discounttext.clearButtonMode = UITextFieldViewModeWhileEditing;
                 discounttext.returnKeyType = UIReturnKeyDone;
                [cell addSubview:discounttext];
                
                
                
            }else if (indexPath.row == 9){
                
                UILabel *base = [MyUtil createLabelFrame:CGRectMake(10, 10, 100, 30) title:@"种植基地" textAlignment:NSTextAlignmentLeft];
                
                [base setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                base.font = [UIFont systemFontOfSize:14];
                [cell addSubview:base];
                
                basetext = [[UITextField alloc]init];
                basetext.delegate = self;
                basetext.frame = CGRectMake(103, 10,ScreenWidth-107, 30);
                basetext.placeholder= @"请输入地址";
                basetext.clearButtonMode = UITextFieldViewModeWhileEditing;
                 basetext.returnKeyType = UIReturnKeyDone;
                [cell addSubview:basetext];
                
                
                
            }else if (indexPath.row == 10){
                
                UILabel *origin = [MyUtil createLabelFrame:CGRectMake(10, 10, 80, 30) title:@"产地" textAlignment:NSTextAlignmentLeft];
                
                [origin setTextColor:[UIColor colorWithRed:111.0/255.0 green:111.0/255.0 blue:111.0/255.0 alpha:1]];
                
                origin.font = [UIFont systemFontOfSize:14];
                [cell addSubview:origin];
   
                
                origin1 = [MyUtil createLabelFrame:CGRectMake(100, 10, 200, 30) title:@"请选择省市/城市/区/县" textAlignment:NSTextAlignmentLeft];
                [origin1 setTextColor:[UIColor colorWithRed:199.0/255.0 green:199.0/255.0 blue:205.0/255.0 alpha:1]];
                origin1.font = [UIFont systemFontOfSize:16];
                [cell addSubview:origin1];
                
                
                //箭头
                UIImageView *arrowImage = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth-20, 19, 10, 15) imageName:@"my_arrow_17X30@2x"];
                [cell addSubview:arrowImage];
                
            }
            
            
        }

        
        return cell;
        
  
    
}




-(void)saveAction:(UIButton *)sender
{
    
    [jianmatext endEditing:YES];
   
//    NSLog(@"保存");
    
//  NSLog(@"%@",jianmatext.text);//商品简码
//     NSLog(@"%@",GoodSName.text);//商品名称
//    NSLog(@"%@",Goodsclass.text);//商品类别
//    NSLog(@"%@",Mainclass.text);//主商品
//    NSLog(@"%@",Unitclass.text);//度量单位
//    NSLog(@"%@",unitPricetext.text);//单价
//    NSLog(@"%@",costtext.text);//成本价
//     NSLog(@"%@",inventorytext.text);//额定库存
//     NSLog(@"%@",discounttext.text);//折扣率
//     NSLog(@"%@",basetext.text);//种植基地
//       NSLog(@"%@",origin1.text);//产地
//    

 
    if ([origin1.text isEqual:@"请选择省市/城市/区/县"]) {
     
        origin1.text = @"";
        
    }
    
    if (guid  != nil) {
        
      
        
    }else
    {
        
          guid = @"";
    }
    

    
    //判断必填选项是否为 空。。
    if (![jianmatext.text isEqualToString:@""] && ![GoodSName.text isEqualToString:@""]&& Classguid  != nil && Untguid !=nil&&![unitPricetext.text isEqualToString:@""] ) {
        
        //alert(@"有")
        
        
        //判断成本价和额定库存是否为空，空的话就为 0
        if (![costtext.text isEqualToString:@""] && ![inventorytext.text isEqualToString:@""]) {
            
            
        }else
        {
            costtext.text = [NSString stringWithFormat:@"%d",0];
            inventorytext.text = [NSString stringWithFormat:@"%d",0];
            
            
        }
        
        Hud = [[MBProgressHUD alloc]init];
        
        Hud.labelText = @"保存中";
    //Hud.mode = MBProgressHUDModeCustomView;
        [self.view addSubview:Hud];
        [Hud show:YES];
        
        NSLog(@"%@",ProStr);
        NSLog(@"%@",CityStr);
        NSLog(@"%@",AreaStr);
        
        
        if (CityStr != nil) {
            
        }else
        {
            
            CityStr = @"";
        }
        
        
        if (AreaStr != nil) {
            
        }else
        {
            
            AreaStr = @"";
        }
        
       // origin1.text,@"OriginCode"
        
        //拼接json 发送
        NSDictionary *dataDict = [NSDictionary dictionaryWithObjectsAndKeys:jianmatext.text,@"GoodsCode",GoodSName.text,@"GoodsName",Classguid,@"GoodsType",Untguid,@"UnitID",unitPricetext.text,@"RetailPrice",costtext.text,@"CostPrice",inventorytext.text,@"RatedInventory",discounttext.text,@"ClearanceDiscountPerc",basetext.text,@"Origin",ProStr,@"ProvinceCode",CityStr,@"CityCode",AreaStr,@"AreaCode",guid,@"ParentID", nil];
        
        
        
        SBJson4Writer *js = [[SBJson4Writer alloc]init];
        
        NSString *jsonStr = [js stringWithObject:dataDict];
        
        
        NSLog(@"%@",jsonStr);
        
        //保存数据，上传服务器
        
        
        NSString *str = [NSString stringWithFormat:@AddGoodsUrl];
        
        NSDictionary * params = @{@"entId":entID,@"goods":jsonStr,@"code":@"gy7412589630"};
        
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
                     
         
                     
                     
                     NSLog(@"%@",subDict1);
                     
                     NSString *sre = [NSString stringWithFormat:@"%@",subDict1];
                     int str = [sre intValue];
                     
                     if (  str != 1) {
                
                            alert(@"失败");
                         
                     }else
                     {
                         
                         //alert(@"成功");
                         
                         Hud.labelText = @"保存成功";
                         [Hud hide:YES];
                     }
               
                 
                 
            
             

                 }
             }
             
             
         }
            failure:^(AFHTTPClientV2 *request, NSError *error)
         {
             NSLog(@"%@",error);
         }];
        

        
        
    }else
        
    {
 
         alert(@"标注红点的选项为必填项，请您填写完全,谢谢!")
        
     
        
        
        
        
    }
    
    
    
    
    
    
 

}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//
//    [UIView animateWithDuration:0.2 animations:^{
//
//           view1.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 0);
//
//    }];
//
//
//}

#pragma mark -- 选择城市完成
-(void)comAction:(UIButton *)sender
{
    
    //判断区有没有显示过，有显示过就清空上次选择的区
    if (show == YES) {
        
          NSLog(@"%@",AreaStr);
    }else
    {
        AreaStr = @"";
        
    }
    
  
    
    if (CityStr && [CityStr isKindOfClass:[NSString class]] && CityStr.length > 0) {
        
        if (AreaStr && [AreaStr isKindOfClass:[NSString class]] && AreaStr.length > 0)
        {
            NSString *str = [NSString stringWithFormat:@"%@ %@ %@",ProStr, CityStr,AreaStr];
            
            NSLog(@"%@",str);
            
            [origin1 setText:str];
            [origin1 setTextColor:[UIColor blackColor]];
            
            
        }else
        {
            
            NSString *str = [NSString stringWithFormat:@"%@ %@",ProStr, CityStr];
            
            NSLog(@"%@",str);
            
            [origin1 setText:str];
            [origin1 setTextColor:[UIColor blackColor]];
            
        }
        
        
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%@",ProStr];
        
        NSLog(@"%@",str);
        
        [origin1 setText:str];
        [origin1 setTextColor:[UIColor blackColor]];
        
        
      
        

        
    }

    
    
    [UIView animateWithDuration:0.2 animations:^{
        
    view1.frame = CGRectMake(0, ScreenHeight, ScreenWidth, 0);
        
        
    }];
    
}

-(void)backAction:(UIButton *)sender
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


#pragma mark -- 创建pick view 城市选择器
-(void)createPkview{
    
    
    pkview = [[UIPickerView alloc]initWithFrame:CGRectMake(35, 100, ScreenWidth/1.25, 100)];
    pkview.dataSource = self;
    pkview.delegate = self;
    
    [view1 addSubview:pkview];
    
    

//    //初始化选中的行数
//    [pkview selectRow:ceil(self.dataArray.count/2) inComponent:0 animated:YES];
//    [pkview selectRow:ceil(self.CityDataArray.count/2) inComponent:1 animated:YES];
//    [pkview selectRow:ceil(self.AreaDataArray.count/2) inComponent:2 animated:YES];
//    
//    
//    NSString *str = [NSString stringWithFormat:@"%@ %@ %@",[self.dataArray objectAtIndex:ceil(self.dataArray.count/2)], [self.CityDataArray objectAtIndex:ceil(self.CityDataArray.count/2)], [self.AreaDataArray objectAtIndex:ceil(self.AreaDataArray.count/2)]];
//    
//    
//    NSLog(@"%@",str);
    
    

    
    
  
}


#pragma mark--pkview
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.dataArray.count;
            break;
        case 1:
            return self.CityDataArray.count;
            break;
        case 2:
            
            return self.AreaDataArray.count;
            break;
            
        default:
            return 0;
            break;
    }
}

// UIPickerViewDelegate中定义的方法，该方法返回NSString将作为UIPickerView中指定列和列表项上显示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
 
    
    
    // 如果是第一列，返回provinces中row索引出得元素
//    switch (component) {
//        case 0:
    
    if (component == 0) {
        
        
        
        ProvincesModel  *model = [self.dataArray objectAtIndex:row];
     
        NSLog(@"%@",model);
        

        
//
//        //默认选择第一行
//        ProvinceCode = [NSString stringWithFormat:@"%@",model.REGION_CODE];
//        [pkview selectRow:0 inComponent:1 animated:NO];
//        
//        [self downloadCity];
        
        
        
       ProStr  = [NSString stringWithFormat:@"%@",model.REGION_NAME];

        return model.REGION_NAME;
        
  
        
    }else if (component == 1)
    {
        
        
        
        
        CityModel *model = [self.CityDataArray objectAtIndex:row];
        
     
//                CityCode = [NSString stringWithFormat:@"%@",model.REGION_CODE];
//                [pkview selectRow:0 inComponent:2 animated:NO];
//        
//                [self downloadArea];
        
         CityStr  = [NSString stringWithFormat:@"%@",model.REGION_NAME];
        
        
        
        return model.REGION_NAME;
        
        
        
    }else
    {
        
        show = YES;
        
        AreaModel *model = [self.AreaDataArray objectAtIndex:row];
        
          AreaStr  = [NSString stringWithFormat:@"%@",model.REGION_NAME];
        return model.REGION_NAME;
      
    }
  
    

    
    
    
    
}

// 当用户选中UIPickerViewDataSource中指定列和列表项时激发该方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        
           show = NO;
        //1.先取得省份的编码
        ProvincesModel  *model = [self.dataArray objectAtIndex:row];
        
        ProvinceCode = [NSString stringWithFormat:@"%@",model.REGION_CODE];
      
        NSLog(@"%@",ProvinceCode);
        
        [self downloadCity];
        
        //选择省的同时下载 区
        CityCode = [NSString stringWithFormat:@"%@",model.REGION_CODE];
        [self downloadArea];
        
        
        
        
        
    }else if (component == 1)
    {
        
        //1.先取得城市的编码
        CityModel  *model = [self.CityDataArray objectAtIndex:row];
        
        CityCode = [NSString stringWithFormat:@"%@",model.REGION_CODE];
        
        NSLog(@"%@",CityCode);
        [self downloadArea];
        
    }

    
}



#pragma mark -- uitextview 代理
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [self resignFirstResponder];
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (unitPricetext) {
        
        [UIView animateWithDuration:1 animations:^{
            
            _tableView.frame = CGRectMake(0, -35, ScreenWidth, ScreenHeight-28);
            
        }];
        
    }
  
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [jianmatext resignFirstResponder];
    [GoodSName resignFirstResponder];
    [costtext resignFirstResponder];
    [inventorytext resignFirstResponder];
    [discounttext resignFirstResponder];
    [basetext resignFirstResponder];
    
    
    if (unitPricetext) {
        [unitPricetext resignFirstResponder];
        [UIView animateWithDuration:1 animations:^{
            
            _tableView.frame = CGRectMake(0,64, ScreenWidth, ScreenHeight-28);
            
        }];
    }
    
    
    return YES;
    
}


#pragma mark --- 下载省份

-(void)download
{
    
    
    NSString *str = [NSString stringWithFormat:@GetProvinceListUrl];
    
    NSDictionary * params = @{@"code":@"gy7412589630"};
    
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
                 
                 for (NSDictionary *dict in arr1) {
                     
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     
                     
                     ProvincesModel  *model = [[[ProvincesModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     
                     [self.dataArray addObject:model];
                     
                     NSLog(@"%ld",self.dataArray.count);
                     
                     
                     
                 }
                 
                 
                 
             }
             
             
             
             
             //className = [self.dataArray objectAtIndex:0];
             
             [pkview reloadComponent:0];
             
             
             
             
         }
         
         
     }
     failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}


#pragma mark -- 下载城市


-(void)downloadCity
{
    
    
    NSString *str = [NSString stringWithFormat:@GetCityListUrl];
    
    NSDictionary * params = @{@"ProvinceCode":ProvinceCode,@"code":@"gy7412589630"};
    
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
             
             
            [self.CityDataArray removeAllObjects];
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 
                 for (NSDictionary *dict in arr1) {
                     
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     
                     
                      CityModel  *model = [[[CityModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     
                     [self.CityDataArray addObject:model];
                     
                     NSLog(@"%ld",self.CityDataArray.count);
                     
                     
                     
                 }
                 
                 
                 
             }
             
             
             
             
             //className = [self.dataArray objectAtIndex:0];
             
             [pkview reloadComponent:1];
             
             
             
             
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}

#pragma mark -- 下载 区
-(void)downloadArea
{
    
    
    NSString *str = [NSString stringWithFormat:@GetAreaListUrl];
    
    NSDictionary * params = @{@"CityCode":CityCode,@"code":@"gy7412589630"};
    
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
             
             
             [self.AreaDataArray removeAllObjects];
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 
                 
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 
                 NSArray *arr1 = [subDict1 objectForKey:@"Data"];
                 
                 for (NSDictionary *dict in arr1) {
                     
                     
                     NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:dict];
                     
                     NSLog(@"%@",sssDict);
                     
                     
                     
                     AreaModel  *model = [[[AreaModel alloc]init]initWithDictionary:sssDict];
                     
                     
                     
                     [self.AreaDataArray addObject:model];
                     
                     NSLog(@"%ld",self.AreaDataArray.count);
                     
                     
                     
                 }
                 
                 
                 
             }
             
             
             
             
             //className = [self.dataArray objectAtIndex:0];
             
             [pkview reloadComponent:2];
             
             
             
             
         }
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];
    
}



@end
