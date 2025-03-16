//
//  TheaterTimeResultCell.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterTimeResultCell.h"
#import "TypesCell.h"

@interface TheaterTimeResultCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) UIImageView *ReleaseFoto;

@property (strong, nonatomic) UILabel *TheaterListName;

@property (strong, nonatomic) UILabel *Length;

@property (strong, nonatomic) UIImageView *Icon;

@property (strong, nonatomic) UICollectionView *CollectionView;

@property (copy, nonatomic) NSMutableArray<TypesModel *> *TypesDataSource;

@end

@implementation TheaterTimeResultCell

- (void)ht_cellLoad {
    
    [self.contentView addSubview:self.ReleaseFoto];
    [self.contentView addSubview:self.TheaterListName];
    [self.contentView addSubview:self.Length];
    [self.contentView addSubview:self.Icon];
    [self.contentView addSubview:self.CollectionView];
    [self layoutItemSubviews];
}

- (void)bindViewModel:(TheaterTimeResultModel *)Model {
    
    [self.ReleaseFoto sd_setImageWithURL:[NSURL URLWithString:Model.release_foto] placeholderImage:Nil];
    self.TheaterListName.text = Model.theaterlist_name;
    self.Length.text = Model.length;
    [self.Icon sd_setImageWithURL:[NSURL URLWithString:Model.icon] placeholderImage:Nil];
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
    
    self.backgroundColor = [UIColor whiteColor];
    [self.ReleaseFoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.width.equalTo(@100);
        make.height.equalTo(@143);
    }];
    [self.TheaterListName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ReleaseFoto.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    [self.Length mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ReleaseFoto.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.TheaterListName.mas_bottom).offset(5);
    }];
    [self.Icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ReleaseFoto.mas_right).offset(10);
        make.width.equalTo(@45);
        make.height.equalTo(@45);
        make.top.equalTo(self.Length.mas_bottom).offset(10);
    }];
    [self.CollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ReleaseFoto.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.Icon.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH-130));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

#pragma mark - Getter
- (UIImageView *)ReleaseFoto {
    return HT_LAZY(_ReleaseFoto, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view;
    }));
}
- (UILabel *)TheaterListName {
    return HT_LAZY(_TheaterListName, ({
        UILabel *label = [UILabel new];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UILabel *)Length {
    return HT_LAZY(_Length, ({
        UILabel *label = [UILabel new];
        label.font = textFontPingFangMediumFont(14);
        label.textColor = [UIColor grayColor];
        label.textAlignment = NSTextAlignmentLeft;
        label.numberOfLines = 0;
        label;
    }));
}
- (UIImageView *)Icon {
    return HT_LAZY(_Icon, ({
        SDAnimatedImageView *view = [SDAnimatedImageView new];
        //view.layer.cornerRadius = 8;
        view.layer.masksToBounds = true;
        view.contentMode = UIViewContentModeScaleAspectFill;
        view;
    }));
}
- (UICollectionView *)CollectionView {
    return HT_LAZY(_CollectionView, ({
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.estimatedItemSize = CGSizeMake(SCREEN_WIDTH - 130, 1);
        
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
    cell.style = @"Theater";
    [cell bindViewModel:self.TypesDataSource[indexPath.row]];
    return cell;
}

@end
