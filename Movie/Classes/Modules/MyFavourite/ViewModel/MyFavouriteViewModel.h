//
//  MyFavouriteViewModel.h
//  Movie
//
//  Created by User on 2024/12/6.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyFavouriteViewModel : BaseViewModel

@property (strong, nonatomic) HomeModel *listItem;

@end

NS_ASSUME_NONNULL_END
