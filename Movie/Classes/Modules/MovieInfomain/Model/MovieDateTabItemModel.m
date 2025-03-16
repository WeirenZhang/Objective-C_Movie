//
//  MovieDateTabItemModel.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieDateTabItemModel.h"

@implementation MovieDateTabItemModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"list" : [MovieTimeTabItemModel class]};
}

@end
