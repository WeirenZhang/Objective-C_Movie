//
//  MovieTimeTabsViewModel.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "MovieListModel.h"
#import "MovieDateTabItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeTabsViewModel : BaseViewModel

@property (strong, nonatomic) MovieListModel *listItem;

/// 列表数据
@property (strong, nonatomic) NSMutableArray<MovieDateTabItemModel *> *listData;

@end

NS_ASSUME_NONNULL_END
