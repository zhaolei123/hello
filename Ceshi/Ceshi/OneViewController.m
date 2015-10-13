//
//  OneViewController.m
//  Ceshi
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "OneViewController.h"
#import "AnimaView.h"

@interface OneViewController ()
{
    UIImageView * imgView;
    
    AnimaView * viw;
    
    UIView * backView;
    
    UIScrollView * shaiView;
}
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 200, 20)];
    label.text = @"OneViewController";
    [self.view addSubview:label];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(200, 150, 100, 100);
    button.backgroundColor = [UIColor blackColor];
    [button addTarget:self action:@selector(ViewClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    //添加图片
    imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"drop"]];
    imgView.frame = CGRectMake(100, 100, imgView.frame.size.width, imgView.frame.size.height);
    [self.view addSubview:imgView];
    
    viw = [[AnimaView alloc]initWithFrame:CGRectMake(0, 300, 320, 100)];
    [self.view addSubview:viw];
    
    
    
    backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    backView.backgroundColor = [UIColor blackColor];
    backView.alpha = 0;
//    backView.hidden = YES;
    [self.view addSubview:backView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
    [backView addGestureRecognizer:tap];
    
    shaiView = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 568, 300, 568 - 84)];
    shaiView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shaiView];
    
    for (int i = 0; i<3; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(300/3*i+10, 40, 300/3, 40);
        button.backgroundColor = [UIColor redColor];
        button.tag = i;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:button];
    }
    
    UILabel * one = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
    one.text = @"one";
    [shaiView addSubview:one];
    
    UILabel * two = [[UILabel alloc]initWithFrame:CGRectMake(320, 0, 100, 20)];
    two.text = @"two";
    [shaiView addSubview:two];
    
    UILabel * three = [[UILabel alloc]initWithFrame:CGRectMake(640, 0, 100, 20)];
    three.text = @"three";
    [shaiView addSubview:three];
    
    // Do any additional setup after loading the view.
}

- (void)click:(UIButton *)sender {
    shaiView.contentOffset = CGPointMake(sender.tag*320, 0);
}

- (void)tapClick {
    [UIView animateWithDuration:.4 animations:^{
        backView.alpha = 0;
    }];
    shaiView.frame = CGRectMake(10, 568, 300, 568 - 84);
}

- (void)ViewClick {
    backView.alpha = .4;
    [UIView animateWithDuration:.5 animations:^{
        shaiView.frame = CGRectMake(10, 84, 300, 568 - 84);
    }];
}

- (void)buttonClick {
    [viw AnimaViewTimeClick];
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.fromValue=  [NSNumber numberWithFloat:50];
//    animation.toValue= [NSNumber numberWithFloat:100];
    
    animation.duration= 1;
    
    animation.removedOnCompletion=YES;
    
    animation.fillMode=kCAFillModeForwards;
    
    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects: animation, nil];
    animGroup.duration = 1;
    
    [imgView.layer addAnimation:animGroup forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
