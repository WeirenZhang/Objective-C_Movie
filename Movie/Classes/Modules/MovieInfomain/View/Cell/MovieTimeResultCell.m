//
//  MovieTimeResultCell.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieTimeResultCell.h"
#import "TypesModel.h"
#import "MovieTimeResultModel.h"
#import "TypesCell.h"

@interface MovieTimeResultCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UILabel *TheaterName;

@property (strong, nonatomic) UICollectionView *CollectionView;

@property (copy, nonatomic) NSMutableArray<TypesModel *> *TypesDataSource;

@end

@implementation MovieTimeResultCell

- (void)ht_cellLoad {
    
    [self.contentView addSubview:self.TheaterName];
    [self.contentView addSubview:self.CollectionView];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(MovieTimeResultModel *)Model {
    
    self.TheaterName.text = Model.theater;
    self.TypesDataSource = Model.types;
    [self.CollectionView reloadData];
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority
{
    
    CGSize size = [super systemLayoutSizeFittingSize:targetSize withHorizontalFittingPriority:horizontalFittingPriority verticalFittingPriority:verticalFittingPriority];
    [self.CollectionView layoutIfNeeded];
    CGFloat collectionH = self.CollectionView.collectionViewLayout.collectionViewContentSize.height;
    CGFloat height = size.height + collectionH;
    return CGSizeMake(size.width, height);
}

#pragma mark - Layout
- (void)layoutItemSubviews {
    
    [self.TheaterName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView).offset(10);
    }];
    [self.CollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.TheaterName.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH-20));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

#pragma mark - Getter
- (UILabel *)TheaterName {
    return HT_LAZY(_TheaterName, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(18);
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UICollectionView *)CollectionView {
    return HT_LAZY(_CollectionView, ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH - 20, 1);
        
        UICollectionView *CollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        CollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        CollectionView.showsVerticalScrollIndicator = NO;
        CollectionView.delegate = self;
        CollectionView.dataSource = self;
        CollectionView.backgroundColor = [UIColor whiteColor];
        [CollectionView registerClass:[TypesCell class] forCellWithReuseIdentifier:@"Cell"];
        CollectionView.scrollEnabled = NO;
        CollectionView;
    }));
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.TypesDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TypesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.style = @"Movie";
    [cell bindViewModel:self.TypesDataSource[indexPath.row]];
    return cell;
}

@end
