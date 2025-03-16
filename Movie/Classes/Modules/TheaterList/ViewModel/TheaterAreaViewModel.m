//
//  TheaterAreaViewModel.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterAreaViewModel.h"

@implementation TheaterAreaViewModel

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
            para[@"type"] = @"Area";
            return para;
        }
                            configure:^(HTRequestListConfigure * _Nonnull configure) {
            configure.serverName(@(HTRequestServer_Main));
        }
                        handleCommand:^(id  _Nonnull input, id  _Nonnull response, id<RACSubscriber>  _Nonnull subscriber) {
            @strongify(self);
            
            // 加载更多参数值
            NSArray *elements = HTJSONMake(response).array;
            if ([input integerValue] == RefreshActionType_Refresh) {
                [self.listData removeAllObjects];
            }
            NSArray *feedData = [NSArray yy_modelArrayWithClass:TheaterAreaModel.class json:elements];
            
            if (feedData.count > 0) {
                [self.listData addObjectsFromArray:feedData];
            }
            
            [subscriber sendNext:nil];
            [subscriber sendCompleted];
        }];
    }else if (isKey(@"push")) {
        return ht_commandWithSignal(^RACSignal * _Nonnull(id  _Nonnull input) {
            return ht_pushSignal(@"TheaterListController", @"TheaterListViewModel", @{@"listItem":input}, true);
        });
    }
    
    return [super commandForKey:key];
}

#pragma mark - Getter
- (NSMutableArray *)listData {
    return HT_LAZY(_listData, @[].mutableCopy);
}

@end
