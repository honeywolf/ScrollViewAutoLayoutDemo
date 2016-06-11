//
//  YDXTestCell.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/11.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "YFTestCell.h"
#import "YFTestModel.h"
#import "Masonry.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"
#import "CommentCell.h"
#import "CommentModel.h"

@interface YFTestCell ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) YFTestModel *testModel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YFTestCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _headImageView = [[UIImageView alloc]init];
        _headImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(10);
            make.width.height.mas_equalTo(80);
        }];
        
        // title
        _titleLabel = [UILabel new];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.preferredMaxLayoutWidth = screenWidth - 110;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
        __weak __typeof(self) weakSelf = self;
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(weakSelf.headImageView.mas_right).offset(10);
            make.top.mas_equalTo(weakSelf.headImageView);
            make.right.mas_equalTo(-10);
        }];
        
        //desc
        _descLabel = [UILabel new];
        [self.contentView addSubview:_descLabel];
        _descLabel.preferredMaxLayoutWidth = screenWidth - 110;
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:13];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_titleLabel);
            make.top.mas_equalTo(_titleLabel.mas_bottom).offset(10);
        }];
        
        self.tableView = [[UITableView alloc]init];
        self.tableView.scrollEnabled = NO;
        [self.contentView addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_descLabel);
            make.top.mas_equalTo(_descLabel.mas_bottom).offset(10);
            make.right.mas_equalTo(-10);
        }];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.hyb_lastViewInCell = self.tableView;
        self.hyb_bottomOffsetToCell = 10;
        
    }
    return self;
}

- (void)configCellWithModel:(YFTestModel *)model indexPath:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    _headImageView.image = [UIImage imageNamed:model.headImage];
    
    _testModel = model;
    CGFloat tableViewHeight = 0;
    for (CommentModel *commentMoel in model.commentModels) {
        CGFloat cellHeight = [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
            CommentCell *cell = (CommentCell *)sourceCell;
            [cell configCellWithModel:commentMoel];
        } cache:^NSDictionary *{
            return @{kHYBCacheUniqueKey : commentMoel.cid,
                     kHYBCacheStateKey: @"",
                     kHYBRecalculateForStateKey: @(NO)};
        }];
        tableViewHeight += cellHeight;
    }
    
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight);
    }];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[CommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    CommentModel *model = [self.testModel.commentModels objectAtIndex:indexPath.row];
    [cell configCellWithModel:model];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.testModel.commentModels.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentModel *model = [self.testModel.commentModels objectAtIndex:indexPath.row];
    
    return [CommentCell hyb_heightForTableView:self.tableView config:^(UITableViewCell *sourceCell) {
        CommentCell *cell = (CommentCell*)sourceCell;
        [cell configCellWithModel:model];
    } cache:^NSDictionary *{
        return @{kHYBCacheUniqueKey : model.cid,
                 kHYBCacheStateKey : @"",
                 kHYBRecalculateForStateKey : @(NO)};
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 添加一条数据
    CommentModel *model = [[CommentModel alloc]init];
    model.name = @"毅凡";
    model.reply = @"亦凡的技术博客";
    model.comment = @"哈哈，我被点击后自动添加了一条数据的，不要在意我~";
    model.cid = [NSString stringWithFormat:@"commentModel%ld", self.testModel.commentModels.count + 1];
    [self.testModel.commentModels addObject:model];
    
    if ([self.delegate respondsToSelector:@selector(reloadCellHeightForModel:atIndexPath:)]) {
        self.testModel.shouldUpdateCache = YES;
        [self.delegate reloadCellHeightForModel:self.testModel atIndexPath:self.indexPath];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.testModel.commentModels removeObjectAtIndex:indexPath.row];
        
        if ([self.delegate respondsToSelector:@selector(reloadCellHeightForModel:atIndexPath:)]) {
            self.testModel.shouldUpdateCache = YES;
            [self.delegate reloadCellHeightForModel:self.testModel atIndexPath:self.indexPath];
        }
    }
}

@end





















