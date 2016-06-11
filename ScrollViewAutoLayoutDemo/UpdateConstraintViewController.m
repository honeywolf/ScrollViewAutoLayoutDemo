//
//  UpdateConstraint.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/7.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "UpdateConstraintViewController.h"
#import "Masonry.h"

@interface UpdateConstraintViewController ()

@property (nonatomic, strong) UIButton *growingButton;
@property (nonatomic, assign) CGFloat scacle;

@end

@implementation UpdateConstraintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.growingButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.growingButton setTitle:@"Grow Me!" forState:UIControlStateNormal];
    self.growingButton.layer.borderColor = UIColor.greenColor.CGColor;
    self.growingButton.layer.borderWidth = 3;
    
    [self.growingButton addTarget:self action:@selector(didTapGrowButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.growingButton];
    
    self.scacle = 1.0;
    
    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scacle).priorityLow();
        // 最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
    }];
    
}

#pragma mark - updateViewConstraints

-(void)updateViewConstraints
{
    [self.growingButton mas_updateConstraints:^(MASConstraintMaker *make) {
        // 初始宽、高为100，优先级最低
        make.width.height.mas_equalTo(100 * self.scacle).priorityLow();
        // 最大放大到整个view
        make.width.height.lessThanOrEqualTo(self.view);
    }];
    
    [super updateViewConstraints];
}

- (void)didTapGrowButton:(UIButton *)button
{
    self.scacle += 0.5;
    
    // tell constraints they need updating
    [self.view setNeedsUpdateConstraints];
    
    // 当自定义view的一个属性即将改变并且会影响到 constraints 的时候,你可以调用
    // 这个方法来揭示 constraints 在未来的某个时刻会更新。
    [self.view setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
