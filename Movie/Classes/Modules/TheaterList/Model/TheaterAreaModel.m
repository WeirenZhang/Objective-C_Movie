//
//  TheaterAreaModel.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterAreaModel.h"

@implementation TheaterAreaModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"theater_list" : [TheaterInfoModel class]};
}

@end
