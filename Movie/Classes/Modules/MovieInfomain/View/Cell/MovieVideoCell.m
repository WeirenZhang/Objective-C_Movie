//
//  MovieVideoCell.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieVideoCell.h"
#import "VideoModel.h"

@interface MovieVideoCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation MovieVideoCell

- (void)ht_cellLoad {
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(VideoModel *)Model {

    [self.iconView sd_setImageWithURL:[NSURL URLWithString:Model.cover] placeholderImage:Nil];
    self.titleLabel.text = Model.title;
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 0));
        make.width.equalTo(@100);
        make.height.equalTo(@75);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.iconView);
    }];
}

#pragma mark - Getter
- (UIImageView *)iconView {
    return HT_LAZY(_iconView, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        //view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view;
    }));
}
- (UILabel *)titleLabel {
    return HT_LAZY(_titleLabel, ({
        UILabel *label = [UILabel new];
        //label.font = textFontPingFangMediumFont(17);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 3;
        label;
    }));
}

@end
