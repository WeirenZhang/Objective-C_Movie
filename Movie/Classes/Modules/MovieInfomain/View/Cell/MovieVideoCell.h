//
//  MovieVideoCell.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieVideoCell : UITableViewCell

- (void)bindViewModel:(VideoModel *)Model;

@end

NS_ASSUME_NONNULL_END
