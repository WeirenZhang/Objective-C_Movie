//
//  StoreInfoViewModel.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "StoreInfoViewModel.h"
#import "StoreInfoModel.h"

@implementation StoreInfoViewModel

- (void)viewModelLoad {
    
    [super viewModelLoad];
}

- (RACCommand *)commandForKey:(NSString *)key {
    @weakify(self);
    // 加载列表
    if (isKey(@"list")) {
        
        return [RACCommand commandGet:Base_URL
                               params:^id _Nullable(id  _Nonnull input) {
            NSMutableDictionary *para = @{}.mutableCopy;
            para[@"type"] = @"StoreInfo";
            para[@"movie_id"] = input[1];
            return para;
        }
                            configure:^(HTRequestListConfigure * _Nonnull configure) {
            configure.serverName(@(HTRequestServer_Main));
        }
                        handleCommand:^(id  _Nonnull input, id  _Nonnull response, id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            
            // 加载更多参数值
            NSArray *elements = HTJSONMake(response).array;
            if ([input[0] integerValue] == RefreshActionType_Refresh) {
                [self.listData removeAllObjects];
            }
            NSArray *feedData = [NSArray yy_modelArrayWithClass:StoreInfoModel.class json:elements];
            
            if (feedData.count > 0) {
                [self.listData addObjectsFromArray:feedData];
            }
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }];
    }
    
    return [super commandForKey:key];
}

#pragma mark - Getter
- (NSMutableArray *)listData {
    return HT_LAZY(_listData, @[].mutableCopy);
}

@end
