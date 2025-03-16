//
//  WebViewModel.h
//  Movie
//
//  Created by User on 2024/12/2.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "VideoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebViewModel : BaseViewModel

@property (strong, nonatomic) VideoModel *listItem;

@end

NS_ASSUME_NONNULL_END
