//
//  MyFavouriteViewController.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MyFavouriteViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyFavouriteViewController : BaseViewController <MyFavouriteViewModel *>

@property (strong, nonatomic) UITabBarController *tabBarController;

@end

NS_ASSUME_NONNULL_END
