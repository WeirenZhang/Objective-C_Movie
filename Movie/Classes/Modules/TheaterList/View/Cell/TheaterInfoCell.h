//
//  TheaterInfoCell.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "TheaterInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterInfoCell : UITableViewCell

- (void)bindViewModel:(TheaterInfoModel *)Model;

@property (nonatomic, strong) NSString *style;

@property (strong, nonatomic) UIButton *discard;

@end

NS_ASSUME_NONNULL_END
