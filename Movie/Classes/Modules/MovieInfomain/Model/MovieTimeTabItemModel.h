//
//  MovieTimeTabItemModel.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <Foundation/Foundation.h>
#import "MovieTimeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeTabItemModel : NSObject

@property (copy,  nonatomic) NSString *area;

@property (copy,  nonatomic) NSMutableArray<MovieTimeResultModel *> *data;

@end

NS_ASSUME_NONNULL_END
