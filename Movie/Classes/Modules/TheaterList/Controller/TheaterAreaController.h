//
//  TheaterAreaController.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "TheaterAreaViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterAreaController : BaseViewController <TheaterAreaViewModel *>

@property (strong, nonatomic) UITableView *listTableView;

@end

NS_ASSUME_NONNULL_END
