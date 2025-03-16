//
//  VideoViewController.h
//  Movie
//
//  Created by User on 2024/11/27.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "VideoViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoViewController : BaseViewController <VideoViewModel *>

@property (strong, nonatomic) UITableView *listTableView;

@end

NS_ASSUME_NONNULL_END
