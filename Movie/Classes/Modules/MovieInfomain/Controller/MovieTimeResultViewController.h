//
//  MovieTimeResultViewController.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "MovieTimeResultViewModel.h"
#import "JXCategoryListContainerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeResultViewController : BaseViewController <MovieTimeResultViewModel *> <JXCategoryListContentViewDelegate>

@end

NS_ASSUME_NONNULL_END
