//
//  TLCollectionWaterFallCell.h
//  Ceshi
//
//  Created by Apple on 15/9/7.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLCollectionWaterFallCell : UICollectionViewCell
@property (strong, nonatomic) UILabel * label;
@property (strong, nonatomic) UILabel * image;

- (void)config:(NSIndexPath *)index;
@end
