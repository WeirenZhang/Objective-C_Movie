//
//  TheaterTimeResultModel.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterTimeResultModel.h"

@implementation TheaterTimeResultModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"types" : [TypesModel class]};
}

@end
