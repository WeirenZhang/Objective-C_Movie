//
//  MyFavouriteViewModel.m
//  Movie
//
//  Created by User on 2024/12/6.
//

#import "MovieMyFavouriteViewModel.h"

@implementation MovieMyFavouriteViewModel

- (void)viewModelLoad {
    
    [super viewModelLoad];
}

- (RACCommand *)commandForKey:(NSString *)key {
    @weakify(self);
    // 加载列表
    if (isKey(@"push")) {
        return ht_commandWithSignal(^RACSignal * _Nonnull(id  _Nonnull input) {
            return ht_pushSignal(@"MovieInfoMainController", @"MovieInfoMainViewModel", @{@"listItem":input}, true);
        });
    }
    
    return [super commandForKey:key];
}

@end
