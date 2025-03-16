//
//  UITableView+Refresh.m
//  HeartTrip
//
//  Created by vin on 2020/11/20.
//  Copyright © 2020 BinBear. All rights reserved.
//

#import "UITableView+Refresh.h"

@implementation UITableView (Refresh)

#pragma mark
#pragma mark - KakaRefesh

- (void)addRefreshWithKaKaHeaderBlock:(void (^)(void))headerRefreshBlock {
    
    if (headerRefreshBlock) {
        [self bindHeadRefreshHandler:^{
            dispatch_main_async_safe(^{
                headerRefreshBlock();
            });
        }
                          themeColor:UIColor.grayColor
                        refreshStyle:KafkaRefreshStyleAnimatableArrow];
        self.headRefreshControl.backgroundColor = UIColor.clearColor;
    }
}

- (void)addRefreshWithKaKaHeaderBlock:(void (^)(void))headerRefreshBlock
                  withKaKaFooterBlock:(void (^)(void))footerRefreshBlock {
    
    if (headerRefreshBlock) {
        [self bindHeadRefreshHandler:^{
            dispatch_main_async_safe(^{
                headerRefreshBlock();
            });
        }
                          themeColor:UIColor.grayColor
                        refreshStyle:KafkaRefreshStyleAnimatableArrow];
        self.headRefreshControl.backgroundColor = UIColor.clearColor;
    }
    
    if (footerRefreshBlock) {
        [self bindFootRefreshHandler:^{
            dispatch_main_async_safe(^{
                footerRefreshBlock();
            });
        }
                          themeColor:UIColor.grayColor
                        refreshStyle:KafkaRefreshStyleAnimatableArrow];
        //self.footRefreshControl.hidden = YES;
        self.footRefreshControl.backgroundColor = UIColor.clearColor;
    }
}

- (void)endRefresh {
    [self.headRefreshControl endRefreshing];
    [self.footRefreshControl endRefreshing];
}

- (void)noMore {
    [self.footRefreshControl endRefreshingAndNoLongerRefreshingWithAlertText:@"No More"];
}

- (void)resumeRefreshAvailable {
    [self.footRefreshControl resumeRefreshAvailable];
}

@end

















