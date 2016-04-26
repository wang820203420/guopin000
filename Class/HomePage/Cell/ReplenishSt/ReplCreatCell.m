//
//  ReplCreatCell.m
//  guoping
//
//  Created by wangqian on 15/11/29.
//  Copyright © 2015年 zhisu. All rights reserved.
//

#import "ReplCreatCell.h"
#import "ReplCreatModel.h"

@interface ReplCreatCell ()


@property(nonatomic,strong)UILabel *CreateUser;



@end
@implementation ReplCreatCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"cellID";
    ReplCreatCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        
        cell = [[ReplCreatCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        
        UILabel *label = [MyUtil createLabelFrame:CGRectMake(10, 20, 70, 10) title:@"制单人" textAlignment:NSTextAlignmentLeft];
        label.textColor = [UIColor colorWithRed:122.0/255.0 green:122.0/255.0 blue:122.0/255.0 alpha:1];
        label.font = [UIFont systemFontOfSize:16];
        [self.contentView addSubview:label];
        
        self.CreateUser = [[UILabel alloc]init];
        self.CreateUser.frame = CGRectMake(ScreenWidth/1.03, 12, 150, 20);
        self.CreateUser.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.CreateUser];

    }
    
    return self;
    
}



-(void)setCellModel:(ReplCreatModel *)cellModel
{
    
    _cellModel = cellModel;
    
    self.CreateUser.text = _cellModel.CreateUser;

    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:15]};
    
    //动态计算出宽度
    CGSize size1 = [ self.CreateUser.text boundingRectWithSize:CGSizeMake(MAXFLOAT, 30) options: NSStringDrawingUsesLineFragmentOrigin  attributes:attribute context:nil].size;
    
    
    CGRect frame1 =  self.CreateUser.frame;
    frame1.size.width = size1.width;
    frame1.origin.x =ScreenWidth/1.03-size1.width;
    
    self.CreateUser.frame = frame1;
    
    
}

@end
