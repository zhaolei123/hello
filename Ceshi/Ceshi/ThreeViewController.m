//
//  ThreeViewController.m
//  Ceshi
//
//  Created by Apple on 15/9/2.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "ThreeViewController.h"
#import "TLCollectionWaterFallCell.h"
#import "TLCollectionWaterFallFlow.h"
#import "TitleCell.h"

static NSString * const reuseIdentifier = @"TLCollectionWaterFallCell";

@interface ThreeViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *dataList;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TLCollectionWaterFallFlow *layout;
@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataList = [[NSMutableArray alloc]initWithCapacity:0];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*10)/2.f;
    for (NSUInteger idx = 0; idx < 100; idx ++) {
        CGFloat height = 150 ;
        NSValue *value;
        if (idx == 0) {
            value = [NSValue valueWithCGSize:CGSizeMake(width, 80)];
        }else{
            value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
        }
        
        [_dataList addObject:value];
    }
    [self.view addSubview:self.collectionView];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 200, 20)];
//    label.text = @"ThreeViewController";
//    [self.view addSubview:label];
    // Do any additional setup after loading the view.
}

- (TLCollectionWaterFallFlow *)layout {
    if (!_layout) {
        _layout = [[TLCollectionWaterFallFlow alloc] init];
        _layout.minimumInteritemSpacing = 10;
        _layout.minimumLineSpacing = 10;
        _layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    }
    return _layout;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:[UIScreen mainScreen].bounds
                                             collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TLCollectionWaterFallCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    return _collectionView;
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TLCollectionWaterFallCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:
                                       reuseIdentifier forIndexPath:indexPath];
//    [cell config:indexPath];
    if (indexPath.row == 0) {
        cell.image.hidden = NO;
        cell.label.text = @"";
    }else{
        cell.label.text = [NSString stringWithFormat:@"%zi", indexPath.row];
        cell.image.hidden = YES;
    }
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize size = [[_dataList objectAtIndex:indexPath.row] CGSizeValue];
    
    return  size;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 2*10)/2.f;
//    for (NSUInteger idx = 0; idx < 50; idx ++) {
//        CGFloat height = 100 + (arc4random() % 100);
//        NSValue *value = [NSValue valueWithCGSize:CGSizeMake(width, height)];
//        [_dataList addObject:value];
//    }
//    
//    [self.collectionView reloadData];
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
