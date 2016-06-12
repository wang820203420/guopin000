//
//  GoodsDetailsViewController.m
//  guoping
//
//  Created by zhisu on 16/5/25.
//  Copyright (c) 2016年 zhisu. All rights reserved.
//


#import "GoodsDetailsViewController.h"
#import "MainViewController.h"
#import "GoodsMngDetCell.h"//商品详细
#import "GoodsMngDetModel.h"
@interface GoodsDetailsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableview;
    UITextField *inputPrice;
    
    UISwitch *handSwitch;
    UISwitch *forbiddenSwitch;

    NSString *strRET;
    NSString *updateUser;
}

@property(nonatomic,retain)NSMutableArray *dataArray;

@end
@implementation GoodsDetailsViewController
#pragma mark ————————————懒加载————————————
- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}


#pragma mark - viewDidLoad
- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createNav];
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"商品详情"];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    [self addNavButton:CGRectMake(ScreenWidth/1.2, 25, 50, 30) text:@"编辑" target:self action:@selector(editorAction:)];
    NSUserDefaults *df = [NSUserDefaults standardUserDefaults];
    updateUser = [df objectForKey:@"GUID"];
    [self download];
}


#pragma mark ———————————创建界面————————————
- (void)createTableView
{
    _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    [self.view addSubview:_tableview];
    
//添加一个底部的保存按钮
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    footView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
    UIButton *btn = [MyUtil createBtnFrame:CGRectMake(12, 25, ScreenWidth-24, 45) image:@"save@2x" selectedImage:nil target:self action:@selector(saveAction:)];
    [footView addSubview:btn];
    _tableview.tableFooterView = footView;
    _tableview.tableFooterView.hidden = YES;
}


#pragma mark ——————————————UITableViewDataSource————————————————
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    static NSString *cellhandID = @"handcellID";
    static NSString *cellstateID = @"statecellID";
    
    if (indexPath.section == 0) {
        GoodsMngDetCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
            cell = [[GoodsMngDetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        GoodsMngDetModel *cellModel = self.dataArray[indexPath.row];
        cell.cellModel = cellModel;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        cell.contentView.userInteractionEnabled = NO;
        NSLog(@"%ld",cell.contentView.subviews.count);
        NSLog(@"%@",cell.contentView.subviews);
        
        return cell;
        
    } else if (indexPath.section == 1) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellhandID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstateID];
            //1.是否手输金额lab
            UILabel *handInput = [MyUtil createLabelFrame:CGRectMake(10, 15, 100, 20) title:@"是否手输金额" textAlignment:NSTextAlignmentLeft];
            handInput.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            handInput.font = [UIFont systemFontOfSize:16];
            [cell addSubview:handInput];
            //2.是否手输金额switch
            handSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 9, 30, 30)];
            handSwitch.onTintColor = [UIColor colorWithRed:73.0/255.0 green:160.0/255.0 blue:61.0/255.0 alpha:1];
            [cell addSubview:handSwitch];
            
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            //3.Switch状态的初始化
            NSNumber  *floatNumber = [NSNumber numberWithFloat:1];
            //判断是否手输金额
            if ([_HandInput isKindOfClass:[NSNull class]]) {
                NSLog(@"%@", _HandInput);
            } else {
                if ([_HandInput  isEqualToNumber:floatNumber] == YES ) {
                    handSwitch.on = YES;
                } else {
                    handSwitch.on = NO;
                }
            }
            
            //4.控制switch的操作状态
            if (_tableview.tableFooterView.hidden) {
                handSwitch.userInteractionEnabled = NO;
            } else {
                handSwitch.userInteractionEnabled = YES;
            }
            
            [handSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];


            cell.selectionStyle = UITableViewCellEditingStyleNone;
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 49.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        return cell;
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellstateID];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellstateID];
            
            //1.是否上架lab
            UILabel *forbidden = [MyUtil createLabelFrame:CGRectMake(10, 15, 100, 20) title:@"上架" textAlignment:NSTextAlignmentLeft];
            forbidden.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
            forbidden.font = [UIFont systemFontOfSize:16];
            [cell addSubview:forbidden];
            //2.是否上架switch
            forbiddenSwitch = [[UISwitch alloc]initWithFrame:CGRectMake(ScreenWidth/1.25, 9, 30, 30)];
            forbiddenSwitch.onTintColor = [UIColor colorWithRed:73.0/255.0 green:160.0/255.0 blue:61.0/255.0 alpha:1];
            [cell addSubview:forbiddenSwitch];
            
            
            tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            
            
            //3.mySwitch状态的初始化
            NSNumber  *floatNumber = [NSNumber numberWithFloat:1];
                        //判断是否上架
            if ([_Forbidden isKindOfClass:[NSNull class]]) {
                NSLog(@"%@", _Forbidden);
            } else {
                if ([_Forbidden isEqualToNumber:floatNumber] == YES ) {
                    forbiddenSwitch.on = NO;
                } else {
                    forbiddenSwitch.on = YES;
                }
            }
            
            //4.控制switch的操作状态
            if (_tableview.tableFooterView.hidden) {
                forbiddenSwitch.userInteractionEnabled = NO;
            } else {
                forbiddenSwitch.userInteractionEnabled = YES;
            }
            
            [forbiddenSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventTouchUpInside];

            
            cell.selectionStyle = UITableViewCellEditingStyleNone;
            
            //线条
            CGRect  Lowframe = CGRectMake(0, 49.5, ScreenWidth, 0.5);
            UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
            [cell addSubview:Lowimage];

        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];

        return cell;
    }
    
}


#pragma mark ———————————————UITableViewDelegate—————————————————
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 200;
    } else {
        return  50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 2) {
        return 0;
    } else {
        return 35;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, ScreenWidth, 35);
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 9, 80, 20) title:@"商品信息" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        
        [bgView addSubview:label];
        
        return bgView;
    } else {
        UIView *bgView = [[UIView alloc]init];
        bgView.frame = CGRectMake(0, 0, ScreenWidth, 34.5);
        bgView.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1];
        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(12, 9, 80, 20) title:@"商品状态" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:156.0/255.0 green:156.0/255.0 blue:156.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:14];
        
        [bgView addSubview:label];
        
        //线条
        CGRect  Lowframe = CGRectMake(0, 34.5, ScreenWidth, 0.5);
        UIImageView *Lowimage = [MyUtil createIamgeViewFrame:Lowframe imageName:@"375x1@2x"];
        [bgView addSubview:Lowimage];
        
        return bgView;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableview.tableFooterView.hidden) {
        [self alertAction];
    } else {
        if (indexPath.section == 0) {
            //调出键盘，编辑价格出入文本框
            [inputPrice setAllowsEditingTextAttributes:YES];
            [inputPrice becomeFirstResponder];
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //只允许显示两位小数的形式显示（第三位起四舍五入）
    if ([inputPrice.text isEqualToString:@""]) {
        inputPrice.text = strRET;
    }
    NSString *str = inputPrice.text;
    inputPrice.text = [NSString stringWithFormat:@"%.2f",str.description.doubleValue];
    [inputPrice resignFirstResponder];
}


#pragma mark ——————————————下载——————————————
/**
 *    接口样例:
 *
 *         { "GUID": "f1664c68159e4928931ddf66cce46d1e",
             "GoodsCode": "1704",
             "GoodsName": "红布林", 
             "RetailPrice": 5.00,      //--------------------------1
             "CostPrice": 1.00, 
             "UnitID": "0001", 
             "WeighingType": "0",
             "RatedInventory": 100.000, 
             "GoodsType": "28f4b1b7b16041e9aeb853aaa748d46d", 
             "ClearanceDiscountPerc": 100.00, 
             "Origin": "", 
             "IsSkuDiscount": null, 
             "IsHandInput": false,      //--------------------------2
             "IsAllowSale": null, 
             "SaleState": "销售中",      //------------------------关联是是否上架
             "IsForbidden": false,      //--------------------------3
             "UpdateUser": "",          //--------------------------4（app使用者的登陆GUID）
             "UpdateTime": "2016-05-19 17:00:09",
             "CreateUser": "05397e04317441009caa9e890947cc70", 
             "CreateTime": "2015-12-17 16:58:14",
             "IsDelete": 0,
             "CurrentInventory": 10000.000,
             "StoreName": null, 
             "UnitName": "kg", 
             "GoodsTypeName": null, 
             "UploadUpdateTime": null, 
             "UploadCreateTime": null, 
             "SourceID": null, 
             "StoreID": null, 
             "EnterpriseID": "05397e04317441009caa9e890947cc70", 
             "OriginCode": "", 
             "ProvinceCode": "", 
             "CityCode": "", 
             "AreaCode": "", 
             "ParentID": null }
 *
 *
 */
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
         //第一次分离
         if ([dict isKindOfClass:[NSDictionary class]]) {
             NSDictionary *subDict = [dict objectForKey:@"string"];
             NSString *str = [subDict objectForKey:@"text"];
             //字符串转化成data
             NSData *jsData = [str dataUsingEncoding:NSUTF8StringEncoding];
             NSError *error;
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsData options:NSJSONReadingMutableContainers error:&error];
             [self.dataArray removeAllObjects];
             //第二次分离
             if ([dic isKindOfClass:[NSDictionary class]]) {
                 NSDictionary *subDict1 = [dic objectForKey:@"Value"];
                 NSDictionary *subDict2 = [subDict1 objectForKey:@"Data"];
                 NSDictionary *sssDict = [[NSDictionary alloc]initWithDictionary:subDict2];
                 GoodsMngDetModel *model = [[[GoodsMngDetModel alloc]init]initWithDictionary:sssDict];
                 [self.dataArray addObject:model];
                 strRET = [NSString stringWithFormat:@"%@", model.RetailPrice];
             }
             
             [self createTableView];
             [_tableview reloadData];
         }
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}


#pragma mark —————————————上传服务器————————————
- (void)uploadData
{
/**
 *    注释：这里之所以不用王谦封装的“SBJson4Writer.h”，三方文件，是因为SBJson性能比较低
 *
 *
 *    拼接json 发送（我的三方见下方注释）
 *
 */
    NSDictionary *dict = @{@"RetailPrice":strRET,@"IsHandInput":_HandInput,@"IsForbidden":_Forbidden,@"UpdateUser":updateUser};
    NSString *detail = [self dictionaryToJson:dict];//把字典转换成JSonStr的格式作为参数请求

    NSLog(@"%@",detail);

    NSString *str = [NSString stringWithFormat:@UpdateGoodsInfoByIdUrl];
    NSDictionary * params = @{@"id":_GUID,@"detail":detail,@"code":@"gy7412589630"};
    [AFHTTPClientV2 requestWithBaseURLStr:str
                                   params:params
                               httpMethod:kHTTPReqMethodTypePOST
                                 userInfo:nil
                                  success:^(AFHTTPClientV2 *request, id responseObject)
     {
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
                 NSDictionary *subDict1 = [dic objectForKey:@"Result"];
                 NSString *sre = [NSString stringWithFormat:@"%@",subDict1];
                 int str = [sre intValue];
                 if ( str == 1) {
                     NSLog(@"修改成功");
                     [self download];
                 } else {
                     NSLog(@"上传数据失败");
                 }
             }
         }
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
    {
        NSLog(@"%@",error);
    }];
}


#pragma mark ——————————————点击事件————————————
- (void)alertAction
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"您是否需要编辑商品详细信息？" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *editor = [UIAlertAction actionWithTitle:@"编辑" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self editorAction:nil];//发出警告后，选择编辑调用编辑按钮事件
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"这里要添加一个取消事件");
    }];
    [alertController addAction:editor];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion: nil];
}

#if 0
/**
 *点击cell修改cell的数据源的方法:
     1.设置一个单击触发事件（原因是数据源方法先于代理点击事件方法触发，所有要点击修改就要回调数据源方法）
     2.用一个响应机制监听触发事件（例：if ([_tableview.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) { <#statements#> ｝）
 */
- (void)btnActionForUserSetting:(id) sender {
    
    NSIndexPath *indexPath = [_tableview indexPathForSelectedRow];
    
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = @"abc";
    [_tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}
#endif

- (void)switchAction:(UISwitch *)sender
{
    if ([handSwitch isEqual:sender]) {
        if (sender.isOn) {
            _HandInput = @1;
            NSLog(@"是手输金额");
        } else {
            _HandInput = @0;
            NSLog(@"不是手输金额");
        }
    } else {
        if (sender.isOn) {
            _Forbidden = @0;
            NSLog(@"不禁止上架");
        } else {
            _Forbidden = @1;
            NSLog(@"禁止上架");
        }
    }
}


- (void)editorAction:(UIButton *)sender
{
    //1.移除工厂模式添加的“编辑”按钮
    for (UIImageView *editor in [self.view subviews]) {
        if ([editor isKindOfClass:[UIImageView class]]) {
            [editor removeFromSuperview];
        }
    }
    //2.工厂模式添加一个“保存按钮”
    [self createNav];
    [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
    [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"商品详情"];
    //3.控制switch的操作状态
    _tableview.tableFooterView.hidden = NO;
    handSwitch.userInteractionEnabled = YES;
    forbiddenSwitch.userInteractionEnabled = YES;
    
    //4.调出文本框进行编辑
    if (inputPrice) {
        //如何存在则删除，防止数据的重叠
        [inputPrice removeFromSuperview];
    }
    //a.动态计算售价frame
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    NSString *string = [NSString stringWithFormat:@"¥%.2f (请输入新售价)", strRET.doubleValue];
    CGSize size = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
      //b.创建售价的 UITextField
    inputPrice = [[UITextField alloc] initWithFrame:CGRectMake(ScreenWidth - 90 - size.width, 155, size.width + 30, 45)];
    inputPrice.borderStyle = UITextBorderStyleNone;
    inputPrice.placeholder = string;
    inputPrice.textAlignment = NSTextAlignmentRight;
    inputPrice.clearButtonMode = UITextFieldViewModeWhileEditing;

    inputPrice.keyboardType = UIKeyboardTypeDecimalPad;
    inputPrice.returnKeyType = UIReturnKeyDefault;

      //c.拿到cell删除UITextView添加UITextField
    NSInteger selectedIndex = 0;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
    UITableViewCell *cell = [_tableview cellForRowAtIndexPath:indexPath];
        //c.1.先删除
    for (UITextView *RetailPrice in [cell.contentView subviews]) {
        if ([RetailPrice isKindOfClass:[UITextView class]]) {
            [RetailPrice removeFromSuperview];
        }
    }
        //c.2再添加
    [cell.contentView addSubview:inputPrice];
}

- (void)saveAction:(UIButton *)sender
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"注意" message:@"确定将修改的数据保存并上传到服务器？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (![inputPrice.text isEqualToString:@""]) {
            strRET = inputPrice.text;
        }
        [self uploadData];
        [self backAction:sender];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"这里要添加一个取消事件");
    }];
    [alertController addAction:ok];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion: nil];
}


//返回按钮的点击事件
- (void)backAction:(UIButton *)btn
{
    if (_tableview.tableFooterView.hidden) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        //1.移除保存界面
        for (UIImageView *save in [self.view subviews]) {
            if ([save isKindOfClass:[UIImageView class]]) {
                [save removeFromSuperview];
            }
        }
        //2.返回编辑界面
        [self createNav];
        [self addNavButton:CGRectMake(-10, 25, 60, 30) imageName:@"back_icon@2x" target:self action:@selector(backAction:)];
        [self addNavLabel:CGRectMake(ScreenWidth/2.737, 25, 100, 30) font:[UIFont systemFontOfSize:20] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter text:@"商品详情"];
        [self addNavButton:CGRectMake(ScreenWidth/1.2, 25, 50, 30) text:@"编辑" target:self action:@selector(editorAction:)];
        _tableview.tableFooterView.hidden =YES;
        handSwitch.userInteractionEnabled = NO;
        forbiddenSwitch.userInteractionEnabled = NO;
        //3.返回后售价数据的刷新
        [inputPrice resignFirstResponder];
        inputPrice.text = [NSString stringWithFormat:@"%.2f",strRET.description.doubleValue];
    }
}


//推出页面的时候让tababr
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl hideTabBar];
}

//将要返回的时候
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    MainViewController *tabCtrl = (MainViewController *)self.tabBarController;
    [tabCtrl showTabBar];
}



#pragma mark —————————————三方包——————————————
/*＊

 * @brief 把格式化的JSON格式的字符串转换成字典

 * @param jsonString JSON格式的字符串

 * @return 返回字典

 */

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {

    if (jsonString == nil) {

        return nil;

    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

    NSError *err;

    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData

                                                        options:NSJSONReadingMutableContainers

                                                          error:&err];

    if(err) {

        NSLog(@"json解析失败：%@",err);

        return nil;

    }

    return dic;

}


//词典转换为字符串
- (NSString*)dictionaryToJson:(NSDictionary *)dic {

    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

}


@end