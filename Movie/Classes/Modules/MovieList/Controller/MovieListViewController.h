//
//  MovieListViewController.h
//  Movie
//
//  Created by User on 2024/11/10.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MovieListViewModel.h"
#import "MovieListViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieListViewController : BaseViewController <MovieListViewModel *>

@end

NS_ASSUME_NONNULL_END
