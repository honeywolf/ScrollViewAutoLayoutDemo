//
//  MainViewController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/7.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "MainViewController.h"
#import "MasonryViewController.h"
#import "BaseuseViewController.h"
#import "UpdateConstraintViewController.h"
#import "RemarkConstraintController.h"
#import "AnimateController.h"
#import "CompositeController.h"
#import "AspectFitController.h"
#import "TableViewController.h"
#import "ScrollViewController.h"
#import "ScrollViewComplexController.h"
#import "HeaderFooterController.h"
#import "AutoHeightCellController.h"
#import "CellEmbedTableViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }

    if (indexPath.row == 0) {
        cell.textLabel.text = @"Masonry的scrollView约束";
    }
    
    if (indexPath.row == 1) {
        cell.textLabel.text = @"Masonry的基本约束";
    }
    
    if (indexPath.row == 2) {
        cell.textLabel.text = @"Masonry的更新约束";
    }
    
    if (indexPath.row == 3) {
        cell.textLabel.text = @"remake 更新约束";
    }
    
    if (indexPath.row == 4) {
        cell.textLabel.text = @"整体动画";
    }
    
    if (indexPath.row == 5) {
        cell.textLabel.text = @"复合约束";
    }
    
    if (indexPath.row == 6) {
        cell.textLabel.text = @"Masonry 的比例";
    }
    
    if (indexPath.row == 7) {
        cell.textLabel.text = @"Masonry 的tableViewCell布局";
    }
    
    if (indexPath.row == 8) {
        cell.textLabel.text = @"Masonry 的scrollView循环布局";
    }
    
    if (indexPath.row == 9) {
        cell.textLabel.text = @"Masonry 的scrollView复杂布局";
    }
    
    if (indexPath.row == 10) {
        cell.textLabel.text = @"Masonry 的scrollView实战";
    }
    
    if (indexPath.row == 11) {
        cell.textLabel.text = @"自动计算行高";
    }
    
    if (indexPath.row == 12) {
        cell.textLabel.text = @"cell中嵌套UITableview";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *vc = nil;
    if (indexPath.row == 0) {
        vc = [[MasonryViewController alloc]init];
        
    }
    if (indexPath.row == 1) {
        vc = [[BaseuseViewController alloc]init];
        
    }
    if (indexPath.row == 2) {
        vc = [[UpdateConstraintViewController alloc]init];
        
    }
    if (indexPath.row == 3) {
        vc = [[RemarkConstraintController alloc]init];
    }
    if (indexPath.row == 4) {
        vc = [[AnimateController alloc]init];
    }
    if (indexPath.row == 5) {
        vc = [[CompositeController alloc]init];
    }
    if (indexPath.row == 6) {
        vc = [[AspectFitController alloc]init];
    }
    if (indexPath.row == 7) {
        vc = [[TableViewController alloc]init];
    }
    if (indexPath.row == 8) {
        vc = [[ScrollViewController alloc]init];
    }
    if (indexPath.row == 9) {
        vc = [[ScrollViewComplexController alloc]init];
    }
    if (indexPath.row == 10) {
        vc = [[HeaderFooterController alloc]init];
    }
    if (indexPath.row == 11) {
        vc = [[AutoHeightCellController alloc]init];
    }
    if (indexPath.row == 12) {
        vc = [[CellEmbedTableViewController alloc]init];
    }
    [self.navigationController pushViewController:vc animated:YES];
}
@end
