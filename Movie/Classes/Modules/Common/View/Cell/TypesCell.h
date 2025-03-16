//
//  TypesCell.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "TypesModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TypesCell : UICollectionViewCell

- (void)bindViewModel:(TypesModel *)Model;

@property (nonatomic, strong) NSString *style;

@end

NS_ASSUME_NONNULL_END
