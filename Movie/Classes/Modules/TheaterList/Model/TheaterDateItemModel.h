//
//  TheaterDateItemModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "TheaterTimeResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterDateItemModel : NSObject

@property (copy,  nonatomic) NSString *date;

@property (copy,  nonatomic) NSMutableArray<TheaterTimeResultModel *> *data;

@end

NS_ASSUME_NONNULL_END
