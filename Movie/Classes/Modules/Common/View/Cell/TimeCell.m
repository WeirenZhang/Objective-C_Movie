//
//  TimeCell.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TimeCell.h"

@interface TimeCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TimeCell

- (void)ht_cellLoad {
    
    [self.contentView addSubview:self.titleLabel];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(TimeModel *)viewModel {
    
    self.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue: 247/255.0 alpha:1.0];
    self.titleLabel.text = viewModel.time;
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    //self.backgroundColor = [UIColor whiteColor];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([self.style containsString:@"Movie"]) {
            make.width.equalTo(@((SCREEN_WIDTH - 50)/3));
        } else {
            make.width.equalTo(@((SCREEN_WIDTH - 150)/2));
        }
        make.height.equalTo(@30);
    }];
}

#pragma mark - Getter
- (UILabel *)titleLabel {
    return HT_LAZY(_titleLabel, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(16);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    }));
}

@end
