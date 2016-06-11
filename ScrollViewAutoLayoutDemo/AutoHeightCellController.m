//
//  AutoHeightCellController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/10.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "AutoHeightCellController.h"
#import "AutoHeightCell.h"
#import "AutoHeightModel.h"
#import "UITableView+HYBCacheHeight.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

@interface AutoHeightCellController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AutoHeightCellController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        self.dataSource = [[NSMutableArray alloc]init];
        
        int titleTotalLength = (int)[[self titleAll] length];
        int descTotalLength = (int)[[self descAll] length];
        
        for (NSUInteger i = 0; i < 40; i++) {
            int titleLength = rand() % titleTotalLength + 15;
            if (titleLength > titleTotalLength - 1) {
                titleLength = titleTotalLength;
            }
            
            AutoHeightModel *model = [[AutoHeightModel alloc]init];
            model.title = [[self titleAll] substringToIndex:titleLength];
            model.uid = (int)i + 1;
            model.isExpand = YES;
            
            int descLength = rand() % descTotalLength + 20;
            if (descLength > descTotalLength - 1) {
                descLength = descTotalLength;
            }
            model.desc = [[self descAll] substringToIndex:descLength];
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

- (NSString *)titleAll {
    return @"欢迎使用HYBMasonryAutoCellHeight扩展，由作者huangyibiao提供，如有任何疑问，请给作者发email：huangyibiao520@163.com，谢谢您的支持！！！";
}

- (NSString *)descAll {
    return @"HYBMasonryAutoCellHeight是基于Masonry第三方开源库而实现的，如想更深入了解Masonry，可直接到github上的官方文档阅读，或可以到作者的博客中阅读相关文章：http://www.hybblog.com/masonryjie-shao/，如果阅读时有疑问，可直接联系作者（email或者QQ），最直接的方式就是在文章后面留言，作者会在收到反馈后的第一时间迅速查看，并给予相应的回复。欢迎留言，希望我们能成为朋友。";
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    AutoHeightCell  *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[AutoHeightCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    AutoHeightModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = [self.dataSource objectAtIndex:indexPath.row];
    }
    [cell configCellWithModel:model];
    cell.expandBlock = ^(BOOL isExpand ) {
        model.isExpand = isExpand;
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AutoHeightModel *model = nil;
    if (indexPath.row < self.dataSource.count) {
        model = [self.dataSource objectAtIndex:indexPath.row];
    }
    
    NSString *stateKey = nil;
    if (model.isExpand) {
        stateKey = @"expanded";
    } else {
        stateKey = @"unexpanded";
    }
    
    return [AutoHeightCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        AutoHeightCell *cell = (AutoHeightCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey: [NSString stringWithFormat:@"%d", model.uid],
                 kHYBCacheStateKey : stateKey,
                 // 如果设置为YES，若有缓存，则更新缓存，否则计算并缓存
                 // 主要对社交这种有动态评论等不同状态，高度也会不同的情况进行处理
                 kHYBRecalculateForStateKey : @(NO)
                 };
    }];

}


@end

























