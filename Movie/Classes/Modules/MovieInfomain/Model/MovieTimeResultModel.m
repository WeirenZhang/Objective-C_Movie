//
//  MovieTimeResultModel.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieTimeResultModel.h"

@implementation MovieTimeResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"types" : [TypesModel class]};
}

@end
