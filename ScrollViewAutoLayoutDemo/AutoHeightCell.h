//
//  AutoHeightCell.h
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/10.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutoHeightModel;

typedef void(^AutoHeightExpandBlock) (BOOL isExpand);

@interface AutoHeightCell : UITableViewCell

@property (nonatomic, copy) AutoHeightExpandBlock expandBlock;

-(void)configCellWithModel:(AutoHeightModel *)model;


@end
