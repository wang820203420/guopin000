//
//  LogViewController.h
//  guoping
//
//  Created by zhisu on 15/9/8.
//  Copyright (c) 2015年 zhisu. All rights reserved.
//

#import "BaseViewController.h"

@interface LogViewController : BaseViewController

//@property (nonatomic, assign) BOOL isFirstLaunch;

//登录代码块
@property (nonatomic, copy) void (^loginCompletionHandler)(void);


@end
