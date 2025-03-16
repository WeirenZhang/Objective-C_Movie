//
//  ViewController.h
//  Movie
//
//  Created by User on 2024/11/9.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "HomeCollectionViewCell.h"
#import "HomeViewModel.h"

@interface HomeViewController : BaseViewController <HomeViewModel *> <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong) NSMutableArray* listData;

@property (nonatomic,strong) UICollectionView *collectionView;

@end

