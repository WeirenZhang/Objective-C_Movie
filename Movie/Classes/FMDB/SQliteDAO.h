//
//  SQliteDAO.h
//  Movie
//
//  Created by User on 2024/12/5.
//

#import <Foundation/Foundation.h>
#import "MovieListModel.h"
#import "TheaterInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQliteDAO : NSObject

- (BOOL)saveMovieModel:(MovieListModel *)model;

- (BOOL)saveTheaterModel:(TheaterInfoModel *)model;

- (NSMutableArray <MovieListModel *>*)getAllMovieModels;

- (NSMutableArray <TheaterInfoModel *>*)getAllTheaterModels;

- (BOOL)removeMovieModel:(MovieListModel *)model;

- (BOOL)removeTheaterModel:(TheaterInfoModel *)model;

@end

NS_ASSUME_NONNULL_END
