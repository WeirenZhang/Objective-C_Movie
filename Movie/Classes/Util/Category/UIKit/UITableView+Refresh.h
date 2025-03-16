//
//  UITableView+Refresh.h
//  HeartTrip
//
//  Created by vin on 2020/11/20.
//  Copyright © 2020 BinBear. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Refresh)

/// 给UITableView增加上下拉刷新 (KK)
- (void)addRefreshWithKaKaHeaderBlock:(void (^)(void))headerRefreshBlock;

- (void)addRefreshWithKaKaHeaderBlock:(void (^)(void))headerRefreshBlock
                  withKaKaFooterBlock:(void (^)(void))footerRefreshBlock;

/// 停止刷新
- (void)endRefresh;

- (void)noMore;

- (void)resumeRefreshAvailable;

@end
