//
//  LogViewController.m
//  guoping
//
//  Created by zhisu on 15/9/8.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "LogViewController.h"
#import "ChangeLeftBtn.h"
#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "MainViewController.h"
#import "LogModel.h"
@interface LogViewController ()<UITextFieldDelegate>
{
    //背景
    UIImageView *_imageView;
    
    //用户名输入框
    UITextField *_myUser;
    //密码输入框
    
    UITextField *_PassWord;
    
    //用户名输入框 左视图
    UIImageView *_Leftimage;

    //密码输入框 左视图
    UIImageView *_CodeLeftimage;
    
    NSUserDefaults *mm;
    
    NSString *MyUser;
    NSString *MyPsw;
    NSString *guid;
    
    
}
@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    self.view.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    

    
    
    
    [self crataeBgView];
    
}
-(void)crataeBgView
{
    
    //登录背景颜色
    _imageView= [MyUtil createIamgeViewFrame:self.view.bounds imageName:nil];
    
    _imageView.backgroundColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1];
    
    [self.view addSubview:_imageView];
    
    
    //logo
    UIImageView *image = [MyUtil createIamgeViewFrame:CGRectMake(ScreenWidth/2.3734, ScreenHeight/9.571, ScreenWidth/6.25, ScreenHeight/7.882) imageName:@"logo_122x174@2x"];
    [_imageView addSubview:image];
    
    //输入框背景
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/3.3668, ScreenWidth, ScreenHeight/5.583)];

    bgView.backgroundColor = [UIColor whiteColor];
    
    [_imageView addSubview:bgView];
    
    //用户输入框上面的线条
    UIView *TopLineView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/3.4, ScreenWidth, 0.5)];
    
    TopLineView.backgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1];
    
    [_imageView addSubview:TopLineView];
    
    
    //用户输入框中间的线条
    UIView *CentreLineView = [[UIView alloc]initWithFrame:CGRectMake(20, ScreenHeight/11.166, ScreenWidth-40, 0.5)];
    CentreLineView.backgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1];
    
    [bgView addSubview:CentreLineView];
    
    
    //输入框底部的线条
    
    UIView *BottomLineView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight/2.08, ScreenWidth, 0.5)];
    
    BottomLineView.backgroundColor = [UIColor colorWithRed:216.0/255.0 green:216.0/255.0 blue:216.0/255.0 alpha:1];
    [_imageView addSubview:BottomLineView];
    
    
    
    //用户名输入框
    _myUser = [[UITextField alloc]initWithFrame:CGRectMake(0, ScreenHeight/3.3668, ScreenWidth-15, ScreenHeight/11.166)];
    
    _myUser.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    

    UIView *LeftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    //LeftView.backgroundColor = [UIColor redColor];
   _Leftimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"user_40x40@2x"]];

    _Leftimage.frame = CGRectMake(20, 20, 20, 20);
    
    [LeftView addSubview:_Leftimage];
       _myUser.leftView= LeftView;
    //设置左视图的显示模式
    _myUser.leftViewMode = UITextFieldViewModeAlways;
    _myUser.clearButtonMode = UITextFieldViewModeWhileEditing;

 
    
    
    _myUser.placeholder = @"用户名";
    

    _myUser.delegate = self;
    [_imageView addSubview:_myUser];
    
    
    //密码输入框
    _PassWord = [[UITextField alloc]initWithFrame:CGRectMake(0, ScreenHeight/2.57, ScreenWidth-15, ScreenHeight/11.166)];
    
    _PassWord.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1];
    
  
    
    UIView *CodeLefrView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    
    _CodeLeftimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lock_40x39@2x"]];

    _CodeLeftimage.frame = CGRectMake(20, 20, 20, 20);
    [CodeLefrView addSubview:_CodeLeftimage];
    
        _PassWord.leftView= CodeLefrView;
    //设置左视图的显示模式
    _PassWord.leftViewMode = UITextFieldViewModeAlways;
    _PassWord.clearButtonMode = UITextFieldViewModeWhileEditing;
    


    
    
    
    _PassWord.secureTextEntry = YES;
    _PassWord.delegate = self;
    
    _PassWord.placeholder = @"密码";
    
    [_imageView addSubview:_PassWord];
    
    
    
    
    
    //登录按钮
    UIButton *LogBtn = [MyUtil createBtnFrame:CGRectMake(12, ScreenHeight/1.962, ScreenWidth/1.0684, 50) image:@"greenbuttom_670x90@2x" selectedImage:nil target:self action:@selector(LogAction:)];
    
    [LogBtn setTitle:@"登录" forState:UIControlStateNormal];
    
    [_imageView addSubview:LogBtn];
    
    
    
    //扫一扫
    
    UIButton *SouchBtn = [[ChangeLeftBtn alloc]initWithFrame:CGRectMake(ScreenWidth/1.33928, ScreenHeight/1.7, ScreenWidth/3.75, ScreenHeight/13.4)];
    //SouchBtn.backgroundColor = [UIColor redColor];
    [SouchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    SouchBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [SouchBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [SouchBtn setImage:[UIImage imageNamed:@"saoma_30x30@2x"] forState:UIControlStateNormal];
    
    [SouchBtn addTarget:self action:@selector(souchAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_imageView addSubview:SouchBtn];
    
    

    
}
-(void)souchAction:(ChangeLeftBtn *)btn
{
    NSLog(@"开始扫一扫");
    
}


-(void)LogAction:(UIButton *)btn
{
    
    NSLog(@"登录");
    
    [self login];
    
  
    
}

//点击事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
    NSLog(@"开始编辑");
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _imageView.frame = CGRectMake(0, -25, ScreenWidth, ScreenHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    

    
    //判断点击 输入框时哪个输入框字符长度为 0
    if (textField == _PassWord) {
    
        if (_myUser.text.length == 0) {
            
            
            [_Leftimage setImage:[UIImage imageNamed:@"user_40x40"]];
            
        }
        
    }else if (textField == _myUser)
    {
        
        if (_PassWord.text.length == 0) {
            [_CodeLeftimage setImage:[UIImage imageNamed:@"lock_40x39@2x"]];
            
        }
        
        
        
    }
    
    
   
    
  
    
    
    
    
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    
    if (textField == _myUser) {
          [_Leftimage setImage:[UIImage imageNamed:@"user_40x40"]];
    }else if (textField == _PassWord)
        
    {
        [_CodeLeftimage setImage:[UIImage imageNamed:@"lock_40x39@2x"]];
        
    }

    
    
    
    
    
    return YES;
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField == _myUser) {
        
        NSLog(@"11");
        
        
        [_Leftimage setImage:[UIImage imageNamed:@"user_40x40_hover@2x"]];

        
    }else if (textField == _PassWord)
    {
          [_CodeLeftimage setImage:[UIImage imageNamed:@"lock_40x39_hover@2x"]];
        

    }
    
    NSLog(@"%@", textField.text);
    return YES;
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
  [_myUser resignFirstResponder];
    [_PassWord resignFirstResponder];
    
    
    [UIView animateWithDuration:0.4 animations:^{
        
        _imageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        
    } completion:^(BOOL finished) {
        
    }];
    
    
    
}

#pragma mark - 上传用户名密码

-(void)login
{


    
    

    

    
        MyUser = _myUser.text;
    
         MyPsw = _PassWord.text;
    


 
    
    
    if (MyUser == nil||[MyUser isEqualToString:@""]||MyPsw == nil||[MyPsw isEqualToString:@""]) {
        
        alert(@"您的内容不能为空,请填写完");
        return;
        
    }
    
    NSString *str = [NSString stringWithFormat:@SysLoginUrl];
    
    NSDictionary * params = @{@"enterpriseNodeNo":MyUser,@"psw":MyPsw,@"code":@"gy7412589630"};
    
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
                 
                 NSDictionary *subDict2 = [dic objectForKey:@"Value"];
                 
                 NSDictionary *subDict3 = [subDict2 objectForKey:@"Data"];
                 
                 if ([subDict3 count]==0) {
                        alert(@"检查用户名密码,请重试!");
                     return ;
                    
                 }else
                 {
                     //取到GUID
                     LogModel *model = [[[LogModel alloc]init]initWithDictionary:subDict3];
                     
                     guid = model.GUID;
                     
                     NSLog(@"%@",guid);
                     
                     //将取到的guid 存起来
                     NSUserDefaults *guiddf = [NSUserDefaults standardUserDefaults];
                     [guiddf setObject:guid forKey:@"GUID"];
                     
                     
                     
                     
                 }
         
                 
                 
                 NSLog(@"%@",subDict1);
                 
                 NSString *sre = [NSString stringWithFormat:@"%@",subDict1];
                 int str = [sre intValue];
                 
                 if (  str == 1) {
                   
                     
               
                     
                  
                      NSLog(@"成功");
                     
                      mm= [NSUserDefaults standardUserDefaults];
                     [mm setObject:_myUser.text forKey:@"myuser"];
                     [mm setObject:_PassWord.text  forKey:@"pas"];
                     

                     if (YES)
                     {
                         
                         AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                         
                         //选择退出的控制器
                         UINavigationController * nav = delegate.mainVC.selectedViewController;
                         [nav popToRootViewControllerAnimated:NO];
                          delegate.mainVC.selectedIndex = 0;
        
                         [delegate.rootNav setViewControllers:@[delegate.mainVC] animated:YES];
                         
                         //清除 textfield 上的内容
                         [_PassWord setText:nil];
     
                     }
       
                 }else
                 {
                        NSLog(@"登录失败");

                     alert(@"登录失败,请重试!");
                    
                     
                    
                 }

             }
             
       
     
         }
         
     
         
         
     }
                                  failure:^(AFHTTPClientV2 *request, NSError *error)
     {
         NSLog(@"%@",error);
     }];

    
    
    
    
}




//-(void)viewWillAppear:(BOOL)animated{
//
//    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
//    
//}
@end
