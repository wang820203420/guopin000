//
//  MemberDetailViewController.h
//  guoping
//
//  Created by zhisu on 16/4/25.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "BaseViewController.h"

//点击cell详情页入口
@interface MemberDetailViewController : BaseViewController

@property (nonatomic,strong)NSString *cardType;

@property (nonatomic,strong)NSString *storeId;

@property (nonatomic,strong)NSString *memberId;

@property (nonatomic,strong)NSString *mobile;


@end
