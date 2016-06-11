//
//  TestCell.h
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/8.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TestModel.h"

typedef void(^TestBlock)(NSIndexPath *indexPath);

@interface TestCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) TestBlock block;

- (void)configCellWithModel:(TestModel *)model;

+ (CGFloat)heightWithModel:(TestModel *)model;

@end

























