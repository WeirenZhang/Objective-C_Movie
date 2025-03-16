//
//  TypeCell.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "TypeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TypeCell : UICollectionViewCell

- (void)bindViewModel:(TypeModel *)Model;

@property (nonatomic,assign) NSString *style;

@end

NS_ASSUME_NONNULL_END
