//
//  CellEmbedTableViewController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/11.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "CellEmbedTableViewController.h"
#import "YFTestCell.h"
#import "YFTestModel.h"
#import "CommentModel.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

@interface CellEmbedTableViewController () <YFTestCellDelegate>

@property (nonatomic, strong) NSMutableArray *datasource;

@end

@implementation CellEmbedTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (NSUInteger i = 0; i < 100; i++) {
        YFTestModel *testModel = [[YFTestModel alloc]init];
        testModel.title = @"标哥的技术博客";
        testModel.desc = @"由标哥的技术博客出品，学习如何在cell中嵌套使用tableview并自动计算行高。同时演示如何通过HYBMasonryAutoCellHeight自动计算行高，关注博客：http://www.henishuo.com";
        testModel.headImage = @"head";
        testModel.uid = [NSString stringWithFormat:@"testModel%ld", i + 1];
        testModel.commentModels = [NSMutableArray array];
        NSUInteger randCount = arc4random() % 10 + 1;
        for (NSUInteger j = 0; j < randCount; ++j) {
            CommentModel *model = [[CommentModel alloc] init];
            model.name = @"毅凡";
            model.reply = @"毅凡的技术博客";
            model.comment = @"可以试试HYBMasonryAutoCellHeight这个扩展，自动计算行高的";
            model.cid = [NSString stringWithFormat:@"commonModel%ld", j + 1];
            [testModel.commentModels addObject:model];
        }
        [self.datasource addObject:testModel];
    }
    
    [self.tableView reloadData];
}

- (NSMutableArray *)datasource
{
    if (_datasource == nil) {
        self.datasource = [NSMutableArray array];
    }
    return _datasource;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFTestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[YFTestCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.delegate = self;
    }
    
    YFTestModel *model = [self.datasource objectAtIndex:indexPath.row];
    [cell configCellWithModel:model indexPath:indexPath];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFTestModel *model = [self.datasource objectAtIndex:indexPath.row];
    
    CGFloat h = [YFTestCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
        YFTestCell *cell = (YFTestCell *)sourceCell;
        [cell configCellWithModel:model indexPath:indexPath];
    }cache:^NSDictionary *{
        NSDictionary *cache = @{kHYBCacheUniqueKey : model.uid,
                                kHYBCacheStateKey : @"",
                                kHYBRecalculateForStateKey : @(model.shouldUpdateCache)};
        model.shouldUpdateCache = NO;
        return cache;
    }];
    return h;
}

#pragma mark - YFTestCellDelegate
-(void)reloadCellHeightForModel:(YFTestModel *)model atIndexPath:(NSIndexPath *)indexPath {
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

@end


















