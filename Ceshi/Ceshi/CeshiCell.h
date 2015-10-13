//
//  CeshiCell.h
//  Ceshi
//
//  Created by Apple on 15/9/6.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CeshiCell : UITableViewCell
@property (strong, nonatomic) UIView * view;
@property (strong, nonatomic) UIView * seleView;
- (void)changeColorWithCell:(NSIndexPath *)index;
- (void)recoveryColorWithCell:(NSIndexPath *)index;
@end
