//
//  TheaterAreaViewModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "TheaterAreaModel.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterAreaViewModel : BaseViewModel

/// 列表数据
@property (strong, nonatomic) NSMutableArray *listData;

@property (strong, nonatomic) HomeModel *listItem;

@end

NS_ASSUME_NONNULL_END
