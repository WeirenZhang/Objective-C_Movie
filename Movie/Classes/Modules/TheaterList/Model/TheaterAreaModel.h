//
//  TheaterAreaModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "TheaterInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterAreaModel : NSObject

@property (copy,  nonatomic) NSString *theater_top;

@property (copy,  nonatomic) NSMutableArray<TheaterInfoModel *> *theater_list;

@end

NS_ASSUME_NONNULL_END
