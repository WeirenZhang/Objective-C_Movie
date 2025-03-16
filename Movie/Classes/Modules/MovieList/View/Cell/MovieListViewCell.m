//
//  MovieListViewCell.m
//  Movie
//
//  Created by User on 2024/11/10.
//

#import "MovieListViewCell.h"

@interface MovieListViewCell ()

@property (strong, nonatomic) UIImageView *thumb;

@property (strong, nonatomic) UILabel *title;

@property (strong, nonatomic) UILabel *en;

@property (strong, nonatomic) UILabel *release_movie_time;

@end

@implementation MovieListViewCell

- (void)ht_cellLoad {
    [self.contentView addSubview:self.thumb];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.en];
    [self.contentView addSubview:self.release_movie_time];
    [self.contentView addSubview:self.discard];
    self.discard.hidden = YES;
    [self layoutItemSubviews];
}

- (void)bindViewModel:(MovieListModel *)Model {

    [self.thumb sd_setImageWithURL:[NSURL URLWithString:Model.thumb] placeholderImage:Nil];
    self.title.text = Model.title;
    self.en.text = Model.en;
    self.release_movie_time.text = Model.release_movie_time;
    if ([self.style containsString:@"MyFavourite"]) {
        self.discard.hidden = NO;
    }
}

- (void)ht_reloadCellData {
    
    MovieListViewModel *viewModel = self.ht_cellData;
    MovieListModel *Model = viewModel.listData[self.ht_indexPath.row];
    
    [self.thumb sd_setImageWithURL:[NSURL URLWithString:Model.thumb] placeholderImage:Nil];
    self.title.text = Model.title;
    self.en.text = Model.en;
    self.release_movie_time.text = Model.release_movie_time;
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self.thumb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 0));
        make.width.equalTo(@100);
        make.height.equalTo(@143);
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumb.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@30);
        make.top.equalTo(self.thumb);
    }];
    [self.en mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumb.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@20);
        make.top.equalTo(self.title.mas_bottom).offset(5);
    }];
    [self.release_movie_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thumb.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.equalTo(@30);
        make.bottom.equalTo(self.thumb);
    }];
    [self.discard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@96);
        make.height.equalTo(@96);
        make.right.equalTo(self.contentView.mas_right).offset(10);
        make.centerY.equalTo(self.thumb);
    }];
}

#pragma mark - Getter
- (UIImageView *)thumb {
    return HT_LAZY(_thumb, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        //view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view;
    }));
}
- (UILabel *)title {
    return HT_LAZY(_title, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(17);
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)en {
    return HT_LAZY(_en, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(17);
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)release_movie_time {
    return HT_LAZY(_release_movie_time, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(17);
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
