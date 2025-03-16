//
//  SQliteDAO.m
//  Movie
//
//  Created by User on 2024/12/5.
//

#import "SQliteDAO.h"
#import "SqliteManager.h"
#import <FMDB/FMDB.h>
#import "SQlite.h"

@implementation SQliteDAO

- (SqliteManager *)getDataSource {
    return [[SQlite sharedInstance] manager];
}

- (BOOL)saveMovieModel:(MovieListModel *)model {
    FMDatabaseQueue *dbQueue = [[self getDataSource] dbQueue];
    __block BOOL ret = NO;
    
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSUInteger count = [db intForQuery:[NSString stringWithFormat:@"SELECT count(*) FROM Movie WHERE id = '%@'",model.id]];
        if (count == 0) {
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO Movie(id, title, en, release_movie_time, thumb) VALUES ('%@', '%@', '%@', '%@', '%@')", model.id,  model.title , model.en, model.release_movie_time, model.thumb];
            ret = [db executeUpdate:insertSql];
        }
    }];
    return ret;
}

- (BOOL)saveTheaterModel:(TheaterInfoModel *)model {
    FMDatabaseQueue *dbQueue = [[self getDataSource] dbQueue];
    __block BOOL ret = NO;
    
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSUInteger count = [db intForQuery:[NSString stringWithFormat:@"SELECT count(*) FROM Theater WHERE id = '%@'",model.id]];
        if (count == 0) {
            NSString *insertSql = [NSString stringWithFormat:@"INSERT INTO Theater(id, name, adds, tel) VALUES ('%@', '%@', '%@', '%@')", model.id,  model.name , model.adds, model.tel];
            ret = [db executeUpdate:insertSql];
        }
    }];
    return ret;
}

- (NSMutableArray <MovieListModel *>*)getAllMovieModels {
    FMDatabaseQueue *dbQueue = [[self getDataSource] dbQueue];
    __block NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Movie"]];
        while ([set next]) {
            MovieListModel *listModel = [MovieListModel new];
            listModel.id = [set stringForColumn:@"id"];
            listModel.title = [set stringForColumn:@"title"];
            listModel.en = [set stringForColumn:@"en"];
            listModel.release_movie_time = [set stringForColumn:@"release_movie_time"];
            listModel.thumb = [set stringForColumn:@"thumb"];
            [modelArray addObject:listModel];
        }
        [set close];
    }];
    return modelArray.copy;
}

- (NSMutableArray <TheaterInfoModel *>*)getAllTheaterModels {
    FMDatabaseQueue *dbQueue = [[self getDataSource] dbQueue];
    __block NSMutableArray *modelArray = [[NSMutableArray alloc] init];
    
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM Theater"]];
        while ([set next]) {
            TheaterInfoModel *listModel = [TheaterInfoModel new];
            listModel.id = [set stringForColumn:@"id"];
            listModel.name = [set stringForColumn:@"name"];
            listModel.adds = [set stringForColumn:@"adds"];
            listModel.tel = [set stringForColumn:@"tel"];
            [modelArray addObject:listModel];
        }
        [set close];
    }];
    return modelArray.copy;
}

- (BOOL)removeMovieModel:(MovieListModel *)model {
    FMDatabaseQueue *dbQueue = [[self getDataSource] dbQueue];
    __block BOOL ret = NO;
    
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSError *error;
        ret = [db executeUpdate:@"DELETE FROM Movie WHERE id = ?" values:@[model.id] error:&error];
        if (!ret) {
            NSLog(@"Delete Movie model fail,error = %@",error);
        }
    }];
    return ret;
}

- (BOOL)removeTheaterModel:(TheaterInfoModel *)model {
    FMDatabaseQueue *dbQueue = [[self getDataSource] dbQueue];
    __block BOOL ret = NO;
    
    [dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSError *error;
        ret = [db executeUpdate:@"DELETE FROM Theater WHERE id = ?" values:@[model.id] error:&error];
        if (!ret) {
            NSLog(@"Delete Movie model fail,error = %@",error);
        }
    }];
    return ret;
}

@end
