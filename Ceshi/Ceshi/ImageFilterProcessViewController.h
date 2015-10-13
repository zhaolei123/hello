//
//  ImageFilterProcessViewController.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol ImageFitlerProcessDelegate <NSObject>

- (void)imageFitlerProcessDone:(UIImage *)image;
@end
@interface ImageFilterProcessViewController : UIViewController
{
    UIImageView *rootImageView;
    UIScrollView *scrollerView;
}
@property(nonatomic,assign) id<ImageFitlerProcessDelegate> delegate;
@property(nonatomic,strong)UIImage *currentImage;
@end
