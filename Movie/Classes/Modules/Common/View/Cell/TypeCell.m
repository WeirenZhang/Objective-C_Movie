//
//  TypeCell.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TypeCell.h"
#import "TypeModel.h"

@interface TypeCell ()

@property (strong, nonatomic) UILabel *titleLabel;

@end

@implementation TypeCell

- (void)ht_cellLoad {
    
    [self.contentView addSubview:self.titleLabel];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(TypeModel *)viewModel {
    
    self.backgroundColor = [UIColor purpleColor];
    self.titleLabel.text = viewModel.type;
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    //self.backgroundColor = [UIColor blueColor];
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
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.numberOfLines = 0;
        label;
    }));
}

@end
