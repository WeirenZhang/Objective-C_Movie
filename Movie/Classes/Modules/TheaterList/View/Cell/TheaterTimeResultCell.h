//
//  TheaterTimeResultCell.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "TheaterDateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterTimeResultCell : UITableViewCell

- (void)bindViewModel:(TheaterTimeResultModel *)Model;

@end

NS_ASSUME_NONNULL_END
