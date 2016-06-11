//
//  CommentCell.m
//  ScrollViewAutoLayoutDemo
//
//  Created by YDX on 16/6/11.
//  Copyright © 2016年 YDX. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "Masonry.h"
#import "UITableViewCell+HYBMasonryAutoCellHeight.h"

@interface CommentCell ()

@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation CommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentLabel = [[UILabel alloc]init];
        [self.contentView addSubview:self.contentLabel];
        self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 110;
        self.contentLabel.numberOfLines = 0;
        self.contentLabel.font = [UIFont systemFontOfSize:12];
        __weak __typeof(self) weakSelf = self;
        [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(weakSelf.contentView);
        }];
        
        self.hyb_lastViewInCell = _contentLabel;
    }
    return self;
}

-(void)configCellWithModel:(CommentModel *)model
{
    NSString *str = [NSString stringWithFormat:@"%@回复%@: %@", model.name, model.reply, model.comment];
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:str];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(0, model.name.length)];
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:NSMakeRange(model.name.length + 2, model.reply.length)];
    _contentLabel.attributedText = text;
}

@end

























