//
//  HomeCollectionViewCell.h
//  Movie
//
//  Created by User on 2024/11/10.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeCollectionViewCell : UICollectionViewCell

- (void)bindViewModel:(HomeModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
