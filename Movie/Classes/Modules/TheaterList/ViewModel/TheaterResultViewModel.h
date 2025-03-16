//
//  TheaterResultViewModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "TheaterInfoModel.h"
#import "TheaterDateItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterResultViewModel : BaseViewModel

@property (strong, nonatomic) TheaterInfoModel *listItem;

/// 列表数据
@property (strong, nonatomic) NSMutableArray<TheaterDateItemModel *> *listData;

@end

NS_ASSUME_NONNULL_END
