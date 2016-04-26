//
//  AppDelegate.h
//  guoping
//
//  Created by zhisu on 15/9/2.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MainViewController;
@class LogViewController;
@class MainViewController;



@interface AppDelegate : UIResponder <UIApplicationDelegate>

//登录代码块
@property (nonatomic,copy) void (^loginCompletionHandler)(void);

@property (strong, nonatomic) UIWindow * window;

@property (nonatomic, retain) UINavigationController * rootNav;
@property (nonatomic, retain) LogViewController      * logVC;
@property (nonatomic, retain) MainViewController     * mainVC;



@end

