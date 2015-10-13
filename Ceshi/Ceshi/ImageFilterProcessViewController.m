//
//  ImageFilterProcessViewController.m
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "ImageFilterProcessViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"

#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenHeight (IS_IPHONE5 ? 548.0 : 460.0)

@interface ImageFilterProcessViewController ()

@end

@implementation ImageFilterProcessViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)backView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}
- (IBAction)fitlerDone:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImageWriteToSavedPhotosAlbum(rootImageView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    }];
    
//    [self dismissViewControllerAnimated:NO completion:^{
//        [self.delegate imageFitlerProcessDone:rootImageView.image];
//    }];
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"呵呵";
    if (!error) {
        message = @"成功保存到相册";
    }else
    {
        message = [error description];
    }
    NSLog(@"message is %@",message);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"btn_back.png"] forState:UIControlStateNormal];
    [leftBtn setFrame:CGRectMake(10, 20, 34, 34)];
    [leftBtn addTarget:self action:@selector(backView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftBtn];
    
    UIButton *rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"camera_btn_ok.png"] forState:UIControlStateNormal];
    [rightBtn setFrame:CGRectMake(270, 20, 34, 34)];
    [rightBtn addTarget:self action:@selector(fitlerDone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.388 alpha:1.000]];
    rootImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(40, 70, 230, 300)];
    rootImageView.image = self.currentImage;
    [self.view addSubview:rootImageView];
    
    NSArray *arr = [NSArray arrayWithObjects:@"原图",@"LOMO",@"黑白",@"复古",@"哥特",@"锐色",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
    scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 80, 320, 80)];
    scrollerView.backgroundColor = [UIColor clearColor];
    scrollerView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.showsVerticalScrollIndicator = NO;//关闭纵向滚动条
    scrollerView.bounces = NO;
    
    
    NSArray *array=[[NSArray alloc] initWithObjects:
                    @"None",
                    @"CIColorCrossPolynomial",
                    @"CIColorCube",
                    @"CIColorCubeWithColorSpace",
                    @"CIColorInvert",
                    @"CIColorMap",
                    @"CIColorMonochrome",
                    @"CIColorPosterize",
                    @"CIFalseColor",
                    @"CIMaskToAlpha",
                    @"CIMaximumComponent",
                    @"CIMinimumComponent",
                    @"CIPhotoEffectChrome",
                    @"CIPhotoEffectFade",
                    @"CIPhotoEffectInstant",
                    @"CIPhotoEffectMono",
                    @"CIPhotoEffectNoir",
                    @"CIPhotoEffectProcess",
                    @"CIPhotoEffectTonal",
                    @"CIPhotoEffectTransfer",
                    @"CISepiaTone",
                    @"CIVignette",
                    @"CIVignetteEffect",
                    nil];
    float x ;
    for(int i=0;i<14;i++)
    {
        x = 10 + 51*i;
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(setImageStyle:)];
        recognizer.numberOfTouchesRequired = 1;
        recognizer.numberOfTapsRequired = 1;
        recognizer.delegate = self;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, 53, 40, 23)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[arr objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:[UIFont systemFontOfSize:13.0f]];
        [label setTextColor:[UIColor whiteColor]];
        [label setUserInteractionEnabled:YES];
        [label setTag:i];
        [label addGestureRecognizer:recognizer];
        
        [scrollerView addSubview:label];
        
        UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, 10, 40, 43)];
        [bgImageView setTag:i];
        [bgImageView addGestureRecognizer:recognizer];
        [bgImageView setUserInteractionEnabled:YES];
        
        
//        UIImage *bgImage = [self changeImage:i imageView:nil];
        UIImage *bgImage = [self effectImage:self.currentImage byFilterName:array[i]];
        bgImageView.image = bgImage;
        [scrollerView addSubview:bgImageView];

    }
    scrollerView.contentSize = CGSizeMake(x + 55, 80);
    [self.view addSubview:scrollerView];
    
	// Do any additional setup after loading the view.
}

- (IBAction)setImageStyle:(UITapGestureRecognizer *)sender
{
    NSArray *array=[[NSArray alloc] initWithObjects:
                    @"None",
                                        @"CIColorCrossPolynomial",
                                        @"CIColorCube",
                                        @"CIColorCubeWithColorSpace",
                                        @"CIColorInvert",
                                        @"CIColorMap",
                                        @"CIColorMonochrome",
                                        @"CIColorPosterize",
                    @"CIFalseColor",
                                        @"CIMaskToAlpha",
                    @"CIMaximumComponent",
                    @"CIMinimumComponent",
                    @"CIPhotoEffectChrome",
                    @"CIPhotoEffectFade",
                    @"CIPhotoEffectInstant",
                    @"CIPhotoEffectMono",
                    @"CIPhotoEffectNoir",
                    @"CIPhotoEffectProcess",
                    @"CIPhotoEffectTonal",
                    @"CIPhotoEffectTransfer",
                    @"CISepiaTone",
                    @"CIVignette",
                    @"CIVignetteEffect",
                    nil];
//    UIImage *image =   [self changeImage:sender.view.tag imageView:nil];
    UIImage *image =   [self effectImage:self.currentImage byFilterName:array[sender.view.tag]];
    [rootImageView setImage:image];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage *)changeImage:(int)index imageView:(UIImageView *)imageView
{
    // 似乎只有一部分可以在 iOS 中使用
    NSArray *array=[[NSArray alloc] initWithObjects:
                    @"None",
                    @"CIColorCrossPolynomial",
                    @"CIColorCube",
                    @"CIColorCubeWithColorSpace",
                    @"CIColorInvert",
                    @"CIColorMap",
                    @"CIColorMonochrome",
                    @"CIColorPosterize",
                    @"CIFalseColor",
                    @"CIMaskToAlpha",
                    @"CIMaximumComponent",
                    @"CIMinimumComponent",
                    @"CIPhotoEffectChrome",
                    @"CIPhotoEffectFade",
                    @"CIPhotoEffectInstant",
                    @"CIPhotoEffectMono",
                    @"CIPhotoEffectNoir",
                    @"CIPhotoEffectProcess",
                    @"CIPhotoEffectTonal",
                    @"CIPhotoEffectTransfer",
                    @"CISepiaTone",
                    @"CIVignette",
                    @"CIVignetteEffect",
                    nil];
    
    UIImage *image;
    image = [self effectImage:imageView.image byFilterName:array[index]];
    
    return image;
}

- (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 640; // Or whatever
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}

- (UIImage *) effectImage: (UIImage *)uIImage byFilterName:(NSString *)filterName;
{
    if ([filterName isEqualToString:@"None"]) {
        return uIImage;
    }
    
    UIImage *tempImage = [self scaleAndRotateImage:uIImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    
    CIImage *ciImage = [[CIImage alloc] initWithImage:tempImage]; // 解决滤镜后图片方向不对的问题
    
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setValue:ciImage forKey:kCIInputImageKey];
    
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    CGRect extent = [result extent];
    
    CGImageRef cgImage = [context createCGImage:result fromRect:extent];
    UIImage *filteredImage = [[UIImage alloc] initWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return filteredImage;
}

- (void)dealloc
{
    scrollerView = nil;
    rootImageView = nil;
//    self.currentImage  =nil;
}
@end
