//
//  SQlite.h
//  Movie
//
//  Created by User on 2024/12/5.
//

#import <Foundation/Foundation.h>
#import "SqliteManager.h"
#import "SQSingleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface SQlite : NSObject

//单例宏模块
SINGLETON_FOR_HEADER(SQlite);

//保证数据库只创建一次
- (SqliteManager *)manager;

@end

NS_ASSUME_NONNULL_END
