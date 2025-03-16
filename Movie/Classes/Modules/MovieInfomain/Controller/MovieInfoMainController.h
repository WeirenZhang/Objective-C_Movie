//
//  MovieInfoMainController.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MovieInfoMainViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieInfoMainController : BaseViewController <MovieInfoMainViewModel *>

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

NS_ASSUME_NONNULL_END
