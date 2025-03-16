//
//  TypesModel.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TypesModel.h"

@implementation TypesModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"types" : [TypeModel class], @"times" : [TimeModel class]};
}

@end





