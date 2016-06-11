//
//  YFTestModel.h
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/10.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFTestModel : NSObject

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *headImage;

// 评论数据源
@property (nonatomic, strong) NSMutableArray *commentModels;

// 因为评论是动态的，因此要标识是否要更新缓存。增加和删除评论时，以识别是否需要重新计算行高并刷新对应的缓存高度
@property (nonatomic, assign) BOOL shouldUpdateCache;



@end
