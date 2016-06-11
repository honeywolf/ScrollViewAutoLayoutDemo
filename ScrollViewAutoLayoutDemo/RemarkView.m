//
//  RemarkView.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/7.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "RemarkView.h"
#import "Masonry.h"

@interface RemarkView ()

@property (nonatomic, strong) UIButton *movingButton;
@property (nonatomic, assign) BOOL topLeft;

- (void)toggleButtonPosition;

@end

@implementation RemarkView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.movingButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.movingButton setTitle:@"Move Me!" forState:UIControlStateNormal];
        self.movingButton.layer.borderColor = UIColor.greenColor.CGColor;
        self.movingButton.layer.borderWidth = 3;
        
        [self.movingButton addTarget:self action:@selector(toggleButtonPosition) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.movingButton];
        
        self.topLeft = YES;
    }
    return self;
}

+(BOOL)requiresConstraintBasedLayout
{
    return YES;
}

// this is Apple's recommended palce for adding/ updating constraints

-(void)updateConstraints
{
    [_movingButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(100);
        if (self.topLeft) {
            make.left.mas_equalTo(self).offset(10);
            make.top.mas_equalTo(self).offset(74);
        } else {
            make.bottom.right.equalTo(self).with.offset(-10);
        }
    }];
    
    // according to apple super should be called at end of method
    [super updateConstraints];
}

- (void)toggleButtonPosition
{
    self.topLeft = !self.topLeft;
    
    // tell constraints they need updating
    [self setNeedsUpdateConstraints];
    
    // update constraints now so we can animate the change
    [self updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.4 animations:^{
        [self layoutIfNeeded];
    }];

}

@end





































