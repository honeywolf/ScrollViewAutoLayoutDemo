//
//  ScrollViewComplexController.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/8.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "ScrollViewComplexController.h"
#import "Masonry.h"

@interface ScrollViewComplexController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSMutableArray *expandStates;

@end

@implementation ScrollViewComplexController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.pagingEnabled = NO;
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    UILabel *lastLabel = nil;
    for (NSUInteger i = 0; i < 10; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.numberOfLines = 0;
        label.layer.borderColor = [UIColor orangeColor].CGColor;
        label.layer.borderWidth = 2;
        label.text = [self randomText];
        label.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
        [label addGestureRecognizer:tap];
        
        
        // We must preferredMaxLayoutWidth property for adapting to iOS6.0
        label.preferredMaxLayoutWidth = screenWidth - 30;
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [self randomColor];
        [self.scrollView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(self.view).offset(-15);
            
            if (lastLabel) {
                make.top.mas_equalTo(lastLabel.mas_bottom).offset(20);
            } else {
                make.top.mas_equalTo(self.scrollView).offset(20);
            }
            
            make.height.mas_equalTo(40); // 刚开始固定高度
        }];
        
        lastLabel = label;
        
        [self.expandStates addObject:[@[label, @(NO)] mutableCopy]];
    }
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
        
        // 让scrollView的contentSize随着内容的增加而变化
        make.bottom.mas_equalTo(lastLabel.mas_bottom).offset(20);
    }];
}

- (NSMutableArray *)expandStates
{
    if (_expandStates == nil) {
        self.expandStates = [NSMutableArray array];
    }
    return _expandStates;
}

-(void)onTap:(UITapGestureRecognizer *)sender
{
    UIView *tapView = sender.view;
    
    NSUInteger index = 0;
    for (NSMutableArray *array in self.expandStates) {
        UILabel *view = [array firstObject];
        if (view == tapView) {
            // 根据状态位来设置label高度, YES时：内容高度，No时：40
            
            // 取出前一个 preView 和 nextView
            UIView *preView = nil;
            UIView *nextView = nil;
            if (index - 1 < self.expandStates.count  && index >= 1) {
                preView = [self.expandStates[index - 1] firstObject];
            }
            if (index + 1 < self.expandStates.count ) {
                nextView = [self.expandStates[index + 1] firstObject];
            }
            
            // 跟新约束
            NSNumber *status = array.lastObject;
            if (status.boolValue == YES) {
                [tapView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(@(40));
                }];
            } else {
                [tapView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(15);
                    make.right.mas_equalTo(self.view).offset(-15);
                    if (preView) {
                        make.top.mas_equalTo(preView.mas_bottom).offset(20);
                    } else {
                        make.top.mas_equalTo(20);
                    }
                }];
                
                if (nextView) {
                    [nextView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.top.mas_equalTo(tapView.mas_bottom).offset(20);
                    }];
                }
            }
            
            // 更新状态位
            status = @(!status.boolValue);
            [array replaceObjectAtIndex:1 withObject:status];
            
            
            // 动画
            [self.view setNeedsUpdateConstraints];
            [self.view updateConstraintsIfNeeded];
            [UIView animateWithDuration:1.5 animations:^{
                [self.view layoutIfNeeded];
            }];
            
            // 找到tapView后跳出循环
            break;
        }
        index++;
    }
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (NSString *)randomText {
    CGFloat length = arc4random() % 150 + 5;
    
    NSMutableString *str = [[NSMutableString alloc] init];
    for (NSUInteger i = 0; i < length; ++i) {
        [str appendString:@"测试数据很长，"];
    }
    
    return str;
}

//        if (view == tapView) {
//            NSNumber *state = [array lastObject];
//
//            if ([state boolValue] == YES) {
//                [view mas_updateConstraints:^(MASConstraintMaker *make) {
//                    make.height.mas_equalTo(40);
//                }];
//            } else {
//                UIView *preView = nil;
//                UIView *nextView = nil;
//
//                if (index - 1 < self.expandStates.count && index >= 1) {
//                    preView = [[self.expandStates objectAtIndex:index-1] firstObject];
//                }
//
//                if (index + 1 < self.expandStates.count) {
//                    nextView = [[self.expandStates objectAtIndex:index+1] firstObject];
//                }
//
//                [view mas_remakeConstraints:^(MASConstraintMaker *make) {
//                    if (preView) {
//                        make.top.mas_equalTo(preView.mas_bottom).offset(20);
//                    } else {
//                        make.top.mas_equalTo(20);
//                    }
//
//                    make.left.mas_equalTo(15);
//                    make.right.mas_equalTo(self.view).offset(-15);
//                }];
//
//                if (nextView) {
//                    [nextView mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.top.mas_equalTo(view.mas_bottom).offset(20);
//                    }];
//                }
//            }
//
//            // 改变 标识 位
//            [array replaceObjectAtIndex:1 withObject:@(!state.boolValue)];
//
//            [self.view setNeedsUpdateConstraints];
//            [self.view updateConstraintsIfNeeded];
//
//            [UIView animateWithDuration:0.25 animations:^{
//                [self.view layoutIfNeeded];
//            } ];
//            break;
//
//        }


@end



















