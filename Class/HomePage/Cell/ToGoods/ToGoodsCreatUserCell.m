//
//  ToGoodsCreatUserCell.m
//  guoping
//
//  Created by zhisu on 15/10/21.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ToGoodsCreatUserCell.h"
#import "ToGoodsCreatUserModel.h"

@interface ToGoodsCreatUserCell ()

@property(nonatomic,strong)UILabel *CreateUser;//商品名称



@end
@implementation ToGoodsCreatUserCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ToGoodsCreatUserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[ToGoodsCreatUserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        UILabel *label2 = [MyUtil createLabelFrame:CGRectMake(10, 10, 70, 10) title:@"制单人" textAlignment:NSTextAlignmentLeft];
        label2.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label2.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:label2];
        
        
        
        self.CreateUser = [[UILabel alloc]init];
        self.CreateUser.frame = CGRectMake(ScreenWidth/1.05, 5, 60, 20);
        self.CreateUser.font = [UIFont systemFontOfSize:15];
        //self.CreateUser.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:self.CreateUser];
        
        

    }
    
    return self;
    
}



-(void)setCellModel:(ToGoodsCreatUserModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.CreateUser.text = _cellModel.CreateUser;
    
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size1 = [self.CreateUser.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    CGRect frame1 = self.CreateUser.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.05-size1.width;
    self.CreateUser.frame = frame1;

    
    
}
@end
