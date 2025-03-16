//
//  HTURLRouteParserProtocol.h
//  HeartTrip
//
//  Created by vin on 2021/6/19.
//  Copyright © 2021 Vin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseEnum.h"

NS_ASSUME_NONNULL_BEGIN

@protocol URLRouteParserProtocol <NSObject>

@optional

/// 路由URL中控制器名称
@property (copy,  nonatomic,readonly) NSString *ctrName;
/// 路由URL中viewModel名称
@property (copy,  nonatomic,readonly) NSString *vmName;
/// 路由URL中参数
@property (strong,nonatomic,readonly) id parameter;
/// 路由URL中跳转类型
@property (assign,nonatomic,readonly) URLRouteActionType  actionType;
/// 是否标准的路由
@property (assign,nonatomic,readonly) BOOL  isRouteURL;


/// 初始化一个路由解析实例
/// @param url 路由
+ (instancetype)urlRoutePaeserWithURL:(NSString *)url;

/// 解析URL
- (void)parseURL;

@end

NS_ASSUME_NONNULL_END
