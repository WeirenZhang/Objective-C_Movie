//
//  TheaterDateItemModel.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterDateItemModel.h"

@implementation TheaterDateItemModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [TheaterTimeResultModel class]};
}

@end
