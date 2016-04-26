//
//  MainGoodsViewController.h
//  guoping
//
//  Created by zhisu on 16/1/5.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "BaseViewController.h"

@interface MainGoodsViewController : BaseViewController
@property(nonatomic,copy) void (^block)(NSString *);

@property(nonatomic,copy) void (^guid)(NSString *);
@end
