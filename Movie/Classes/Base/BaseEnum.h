//
//  HTBaseEnum.h
//  HeartTrip
//
//  Created by vin on 2021/5/20.
//  Copyright © 2021 BinBear. All rights reserved.
//

#ifndef BaseEnum_h
#define BaseEnum_h

/// TableView上下拉刷新类型
typedef NS_ENUM(NSUInteger, RefreshActionType) {
    RefreshActionType_First = 0,   // 首次加载
    RefreshActionType_Refresh,    // 下拉刷新
    RefreshActionType_LoadMore,  // 加载更多
};

/// Tableview数据占位图类型
typedef NS_ENUM(NSUInteger, EmptyType) {
    EmptyType_NoStatus = 1U << 0,         // 无状态，还未请求接口
    EmptyType_NoData = 1U << 1,          // 暂无数据
    EmptyType_NetworkError = 1U << 2,   // 网络连接异常，请稍后再试
    EmptyType_OneAction = 1U << 3,     // 单个按钮
    EmptyType_TwoAction  = 1U << 4,   // 两个按钮
    EmptyType_Success  = 1U << 5     // 请求成功
};

typedef NS_ENUM(NSUInteger, URLRouteActionType) {
    URLRouteActionType_Push = 0,        // Push跳转
    URLRouteActionType_Present,        // Present跳转
    URLRouteActionType_Pop,           // Pop跳转
    URLRouteActionType_Dismiss,      // Dismiss跳转
};

#endif /* BaseEnum_h */
