//
//  HomeViewModel.m
//  Movie
//
//  Created by User on 2024/11/13.
//

#import "HomeViewModel.h"
#import "VideoModel.h"

@implementation HomeViewModel

- (void)viewModelLoad {
    
    [super viewModelLoad];
}

- (RACCommand *)commandForKey:(NSString *)key {
    @weakify(self);
    if (isKey(@"push")) {
        VideoModel *videoModel = [VideoModel new];
        videoModel.title = @"網路訂票";
        videoModel.href = @"https://www.ezding.com.tw/";
        
        return ht_commandWithSignal(^RACSignal * _Nonnull(id  _Nonnull input) {
            
            switch ([input[1] intValue]) {
                case 0:
                    return ht_pushSignal(@"MovieListViewController", @"MovieListViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 1:
                    return ht_pushSignal(@"MovieListViewController", @"MovieListViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 2:
                    return ht_pushSignal(@"MovieListViewController", @"MovieListViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 3:
                    return ht_pushSignal(@"MovieListViewController", @"MovieListViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 4:
                    return ht_pushSignal(@"MovieListViewController", @"MovieListViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 5:
                    return ht_pushSignal(@"TheaterAreaController", @"TheaterAreaViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 6:
                    return ht_pushSignal(@"MyFavouriteViewController", @"MyFavouriteViewModel", @{@"listItem":input[0]}, true);
                    break;
                case 7:
                    return ht_pushSignal(@"WebViewController", @"WebViewModel", @{@"listItem":videoModel}, true);
                    break;
                default:
                    return ht_pushSignal(@"WebViewController", @"WebViewModel", @{@"listItem":videoModel}, true);
                    break;
            }
        });
    }
    
    return [super commandForKey:key];
}

@end
