//
//  BaseuseViewController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/7.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "BaseuseViewController.h"
#import "Masonry.h"

@interface BaseuseViewController ()

@end

@implementation BaseuseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *greenView = [UIView new];
    greenView.backgroundColor = [UIColor greenColor];
    greenView.layer.borderColor = [UIColor blackColor].CGColor;
    greenView.layer.borderWidth = 1;
    [self.view addSubview:greenView];
    
    
    UIView *redView = [UIView new];
    redView.backgroundColor = [UIColor redColor];
    redView.layer.borderColor = [UIColor blackColor].CGColor;
    redView.layer.borderWidth = 1;
    [self.view addSubview:redView];
    
    UIView *blueView = [UIView new];
    blueView.backgroundColor = [UIColor orangeColor];
    blueView.layer.borderColor = [UIColor blackColor].CGColor;
    blueView.layer.borderWidth = 1;
    [self.view addSubview:blueView];
    
#pragma mark - 添加约束
    
    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(74);
        make.right.mas_equalTo(redView.mas_left).offset(-10);
    
    }];
    
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.width.bottom.mas_equalTo(greenView);
        make.right.mas_equalTo(-10);
        
    }];
    
    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(greenView.mas_bottom).offset(10);
        make.bottom.right.mas_equalTo(-10);
        make.height.mas_equalTo(greenView.mas_height);
        make.left.mas_equalTo(10);
    }];
    
//    CGFloat padding = 10;
//    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(padding);
//        make.top.mas_equalTo(padding + 64);
//        make.right.mas_equalTo(redView.mas_left).offset(-padding);
//        // 三个控件等高
//        make.height.mas_equalTo(@[redView, blueView]);
//        // 两个控件等宽
//        make.width.mas_equalTo(redView);
//    }];
//    
//    [redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-padding);
//        make.top.mas_equalTo(greenView);
//    }];
//    
//    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(greenView.mas_bottom).offset(padding);
//        make.bottom.right.mas_equalTo(-padding);
//        make.left.mas_equalTo(padding);
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
