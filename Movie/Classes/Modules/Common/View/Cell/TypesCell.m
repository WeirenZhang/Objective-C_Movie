//
//  TypesCell.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TypesCell.h"
#import "TypeCell.h"
#import "TimeCell.h"

@interface TypesCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *TypeCollectionView;
@property (nonatomic, strong) UICollectionView *TimeCollectionView;
@property (nonatomic, strong) NSLayoutConstraint *TypeCollectionViewHeight;
@property (nonatomic, strong) NSLayoutConstraint *TimeCollectionViewHeight;
@property (nonatomic, strong) NSMutableArray *TypeDataSource;
@property (nonatomic, strong) NSMutableArray *TimeDataSource;
@property (nonatomic, strong) TypesModel *item;

@end

@implementation TypesCell

- (void)ht_cellLoad {
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (collectionView == self.TypeCollectionView) {
        return self.TypeDataSource.count;
    } else {
        return self.TimeDataSource.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == self.TypeCollectionView) {
        TypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TypeCell" forIndexPath:indexPath];
        cell.style = self.style;
        [cell bindViewModel:self.TypeDataSource[indexPath.row]];
        return cell;
    } else {
        TimeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TimeCell" forIndexPath:indexPath];
        cell.style = self.style;
        [cell bindViewModel:self.TimeDataSource[indexPath.row]];
        return cell;
    }
}

- (void)bindViewModel:(TypesModel *)viewModel {
    
    [self.contentView addSubview:self.TypeCollectionView];
    [self.contentView addSubview:self.TimeCollectionView];
    self.TimeCollectionViewHeight = [NSLayoutConstraint constraintWithItem:self.TimeCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
    [self.TimeCollectionView addConstraint:self.TimeCollectionViewHeight];
    
    self.TypeCollectionViewHeight = [NSLayoutConstraint constraintWithItem:self.TypeCollectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.0 constant:0];
    [self.TypeCollectionView addConstraint:self.TypeCollectionViewHeight];
    
    [self layoutItemSubviews];
    
    self.TypeDataSource = viewModel.types;
    NSLog(@"types %lu", (unsigned long)viewModel.types.count);
    [self.TypeCollectionView layoutIfNeeded];
    
    CGSize TypeCollectionViewContentSize = self.TypeCollectionView.collectionViewLayout.collectionViewContentSize;
    self.TypeCollectionViewHeight.constant = TypeCollectionViewContentSize.height;
    [self.TypeCollectionView.collectionViewLayout invalidateLayout];
    
    self.TimeDataSource = viewModel.times;
    NSLog(@"times %lu", (unsigned long)viewModel.times.count);
    [self.TimeCollectionView layoutIfNeeded];
    
    CGSize TimeCollectionViewContentSize = self.TimeCollectionView.collectionViewLayout.collectionViewContentSize;
    self.TimeCollectionViewHeight.constant = TimeCollectionViewContentSize.height;
    [self.TimeCollectionView.collectionViewLayout invalidateLayout];
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    //self.backgroundColor = [UIColor blueColor];
    [self.TypeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.top.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        if ([self.style containsString:@"Movie"]) {
            make.width.equalTo(@(SCREEN_WIDTH - 30));
        } else {
            make.width.equalTo(@(SCREEN_WIDTH - 140));
        }
    }];
    
    [self.TimeCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(5);
        make.right.equalTo(self.contentView).offset(-5);
        make.top.equalTo(self.TypeCollectionView.mas_bottom).offset(5);
        if ([self.style containsString:@"Movie"]) {
            make.width.equalTo(@(SCREEN_WIDTH - 30));
        } else {
            make.width.equalTo(@(SCREEN_WIDTH - 140));
        }
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
}

#pragma mark - Getter
- (UICollectionView *)TypeCollectionView {
    return HT_LAZY(_TypeCollectionView, ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        if ([self.style containsString:@"Movie"]) {
            layout.itemSize = CGSizeMake((CGFloat)(SCREEN_WIDTH - 50) / 3, 30);
        } else {
            layout.itemSize = CGSizeMake((CGFloat)(SCREEN_WIDTH - 150) / 2, 30);
        }
        
        UICollectionView *CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        CollectionView.scrollEnabled = NO;
        [CollectionView registerClass:[TypeCell class] forCellWithReuseIdentifier:@"TypeCell"];
        CollectionView.delegate = self;
        CollectionView.dataSource = self;
        CollectionView.backgroundColor = [UIColor whiteColor];
        CollectionView;
    }));
}

- (UICollectionView *)TimeCollectionView {
    return HT_LAZY(_TimeCollectionView, ({
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 5;
        if ([self.style containsString:@"Movie"]) {
            layout.itemSize = CGSizeMake((CGFloat)(SCREEN_WIDTH - 50) / 3, 30);
        } else {
            layout.itemSize = CGSizeMake((CGFloat)(SCREEN_WIDTH - 150) / 2, 30);
        }
        UICollectionView *CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        CollectionView.scrollEnabled = NO;
        [CollectionView registerClass:[TimeCell class] forCellWithReuseIdentifier:@"TimeCell"];
        CollectionView.delegate = self;
        CollectionView.dataSource = self;
        CollectionView.backgroundColor = [UIColor whiteColor];
        CollectionView;
    }));
}

@end
