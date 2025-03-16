//
//  MovieListModel.h
//  Movie
//
//  Created by User on 2024/11/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MovieListModel : NSObject

@property (copy,  nonatomic) NSString *title;

@property (copy,  nonatomic) NSString *en;

@property (copy,  nonatomic) NSString *release_movie_time;

@property (copy,  nonatomic) NSString *thumb;

@property (copy,  nonatomic) NSString *id;

@end

NS_ASSUME_NONNULL_END
