//
//  TwoViewController.m
//  Ceshi
//
//  Created by Apple on 15/9/2.
//  Copyright (c) 2015年 赵磊. All rights reserved.
//

#import "TwoViewController.h"
#import "CeshiCell.h"
#import "CExpandHeader.h"

@interface TwoViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    CExpandHeader * _header;
}
@property (strong, nonatomic) UITableView * tableView;
@property (strong, nonatomic)NSIndexPath *selectedIndexPath;

@end

@implementation TwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(100, 150, 200, 20)];
    label.text = @"TwoViewController";
    [self.view addSubview:label];
    
    [self createTableView];
    
    // Do any additional setup after loading the view.
}

- (void)createTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, 320, 568 -64 -49)];
    _tableView.delegate= self;
    _tableView.dataSource = self;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 180)];
    [imageView setImage:[UIImage imageNamed:@"image"]];
    
    _header = [CExpandHeader expandWithScrollView:_tableView expandView:imageView];
    
    [self.view addSubview:_tableView];
}

#pragma mark ------------------TableViewDataSource--------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld", (long)[indexPath row]];
    CeshiCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    CeshiCell * cell = (CeshiCell *)[tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[CeshiCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if (self.selectedIndexPath) {
        if (self.selectedIndexPath.row == indexPath.row) {
            [cell changeColorWithCell:indexPath];
        }else{
            cell.seleView.frame = CGRectMake(0, 50, 320, 0);
        }
    }
    
    cell.seleView.tag = indexPath.row;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CeshiCell * cell;
    
    if (self.selectedIndexPath) {
        if (self.selectedIndexPath == indexPath) {
            return;
        }
        cell = (CeshiCell *)[tableView cellForRowAtIndexPath:self.selectedIndexPath];
        [self recoveryColorWithCell:cell];
    }
    
    cell = (CeshiCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell changeColorWithCell:indexPath];
    
    self.selectedIndexPath = indexPath;
}

- (void)recoveryColorWithCell:(CeshiCell *)cell {
    cell.seleView.frame = CGRectMake(0, 50, 320, 0);
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
