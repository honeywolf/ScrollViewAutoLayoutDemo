//
//  CompositeController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/8.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "CompositeController.h"
#import "Masonry.h"

#define total_number 6

@interface CompositeController ()

@property (nonatomic, strong) NSMutableArray *viewArray;
@property (nonatomic, assign) BOOL isNormal;

@end

@implementation CompositeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *lastView = self.view;
    for (int i= 0; i < total_number; i++) {
        UIView *view = UIView.new;
        view.backgroundColor = [self randomColor];
        view.layer.borderColor = UIColor.blackColor.CGColor;
        view.layer.borderWidth = 2;
        [self.view addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
        }];
        
        lastView = view;
        [self.viewArray addObject:view];
        
        // 手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap)];
        [view addGestureRecognizer:tap];
        self.isNormal = YES;
    }
}

- (void)updateViewConstraints
{
    UIView *lastView = self.view;
    
    if (self.isNormal) {
        for (NSInteger i = self.viewArray.count - 1; i >= 0; i--) {
            UIView *itemView = self.viewArray [i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    } else {
        for (NSInteger i = 0; i < self.viewArray.count; ++i) {
            UIView *itemView = [self.viewArray objectAtIndex:i];
            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
            }];
            
            [self.view bringSubviewToFront:itemView];
            lastView = itemView;
        }
    }

    [super updateViewConstraints];
}



- (void)onTap
{
//    UIView *lastView = self.view;
//    
//    if (self.isNormal) {
//        for (NSInteger i = self.viewArray.count - 1; i >= 0; i--) {
//            UIView *itemView = self.viewArray [i];
//            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
//            }];
//            
//            [self.view bringSubviewToFront:itemView];
//            lastView = itemView;
//        }
//    } else {
//        for (NSInteger i = 0; i < self.viewArray.count; ++i) {
//            UIView *itemView = [self.viewArray objectAtIndex:i];
//            [itemView mas_remakeConstraints:^(MASConstraintMaker *make) {
//                make.edges.equalTo(lastView).insets(UIEdgeInsetsMake(20, 20, 20, 20));
//            }];
//            
//            [self.view bringSubviewToFront:itemView];
//            lastView = itemView;
//        }
//    }
    
    [self.view setNeedsUpdateConstraints];
    [self.view updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.isNormal = !self.isNormal;
    }];
}

- (NSMutableArray *)viewArray
{
    if (_viewArray == nil) {
        self.viewArray = [NSMutableArray array];
    }
    return _viewArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end



















