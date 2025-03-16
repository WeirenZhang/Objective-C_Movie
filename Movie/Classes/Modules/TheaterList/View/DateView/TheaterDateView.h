//
//  TheaterDateView.h
//  Movie
//
//  Created by User on 2024/11/21.
//

#import <UIKit/UIKit.h>
#import "DateViewProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface TheaterDateView : UIView

+ (instancetype)bindViewWithViewModel:(id)viewModel;

@property (nonatomic, strong) UIButton *dateButton;

@property (nonatomic, assign) id<DateViewProtocol> delegate;

@end

NS_ASSUME_NONNULL_END
