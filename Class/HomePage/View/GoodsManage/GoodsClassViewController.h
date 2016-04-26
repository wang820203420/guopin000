//
//  GoodsClassViewController.h
//  guoping
//
//  Created by zhisu on 15/12/31.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "BaseViewController.h"

@interface GoodsClassViewController : BaseViewController

@property(nonatomic,copy) void (^block)(NSString *);
@property(nonatomic,copy) void (^Class)(NSString *);
@end
