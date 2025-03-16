//
//  TypesModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "TypeModel.h"
#import "TimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TypesModel : NSObject

@property (copy,  nonatomic) NSMutableArray<TypeModel *> *types;

@property (copy,  nonatomic) NSMutableArray<TimeModel *> *times;

@end

NS_ASSUME_NONNULL_END
