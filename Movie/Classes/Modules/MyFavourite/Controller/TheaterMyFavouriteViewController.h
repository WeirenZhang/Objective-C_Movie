//
//  TheaterMyFavouriteViewController.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TheaterMyFavouriteViewModel.h"
#import "SQliteDAO.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterMyFavouriteViewController : BaseViewController <TheaterMyFavouriteViewModel *>

@property (strong, nonatomic) UITableView *listTableView;

@property (nonatomic, strong) SQliteDAO *SQliteDAO;

/// 列表数据
@property (strong, nonatomic) NSMutableArray *listData;

@end

NS_ASSUME_NONNULL_END
