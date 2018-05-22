//
//  ZDWaterCell.m
//  FirstProjectInGitHub
//
//  Created by zd on 2018/5/17.
//  Copyright © 2018年 zd. All rights reserved.
//

#import "ZDWaterCell.h"
#import "ZDModel.h"

@interface ZDWaterCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation ZDWaterCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor darkGrayColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setModel:(ZDModel *)model{
    _model = model;
    self.iconView.image = [UIImage imageNamed:model.imageName];
    self.titleLabel.text = model.title;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-20);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height-20, self.frame.size.width, 20);
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}
@end
