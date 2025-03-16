//
//  MovieTimeTabsViewControlle.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MovieTimeTabsViewModel.h"
#import "JXCategoryView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeTabsViewControlle : BaseViewController <MovieTimeTabsViewModel *>

@property (nonatomic, strong) JXCategoryTitleView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

@end

NS_ASSUME_NONNULL_END
