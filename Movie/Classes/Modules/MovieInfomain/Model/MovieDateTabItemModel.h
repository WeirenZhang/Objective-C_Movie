//
//  MovieDateTabItemModel.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <Foundation/Foundation.h>
#import "MovieTimeTabItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDateTabItemModel : NSObject

@property (copy,  nonatomic) NSString *date;

@property (copy,  nonatomic) NSMutableArray<MovieTimeTabItemModel *> *list;

@end

NS_ASSUME_NONNULL_END
