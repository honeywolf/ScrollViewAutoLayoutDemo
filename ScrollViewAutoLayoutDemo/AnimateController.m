//
//  AnimateController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/7.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "AnimateController.h"
#import "Masonry/Masonry.h"

@interface AnimateController ()

@property (nonatomic, strong) UIView *purpleView;
@property (nonatomic, strong) UIView *orangeView;
@property (nonatomic, assign) BOOL isExpaned;

@end

@implementation AnimateController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *purpleView = [[UIView alloc] init];
    purpleView.backgroundColor = UIColor.purpleColor;
    purpleView.layer.borderColor = UIColor.blackColor.CGColor;
    purpleView.layer.borderWidth = 2;
    [self.view addSubview:purpleView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)
                                   ];
    [purpleView addGestureRecognizer:tap];
    self.purpleView = purpleView;
    
    UIView *orangeView = UIView.new;
    orangeView.backgroundColor = UIColor.orangeColor;
    orangeView.layer.borderColor = UIColor.blackColor.CGColor;
    orangeView.layer.borderWidth = 2;
    [self.view addSubview:orangeView];
    self.orangeView = orangeView;
    
    // 这里，我们不使用updateViewConstraints方法，但是我们一样可以做到。
    // 不过苹果推荐在updateViewConstraints方法中更新或者添加约束的
//    [self updateWithExpand:NO animated:NO];
    
    
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击purple部分放大，orange部分最大值250，最小值90";
    [self.purpleView addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
}
-(void)updateViewConstraints
{
    [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(84);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        if (self.isExpaned) {
            make.bottom.mas_equalTo(-20);
        } else {
            make.bottom.mas_equalTo(-300);
        }
    }];
    
    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.purpleView);
        
        // 这里使用优先级处理
        // 设置其最大值为250，最小值为90
        if (!self.isExpaned) {
            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
        } else {
            make.width.height.mas_equalTo(100 * 3).priorityLow();
        }
        
        // 最大值为250
        make.width.height.lessThanOrEqualTo(@250);
        
        // 最小值为90
        make.width.height.greaterThanOrEqualTo(@90);
    }];
    [super updateViewConstraints];
}

- (void)onTap {
    //    [self updateWithExpand:!self.isExpaned animated:YES];
    self.isExpaned = !self.isExpaned;
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

//- (void)updateWithExpand:(BOOL)isExpanded animated:(BOOL)animated {
//    self.isExpaned = isExpanded;
//    
//    [self.purpleView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(84);
//        make.left.mas_equalTo(20);
//        make.right.mas_equalTo(-20);
//        if (isExpanded) {
//            make.bottom.mas_equalTo(-20);
//        } else {
//            make.bottom.mas_equalTo(-300);
//        }
//    }];
//    
//    [self.orangeView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self.purpleView);
//        
//        // 这里使用优先级处理
//        // 设置其最大值为250，最小值为90
//        if (!isExpanded) {
//            make.width.height.mas_equalTo(100 * 0.5).priorityLow();
//        } else {
//            make.width.height.mas_equalTo(100 * 3).priorityLow();
//        }
//        
//        // 最大值为250
//        make.width.height.lessThanOrEqualTo(@250);
//        
//        // 最小值为90
//        make.width.height.greaterThanOrEqualTo(@90);
//    }];
//    
//    if (animated) {
//        [self.view setNeedsUpdateConstraints];
//        [self.view updateConstraintsIfNeeded];
//        
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.view layoutIfNeeded];
//        } completion:^(BOOL finished) {
//            NSLog(@"%@",  NSStringFromCGSize( _orangeView.bounds.size));
//        } ];
//    }
//    
//}
//


@end
