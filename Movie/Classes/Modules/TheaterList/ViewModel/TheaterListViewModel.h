//
//  TheaterListViewModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "TheaterAreaModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterListViewModel : BaseViewModel

@property (strong, nonatomic) TheaterAreaModel *listItem;

@end

NS_ASSUME_NONNULL_END
