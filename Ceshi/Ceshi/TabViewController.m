//
//  TabViewController.m
//  Ceshi
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "TabViewController.h"
#import "ViewController.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"

@interface TabViewController ()
{
    UIImageView *_tabBarView; //自定义的覆盖原先的tarbar的控件
    
    //记录上次点击按钮的 label
    UILabel * teepLabel;
}

@property (nonatomic, strong) NSMutableArray * dataForImageArr;
@property (nonatomic, strong) NSMutableArray * dataForLabelArr;
@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tabBar.hidden = YES;
    
    [self createViewControllers];
    
    [self makeTabBar];
    
    // Do any additional setup after loading the view.
}

- (void)makeTabBar {
    _tabBarView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 568 - 49, 320, 49)];
    _tabBarView.layer.borderColor = [UIColor grayColor].CGColor;
    _tabBarView.layer.borderWidth = .5;
    _tabBarView.userInteractionEnabled = YES;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBarView];
    
    NSArray * titleArr = @[@"首页",@"精选",@"购物车",@"我的"];
    
    NSArray * imageArr = @[@"drop",@"Settings_00208",@"drop",@"Settings_00208"];
    _dataForImageArr = [[NSMutableArray alloc]initWithCapacity:0];
    _dataForLabelArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i<4; i++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(320/4 * i, 0, 320/4, 49);
        button.tag = i;
        button.backgroundColor = [UIColor clearColor];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:button];
        
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(28 + 320/4*i, 6, 24, 24)];
        imageView.tag = i;
        imageView.image = [UIImage imageNamed:imageArr[i]];
        [_tabBarView addSubview:imageView];
        [_dataForImageArr addObject:imageView];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(320/4*i, 32, 320/4, 10)];
        
        if (i == 0) {
            label.textColor = [UIColor redColor];
            teepLabel = label;
        }
        
        label.text = titleArr[i];
        label.font = [UIFont systemFontOfSize:9];
        label.textAlignment = NSTextAlignmentCenter;
        [_tabBarView addSubview:label];
        [_dataForLabelArr addObject:label];
    }
}

- (void)createViewControllers {
    
    ViewController * vc1 = [[ViewController alloc]init];
    UINavigationController * nc1 = [[UINavigationController alloc]initWithRootViewController:vc1];
    
    OneViewController * vc2 = [[OneViewController alloc]init];
    UINavigationController * nc2 = [[UINavigationController alloc]initWithRootViewController:vc2];
    
    TwoViewController * vc3 = [[TwoViewController alloc]init];
    UINavigationController * nc3 = [[UINavigationController alloc]initWithRootViewController:vc3];
    
    ThreeViewController * vc4 = [[ThreeViewController alloc]init];
    UINavigationController * nc4 = [[UINavigationController alloc]initWithRootViewController:vc4];
    
    self.viewControllers = @[nc1,nc2,nc3,nc4];
    
}

- (void)buttonClick:(UIButton *)sender {
    
    self.selectedIndex = sender.tag;
    
    [self clickButtonWithCount:sender.tag];
    
//    [sender.layer addAnimation:animation forKey:@"playBounceAnimation"];
}

- (void)clickButtonWithCount:(NSInteger)count {
    
    UILabel * label = _dataForLabelArr[count];
    
    if (label == teepLabel) {
        return;
    }
    
    label.textColor = [UIColor redColor];
    
    teepLabel.textColor = [UIColor blackColor];
    
    teepLabel = label;
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.values = @[@(1), @(1.5), @(0.9), @(0.5), @(0.1), @(1)];
    //    animation.duration = self.duration;
    animation.calculationMode = kCAAnimationCubic;
    
    [_dataForImageArr[count] addAnimation:animation forKey:@"playBounceAnimation"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController*)viewController
//{
//    //[UIView beginAnimations:nil context:nil];
//    //[UIView setAnimationDuration:1];
//    //[UIView setAnimationBeginsFromCurrentState:NO];
//    //[UIView setAnimationCurve:UIViewAnimationTransitionFlipFromLeft];
//    //[UIView setAnimationTransition:kCATransitionMoveIn forView:tabBarController.view cache:YES];
//    //[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:viewController.view cache:NO];
//    //[viewController.view removeFromSuperview];
//    //[UIView commitAnimations];
//    CATransition *animation =[CATransition animation];
//    [animation setDuration:0.75f];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
//    [animation setType:kCATransitionMoveIn];
//    [animation setSubtype:kCATransitionFromRight];
//    [tabBarController.view.layer addAnimation:animation forKey:@"reveal"];
//    
//    NSLog(@"should");
//    return YES;
//}

//-(void)tabBar:(UITabBar*)atabBar didSelectItem:(UITabBarItem*)item
//{
//    CATransition* animation = [CATransition animation];
//    [animation setDuration:0.5f];
//    [animation setType:kCATransitionFade];
//    [animation setSubtype:kCATransitionFromRight];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
//    [[self.view layer]addAnimation:animation forKey:@"switchView"];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
