//
//  TimeCell.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TimeCell : UICollectionViewCell

- (void)bindViewModel:(TimeModel *)Model;

@property (nonatomic, strong) NSString *style;

@end

NS_ASSUME_NONNULL_END
