//
//  MovieTimeResultViewModel.m
//  Movie
//
//  Created by User on 2024/11/28.
//

#import "MovieTimeResultViewModel.h"

@implementation MovieTimeResultViewModel

- (void)viewModelLoad {
    
    [super viewModelLoad];
}

- (RACCommand *)commandForKey:(NSString *)key {
    @weakify(self);
    // 加载列表
    if (isKey(@"push")) {
        return ht_commandWithSignal(^RACSignal * _Nonnull(id  _Nonnull input) {
            return ht_pushSignal(@"TheaterTimeResultController", @"TheaterResultViewModel", @{@"listItem":input}, true);
        });
    }
    
    return [super commandForKey:key];
}

@end
