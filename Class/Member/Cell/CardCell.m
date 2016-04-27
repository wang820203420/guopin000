//
//  CardCell.m
//  guoping
//
//  Created by zhisu on 16/4/27.
//  Copyright © 2016年 zhisu. All rights reserved.
//

#import "CardCell.h"
#import "CardModel.h"


@interface CardCell ()

@property(nonatomic,strong)UILabel *TypeName;

@end

@implementation CardCell



+(instancetype)cellWithTableView:(UITableView *)tableView
{
    //创建cell
    NSString *cellID = @"TwoCellID";
    CardCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    if (cell == nil) {
        cell = [[CardCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
    }
    
    
    
    return cell;
    
    
}

#pragma mark 下拉列表中所有店铺的名称列表

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
        self.TypeName = [[UILabel alloc]init];
        self.TypeName.frame = CGRectMake(10, 15, 150, 10);
        
        self.TypeName.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:self.TypeName];
        
        
        
        
    }
    
    return self;
    
}



-(void)setCellModel:(CardModel *)cellModel
{
    
    _cellModel = cellModel;
    
    
    self.TypeName.text = _cellModel.TypeName;
    
    
}









- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
