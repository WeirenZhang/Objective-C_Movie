//
//  HomeCollectionViewCell.m
//  Movie
//
//  Created by User on 2024/11/10.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell ()

@property (strong, nonatomic) UIImageView *iconView;

@property (strong, nonatomic) UILabel *titleLabel;

@end


@implementation HomeCollectionViewCell

- (void)ht_cellLoad {
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.titleLabel];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(HomeModel *)viewModel {
    
    self.iconView.image = [UIImage imageNamed:viewModel.icon];
    self.titleLabel.text = viewModel.title;
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    //self.backgroundColor = [UIColor blueColor];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(10);
        make.left.right.equalTo(self.contentView);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.iconView.mas_bottom).offset(5);
    }];
}

#pragma mark - Getter
- (UIImageView *)iconView {
    return HT_LAZY(_iconView, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        //view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFit;
        view;
    }));
}
- (UILabel *)titleLabel {
    return HT_LAZY(_titleLabel, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(14);
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    }));
}

@end
