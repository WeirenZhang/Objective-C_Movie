//
//  SQlite.m
//  Movie
//
//  Created by User on 2024/12/5.
//

#import "SQlite.h"

@interface SQlite ()

@property (nonatomic, strong) SqliteManager *manager;

@end

@implementation SQlite

SINGLETON_FOR_CLASS(SQlite);

- (SqliteManager *)manager {
    if (_manager) {
        return _manager;
    }
    @synchronized(self) {
        if (!_manager) {
            NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
            NSString *dbPath = [docPath stringByAppendingPathComponent:@"Movie.sqlite"];
            NSLog(@"path = %@",dbPath);
            _manager = [[SqliteManager alloc] initWithDBDefine:@"SQlite" filePath:dbPath];
        }
    }
    return _manager;
}

@end
