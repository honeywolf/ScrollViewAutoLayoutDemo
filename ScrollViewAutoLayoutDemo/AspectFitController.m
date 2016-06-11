//
//  AspectFitController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/8.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "AspectFitController.h"
#import "Masonry.h"

@interface AspectFitController ()
@property (nonatomic, strong) UIView *topInnerView;
@property (nonatomic, strong) UIView *bottomInnerView;

@end

@implementation AspectFitController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Create views
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor redColor];
    [self.view addSubview:topView];
    
    self.topInnerView = [[UIView alloc] init];
    _topInnerView.backgroundColor = [UIColor greenColor];
    [topView addSubview:_topInnerView];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:bottomView];
    
    self.bottomInnerView = [[UIView alloc] init];
    _bottomInnerView.backgroundColor = [UIColor blueColor];
    [bottomView addSubview:_bottomInnerView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(@(64));
        make.height.equalTo(bottomView);
    }];
    
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    
    // width/height 比为1/ 3.0，要求是同一个控件的属性比例
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
    [topView addGestureRecognizer:tap];
    [bottomView addGestureRecognizer:tap];
}

- (void)updateViewConstraints
{
    // width = height / 3
    [_topInnerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_topInnerView.superview);
        make.width.mas_equalTo(_topInnerView.mas_height).multipliedBy(3);
        make.centerY.mas_equalTo(_topInnerView.superview);
        
        //        // 设置优先级
        make.width.height.mas_equalTo(_topInnerView.superview).priorityLow();
        make.height.lessThanOrEqualTo(_topInnerView.superview);
    }];

    [_bottomInnerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_bottomInnerView.superview);
        make.center.mas_equalTo(_bottomInnerView.superview);
        
        // 注意：这个multipliedBy的使用只能是设置同一个控件的，比如这里的bottomInnerView; 设置高/宽 为3:1
        make.height.mas_equalTo(_bottomInnerView.mas_width).multipliedBy(3);
        make.width.height.mas_equalTo(_bottomInnerView.superview).priorityLow();
        make.width.height.lessThanOrEqualTo(_bottomInnerView.superview);
    }];
    
    [super updateViewConstraints];
}

-(void)onTap {
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}



@end
































