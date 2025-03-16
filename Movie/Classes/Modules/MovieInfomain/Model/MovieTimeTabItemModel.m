//
//  MovieTimeTabItemModel.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieTimeTabItemModel.h"

@implementation MovieTimeTabItemModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [MovieTimeResultModel class]};
}

@end
