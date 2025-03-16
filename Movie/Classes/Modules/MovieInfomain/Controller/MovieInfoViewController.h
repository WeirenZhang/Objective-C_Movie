//
//  MovieInfoViewController.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MovieInfoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieInfoViewController : BaseViewController <MovieInfoViewModel *>

@property (strong, nonatomic) UITableView *listTableView;

@end

NS_ASSUME_NONNULL_END
