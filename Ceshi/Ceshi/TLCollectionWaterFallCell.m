//
//  TLCollectionWaterFallCell.m
//  Ceshi
//
//  Created by Apple on 15/9/7.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "TLCollectionWaterFallCell.h"

@implementation TLCollectionWaterFallCell

- (void)config:(NSIndexPath *)index {
    [_label removeFromSuperview];
    [_image removeFromSuperview];
    
    [self.contentView addSubview:self.label];
    [self.contentView addSubview:self.image];
    
    if (index.row == 0) {
        _image.hidden = NO;
        [_label removeFromSuperview];
    }else{
        self.label.text = [NSString stringWithFormat:@"%zi", index.row];
        _image.hidden = YES;
    }
}

#pragma mark -
#pragma mark init methods
- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:25];
        _label.textColor = [UIColor blackColor];
    }
    return _label;
}

- (UILabel *)image {
    if (!_image) {
        _image = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.origin.x, self.bounds.origin.y, self.bounds.size.width, 60)];
        _image.hidden = YES;
        _image.textAlignment = NSTextAlignmentCenter;
        _image.font = [UIFont boldSystemFontOfSize:25];
        _image.textColor = [UIColor blackColor];
        _image.text = @"图片";
    }
    return _image;
}

#pragma mark -
#pragma mark lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.image];
    }
    return self;
}
@end
