//
//  TheaterTimeResultModel.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <Foundation/Foundation.h>
#import "TypesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterTimeResultModel : NSObject

@property (copy,  nonatomic) NSString *id;

@property (copy,  nonatomic) NSString *release_foto;

@property (copy,  nonatomic) NSString *theaterlist_name;

@property (copy,  nonatomic) NSString *length;

@property (copy,  nonatomic) NSString *icon;

@property (copy,  nonatomic) NSMutableArray<TypesModel *> *types;

@end

NS_ASSUME_NONNULL_END
