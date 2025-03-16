//
//  TheaterListViewModel.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterListViewModel.h"

@implementation TheaterListViewModel

- (void)viewModelLoad {
    
    [super viewModelLoad];
}

- (RACCommand *)commandForKey:(NSString *)key {
    @weakify(self);
    if (isKey(@"push")) {
        return ht_commandWithSignal(^RACSignal * _Nonnull(id  _Nonnull input) {
            return ht_pushSignal(@"TheaterTimeResultController", @"TheaterResultViewModel", @{@"listItem":input}, true);
        });
    }
    
    return [super commandForKey:key];
}

@end
