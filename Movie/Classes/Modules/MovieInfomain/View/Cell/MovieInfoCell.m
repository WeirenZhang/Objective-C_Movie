//
//  MovieInfoCell.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieInfoCell.h"
#import "MovieInfoModel.h"

@interface MovieInfoCell ()

@property (strong, nonatomic) UIImageView *movie_intro_foto;

@property (strong, nonatomic) UILabel *_h1_h3;

@property (strong, nonatomic) UILabel *h1;

@property (strong, nonatomic) UILabel *h3;

@property (strong, nonatomic) UILabel *_icon;

@property (strong, nonatomic) UIImageView *icon;

@property (strong, nonatomic) UILabel *_release_movie_time;

@property (strong, nonatomic) UILabel *release_movie_time;

@property (strong, nonatomic) UILabel *_length;

@property (strong, nonatomic) UILabel *length;

@property (strong, nonatomic) UILabel *_director;

@property (strong, nonatomic) UILabel *director;

@property (strong, nonatomic) UILabel *_actor;

@property (strong, nonatomic) UILabel *actor;

@end

@implementation MovieInfoCell

- (void)ht_cellLoad {
    [self.contentView addSubview:self.movie_intro_foto];
    [self.contentView addSubview:self._h1_h3];
    [self.contentView addSubview:self.h1];
    [self.contentView addSubview:self.h3];
    [self.contentView addSubview:self._icon];
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self._release_movie_time];
    [self.contentView addSubview:self.release_movie_time];
    [self.contentView addSubview:self._length];
    [self.contentView addSubview:self.length];
    [self.contentView addSubview:self._director];
    [self.contentView addSubview:self.director];
    [self.contentView addSubview:self._actor];
    [self.contentView addSubview:self.actor];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(MovieInfoModel *)Model {
    
    [self.movie_intro_foto sd_setImageWithURL:[NSURL URLWithString:Model.movie_intro_foto] placeholderImage:Nil];
    self._h1_h3.text = @"電影名稱";
    self.h1.text = Model.h1;
    self.h3.text = Model.h3;
    self._icon.text = @"電影分級";
    [self.icon sd_setImageWithURL:[NSURL URLWithString:Model.icon] placeholderImage:Nil];
    self._release_movie_time.text = @"上映日期";
    self.release_movie_time.text = Model.release_movie_time;
    self._length.text = @"電影長度";
    self.length.text = Model.length;
    self._director.text = @"導演";
    self.director.text = Model.director;
    self._actor.text = @"演員";
    self.actor.text = Model.actor;
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    self.backgroundColor = [UIColor whiteColor];
    [self.movie_intro_foto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
        make.width.equalTo(@(SCREEN_WIDTH));
        make.height.equalTo(@((SCREEN_WIDTH * 167)/100));
    }];
    [self._h1_h3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.movie_intro_foto.mas_bottom).offset(0);
    }];
    [self.h1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self._h1_h3.mas_bottom).offset(10);
    }];
    [self.h3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.top.equalTo(self.h1.mas_bottom).offset(10);
    }];
    [self._icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.h3.mas_bottom).offset(10);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.width.equalTo(@50);
        make.height.equalTo(@53);
        make.top.equalTo(self._icon.mas_bottom).offset(10);
    }];
    [self._release_movie_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.icon.mas_bottom).offset(10);
    }];
    [self.release_movie_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self._release_movie_time.mas_bottom).offset(10);
    }];
    [self._length mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.release_movie_time.mas_bottom).offset(10);
    }];
    [self.length mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self._length.mas_bottom).offset(10);
    }];
    [self._director mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.length.mas_bottom).offset(10);
    }];
    [self.director mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self._director.mas_bottom).offset(10);
    }];
    [self._actor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.director.mas_bottom).offset(10);
    }];
    [self.actor mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(UIEdgeInsetsMake(0, 10, 10, 0));
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self._actor.mas_bottom).offset(10);
    }];
}

#pragma mark - Getter
- (UIImageView *)movie_intro_foto {
    return HT_LAZY(_movie_intro_foto, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        //view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view;
    }));
}
- (UILabel *)_h1_h3 {
    return HT_LAZY(__h1_h3, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor blackColor];
        label;
    }));
}
- (UILabel *)h1 {
    return HT_LAZY(_h1, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)h3 {
    return HT_LAZY(_h3, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)_icon {
    return HT_LAZY(__icon, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UIImageView *)icon {
    return HT_LAZY(_icon, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        //view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view;
    }));
}
- (UILabel *)_release_movie_time {
    return HT_LAZY(__release_movie_time, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)release_movie_time {
    return HT_LAZY(_release_movie_time, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)_length {
    return HT_LAZY(__length, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)length {
    return HT_LAZY(_length, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)_director {
    return HT_LAZY(__director, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)director {
    return HT_LAZY(_director, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)_actor {
    return HT_LAZY(__actor, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor whiteColor];
        label.backgroundColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)actor {
    return HT_LAZY(_actor, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}

@end
