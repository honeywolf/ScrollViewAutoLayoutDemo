//
//  CommentCell.h
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/11.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;
@interface CommentCell : UITableViewCell

- (void)configCellWithModel:(CommentModel *)model;

@end
