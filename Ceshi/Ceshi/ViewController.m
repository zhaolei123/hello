//
//  ViewController.m
//  Ceshi
//
//  Created by Apple on 15/8/31.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "ViewController.h"
#import "CeViewController.h"
#import "ImageFilterProcessViewController.h"

#define CAMERA_TRANSFORM_X 1
// this works for iOS 4.x
#define CAMERA_TRANSFORM_Y 1.24299

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenHeight (IS_IPHONE5 ? 548.0 : 460.0)

@interface ViewController ()<UIScrollViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ImageFitlerProcessDelegate>
{
    UIView * view;
    
    UIScrollView * sc;
    
    CGPoint i ;
    
    UIView * hiddenView;
    
    UIScrollView * tabBarSc;
    
    UIButton * tempButton;
    
    UIImagePickerController *imagePickerController;
    
    UIImageView * imageView;
}
@end

@implementation ViewController
//static ViewController * vc = nil;
//
//+ (ViewController *)shareViewController {
//    
//    dispatch_once_t pr;
//    dispatch_once(&pr, ^{
//        vc = [[ViewController alloc]init];
//    });
//    return vc;
//}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
    sc.delegate = self;
    sc.contentSize = CGSizeMake(320, 900);
    [self.view addSubview:sc];
    
    hiddenView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    hiddenView.backgroundColor = [UIColor blueColor];
    hiddenView.alpha = 0;
    [self.view addSubview:hiddenView];
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 300, 320, 568 - 300)];
    [self.view addSubview:imageView];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 200, 20)];
    label.text = @"ViewController";
    label.font= [UIFont fontWithName:@"Helvetica Regular" size:18];
    [sc addSubview:label];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 150, 200, 100);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [sc addSubview:button];
    
    view = [[UIView alloc]initWithFrame:CGRectMake(320, 64, 0, 0)];
    view.backgroundColor = [UIColor grayColor];
    view.userInteractionEnabled = YES;
    [sc addSubview:view];
    
    
    
    UIButton * lala = [UIButton buttonWithType:UIButtonTypeCustom];
    lala.frame = CGRectMake(0, 50, 100, 100);
    lala.backgroundColor = [UIColor redColor];
    [lala addTarget:self action:@selector(laClick) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:lala];
    
    //顶部标签页
    tabBarSc = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 320, 44)];
    tabBarSc.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tabBarSc];
    
    NSArray * arr = @[@"结束",@"9.1",@"9.2",@"9.3",@"9.4",@"9.5",@"9.6",@"9.7",@"9.8"];
    for (int j = 0 ; j<9; j++) {
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(320/5*j + 320/5, 0, 320/5, 44);
        [button setTitle:arr[j] forState:UIControlStateNormal];
        button.tag = j;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont fontWithName:@"Helvetica Regular" size:24];
        if (j==1) {
            button.backgroundColor = [UIColor purpleColor];
            tempButton = button;
        }
        
        [button addTarget:self action:@selector(scClick:) forControlEvents:UIControlEventTouchUpInside];
        [tabBarSc addSubview:button];
    }
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)scClick:(UIButton *)sender {
    
    if (sender == tempButton) {
        return;
    }
    
    [UIView animateWithDuration:.5 animations:^{
       tabBarSc.contentOffset = CGPointMake(320/5*(sender.tag - 1), 0);
    }];
    
    sender.backgroundColor = [UIColor purpleColor];
    
    tempButton.backgroundColor = [UIColor clearColor];
    
    tempButton = sender;
    
}

- (void)laClick {
    CeViewController * vc = [[CeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES
     ];
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < i.y) {
        
        if (hiddenView.alpha <=0) {
            return;
        }
        if (scrollView.contentOffset.y > 0) {
            return;
        }
//        sc.frame = CGRectMake(0, 0, 320, 568 );
        NSLog(@"向下");
        hiddenView.alpha = hiddenView.alpha - .1;
    }else {
        NSLog(@"向上");
        if (hiddenView.alpha >=1) {
            return;
        }
        if (scrollView.contentOffset.y <0) {
            return;
        }
//        sc.frame = CGRectMake(0, 64, 320, 568 - 64);
        hiddenView.alpha = hiddenView.alpha + .1;
        
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    i = scrollView.contentOffset;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    i = scrollView.contentOffset;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    
}


- (void)click {
    
//    [UIView animateWithDuration:1 animations:^{
//        view.frame = CGRectMake(0, 64, 320, 300);
//    }];
    
    
    UIActionSheet *actionSheet = nil;
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera])
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString (@"选择照片",@"")
                                                  delegate:self
                                         cancelButtonTitle:NSLocalizedString (@"取消",@"")
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:NSLocalizedString (@"图库",@""),nil
                       ];
        actionSheet.tag = 1;//表示没有摄像头
    }
    else {
        actionSheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString (@"选择照片",@"")
                                                  delegate:self
                                         cancelButtonTitle:NSLocalizedString (@"取消",@"")
                                    destructiveButtonTitle:nil
                                         otherButtonTitles:NSLocalizedString (@"图库",@""),NSLocalizedString (@"拍照",@""), nil
                       ];
    }
    
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.allowsEditing = YES;
        picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        }
        else
        {
            [self presentModalViewController:picker animated:YES];
        }
    }
    else if (buttonIndex == 1 && actionSheet.tag == 0) {
        
        imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        UIImage *deviceImage = [UIImage imageNamed:@"camera_button_switch_camera.png"];
        UIButton *deviceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [deviceBtn setBackgroundImage:deviceImage forState:UIControlStateNormal];
        [deviceBtn addTarget:self action:@selector(swapFrontAndBackCameras:) forControlEvents:UIControlEventTouchUpInside];
        [deviceBtn setFrame:CGRectMake(250, 20, deviceImage.size.width, deviceImage.size.height)];
        
        [imagePickerController setShowsCameraControls:NO];
//        [self setShowsCameraControls:NO];
        imagePickerController.view.frame = CGRectMake(0, 0, 320, 568);
#warning 自定义相机
        UIView *overlyView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight -34, 320, 44)];
//        overlyView.alpha = .4;
        [overlyView setBackgroundColor:[UIColor clearColor]];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *backImage = [UIImage imageNamed:@"camera_cancel.png"];
        [backBtn setImage: backImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        [backBtn setFrame:CGRectMake(8, 5, backImage.size.width, backImage.size.height)];
        [overlyView addSubview:backBtn];
        
        UIImage *camerImage = [UIImage imageNamed:@"camera_shoot.png"];
        UIButton *cameraBtn = [[UIButton alloc] initWithFrame:
                               CGRectMake(110, 5, camerImage.size.width, camerImage.size.height)];
        [cameraBtn setImage:camerImage forState:UIControlStateNormal];
        [cameraBtn addTarget:self action:@selector(takePicture) forControlEvents:UIControlEventTouchUpInside];
        [overlyView addSubview:cameraBtn];
        
        UIImage *photoImage = [UIImage imageNamed:@"camera_album.png"];
        UIButton *photoBtn = [[UIButton alloc] initWithFrame:CGRectMake(260, 5, 70, 40)];
        [photoBtn setImage:photoImage forState:UIControlStateNormal];
        [photoBtn addTarget:self action:@selector(showPhoto) forControlEvents:UIControlEventTouchUpInside];
        [overlyView addSubview:photoBtn];
        
//        self.cameraOverlayView = overlyView;
        imagePickerController.cameraOverlayView = overlyView;
        
        [self presentModalViewController:imagePickerController animated:NO];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        }
        else
        {
//            [self presentModalViewController:picker animated:YES];
        }
    }
}

- (void)closeView
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)takePicture
{
    [imagePickerController takePicture];
}

- (void)showPhoto
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [picker dismissViewControllerAnimated:NO completion:^{
        ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
        [fitler setDelegate:self];
        fitler.currentImage = image;
        [self presentModalViewController:fitler animated:YES];
    }];
//    NSData *imageData = UIImageJPEGRepresentation(image, 0.4);
//    imageview.image=[UIImage imageWithData:imageData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
