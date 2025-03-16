//
//  MovieListViewModel.h
//  Movie
//
//  Created by User on 2024/11/10.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieListViewModel : BaseViewModel

@property (nonatomic) int page; //当前页数

@property (nonatomic) bool noMore;

@property (strong, nonatomic) HomeModel *listItem;

/// 列表数据
@property (strong, nonatomic) NSMutableArray *listData;

@end

NS_ASSUME_NONNULL_END
