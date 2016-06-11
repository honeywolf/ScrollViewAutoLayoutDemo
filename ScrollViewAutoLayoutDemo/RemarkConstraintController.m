//
//  RemarkConstraintController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/7.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "RemarkConstraintController.h"
#import "Masonry.h"
#import "RemarkView.h"

@interface RemarkConstraintController ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) BOOL isExpanded;

@end

@implementation RemarkConstraintController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.view = [[RemarkView alloc] init];
   
//    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
//    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
//    self.growingButton.layer.borderWidth = 3;
//    self.growingButton.backgroundColor = [UIColor redColor];
//    [self.growingButton addTarget:self action:@selector(onGrowButtonTaped:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.growingButton];
//    self.isExpanded = NO;
//    
//    [_growingButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(64);
//        make.left.right.mas_equalTo(0);
//        if (self.isExpanded) {
//            make.bottom.mas_equalTo(0);
//        } else {
//            make.bottom.mas_equalTo(-350);
//        }
//    }];
}


//-(void)updateViewConstraints
//{
//    // 注意：这里是remake
//    // 这里使用update是一样的
//    // remark 会将之前的全部移除，然后重新添加
//    [_growingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(64);
//        make.left.right.mas_equalTo(0);
//        if (self.isExpanded) {
//            make.bottom.mas_equalTo(0);
//        } else {
//            make.bottom.mas_equalTo(-350);
//        }
//    }];
//    
//    [super updateViewConstraints];
//}
//
//- (void)onGrowButtonTaped:(UIButton *)button
//{
//    self.isExpanded = !self.isExpanded;
//    if (!self.isExpanded) {
//        [self.growingButton setTitle:@"点我展开" forState:UIControlStateNormal];
//    } else  {
//        [self.growingButton setTitle:@"点我收起" forState:UIControlStateNormal];
//    }
//    
//    // 告诉self.view有constraints需要更新
//    [self.view setNeedsUpdateConstraints];
//    
//    // 检测 self.view 是否需要更新约束。如若需要则更新，下面添加的动画效果才会生效
//    [self.view updateConstraintsIfNeeded];
//    
//    [UIView animateWithDuration:0.25 animations:^{
//        [self.view layoutIfNeeded];
//    }];
//}

@end
