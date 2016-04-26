//
//  SalesMoneyView.h
//  guoping
//
//  Created by zhisu on 15/10/28.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SalesMoneyModel.h"
#import "SeNumberModel.h"
@interface SalesMoneyView : UIView

@property(nonatomic,retain)SalesMoneyModel *cellModel;

@property(nonatomic,retain) SeNumberModel *cellModelNumber;
@end
