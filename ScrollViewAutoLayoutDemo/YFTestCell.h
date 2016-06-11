//
//  YDXTestCell.h
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/11.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YFTestModel;

@protocol YFTestCellDelegate <NSObject>

- (void)reloadCellHeightForModel:(YFTestModel *)model atIndexPath:(NSIndexPath *)indexPath;

@end

@interface YFTestCell : UITableViewCell

@property (nonatomic, weak) id<YFTestCellDelegate> delegate;
- (void)configCellWithModel:(YFTestModel *)model indexPath:(NSIndexPath *)indexPath;

@end



















