//
//  CeshiCell.m
//  Ceshi
//
//  Created by Apple on 15/9/6.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "CeshiCell.h"

@implementation CeshiCell

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        [self.contentView addSubview:_view];
        _view.backgroundColor = [UIColor redColor];
        
        _seleView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 0)];
        [self.contentView addSubview:_seleView];
        _seleView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        [self.contentView addSubview:_view];
        _view.backgroundColor = [UIColor redColor];
        
        _seleView = [[UIView alloc]initWithFrame:CGRectMake(0, 50, 320, 0)];
        [self.contentView addSubview:_seleView];
        _seleView.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)changeColorWithCell:(NSIndexPath *)index {
    UIView * view = [_seleView viewWithTag:index.row];
    [UIView animateWithDuration:.5 animations:^{
        view.frame = CGRectMake(0, 0, 320, 100);
    }];
}

- (void)recoveryColorWithCell:(NSIndexPath *)index {
    UIView * view = [_seleView viewWithTag:index.row];
    [UIView animateWithDuration:.5 animations:^{
        view.frame = CGRectMake(0, 0, 320, 100);
    }];
    _seleView.backgroundColor = [UIColor redColor];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
