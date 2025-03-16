//
//  MovieInfoCell.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "MovieInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieInfoCell : UITableViewCell

- (void)bindViewModel:(MovieInfoModel *)Model;

@end

NS_ASSUME_NONNULL_END
