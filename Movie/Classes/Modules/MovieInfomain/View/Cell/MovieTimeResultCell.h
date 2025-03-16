//
//  MovieTimeResultCell.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "MovieDateTabItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeResultCell : UITableViewCell

- (void)bindViewModel:(MovieTimeResultModel *)Model;

@end

NS_ASSUME_NONNULL_END
