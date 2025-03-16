//
//  MovieTimeResultModel.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <Foundation/Foundation.h>
#import "TypesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieTimeResultModel : NSObject

@property (copy,  nonatomic) NSString *id;

@property (copy,  nonatomic) NSString *theater;

@property (copy,  nonatomic) NSMutableArray<TypesModel *> *types;

@end

NS_ASSUME_NONNULL_END
