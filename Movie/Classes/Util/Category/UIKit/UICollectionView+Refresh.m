//
//  UICollectionView+Refresh.m
//  HeartTrip
//
//  Created by vin on 2020/11/20.
//  Copyright © 2020 BinBear. All rights reserved.
//

#import "UICollectionView+Refresh.h"

@implementation UICollectionView (Refresh)

#pragma mark - KakaRefesh
- (void)addRefreshWithKaKaHeaderBlock:(void (^)(void))headerRefreshBlock
                  withKaKaFooterBlock:(void (^)(void))footerRefreshBlock {
    if (headerRefreshBlock) {
        [self bindHeadRefreshHandler:^{
            dispatch_main_async_safe(^{
                headerRefreshBlock();
            });
        }
                          themeColor:UIColor.blueColor
                        refreshStyle:KafkaRefreshStyleReplicatorCircle];
        self.headRefreshControl.backgroundColor = UIColor.clearColor;
    }
    
    if (footerRefreshBlock) {
        [self bindFootRefreshHandler:^{
            dispatch_main_async_safe(^{
                footerRefreshBlock();
            });
        }
                          themeColor:UIColor.blueColor
                        refreshStyle:KafkaRefreshStyleReplicatorAllen];
//        self.footRefreshControl.hidden = YES;
    }
}

- (void)endRefresh {
    [self.headRefreshControl endRefreshing];
    [self.footRefreshControl endRefreshing];
}
@end
