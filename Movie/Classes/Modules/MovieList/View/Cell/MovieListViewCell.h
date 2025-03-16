//
//  MovieListViewCell.h
//  Movie
//
//  Created by User on 2024/11/10.
//

#import <UIKit/UIKit.h>
#import "MovieListViewModel.h"
#import "MovieListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieListViewCell : UITableViewCell

- (void)bindViewModel:(MovieListModel *)Model;

@property (nonatomic, strong) NSString *style;

@property (strong, nonatomic) UIButton *discard;

@end

NS_ASSUME_NONNULL_END
