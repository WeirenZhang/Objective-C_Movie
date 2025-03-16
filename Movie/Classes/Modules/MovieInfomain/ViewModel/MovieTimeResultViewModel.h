//
//  MovieTimeResultViewModel.h
//  Movie
//
//  Created by User on 2024/11/28.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "MovieTimeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeResultViewModel : BaseViewModel

@property (copy, nonatomic) NSMutableArray<MovieTimeResultModel *> *listItem;

@end

NS_ASSUME_NONNULL_END
