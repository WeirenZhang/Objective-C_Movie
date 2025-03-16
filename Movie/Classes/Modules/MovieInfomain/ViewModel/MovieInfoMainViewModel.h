//
//  MovieInfoMainViewModel.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "MovieListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieInfoMainViewModel : BaseViewModel

@property (strong, nonatomic) MovieListModel *listItem;

@end

NS_ASSUME_NONNULL_END
