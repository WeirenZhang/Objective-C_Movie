//
//  TheaterInfoCell.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterInfoCell.h"

@interface TheaterInfoCell ()

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) UILabel *adds;

@property (strong, nonatomic) UILabel *tel;

@end

@implementation TheaterInfoCell

- (void)ht_cellLoad {
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.adds];
    [self.contentView addSubview:self.tel];
    [self.contentView addSubview:self.discard];
    self.discard.hidden = YES;
    [self layoutItemSubviews];
}

- (void)bindViewModel:(TheaterInfoModel *)Model {
    
    self.name.text = Model.name;
    self.adds.text = Model.adds;
    self.tel.text = Model.tel;
    if ([self.style containsString:@"MyFavourite"]) {
        self.discard.hidden = NO;
    }
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    [self.adds mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.name.mas_bottom).offset(10);
    }];
    [self.tel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.adds.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    [self.discard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@96);
        make.height.equalTo(@96);
        make.right.equalTo(self.contentView.mas_right).offset(10);
        make.centerY.equalTo(self.contentView);
    }];
}

#pragma mark - Getter
- (UILabel *)name {
    return HT_LAZY(_name, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(20);
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)adds {
    return HT_LAZY(_adds, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(14);
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)tel {
    return HT_LAZY(_tel, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(14);
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UIButton *)discard{
    return HT_LAZY(_discard, ({
        UIButton *button = [UIButton new];
        [button setImage:[UIImage systemImageNamed:@"trash"] forState:UIControlStateNormal];
        button;
    }));
}

@end
