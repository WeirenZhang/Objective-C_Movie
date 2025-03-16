//
//  SqliteManager.h
//  Movie
//
//  Created by User on 2024/12/5.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface SqliteManager : NSObject

/**
 * 初始化数据对象
 * @param defineFileName :  数据库定义文件
 * @param  filePath : 数据库文件路径
 */

- (instancetype)initWithDBDefine:(NSString * )bundleName filePath:(NSString *)filePath;

/**
 *  返回DataBaseQueue 对象, 用于数据库操作
 *  DataBaseQueue是线程安全的
 *
 *  @return FMDatabaseQueue
 */
- (FMDatabaseQueue *)dbQueue;

/**
 *  关闭数据库
 *  当前用户登录时调用
 */
- (void)closeDataBase;

@end

NS_ASSUME_NONNULL_END
