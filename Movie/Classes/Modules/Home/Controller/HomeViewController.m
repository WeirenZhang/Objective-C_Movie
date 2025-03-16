//
//  ViewController.m
//  Movie
//
//  Created by User on 2024/11/9.
//

#import "HomeViewController.h"

@interface HomeViewController ()

/// Disposable数组
@property (strong, nonatomic) NSMutableArray<RACDisposable *> *disposees;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"電影時刻表";
    
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithDefaultBackground];
        appearance.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:138.0/255.0 blue:138.0/255.0 alpha:1];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        // Fallback on earlier versions
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:255.0/255.0 green:138.0/255.0 blue:138.0/255.0 alpha:1];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    CGFloat horizontal = 20; // 左右边距
    CGFloat itemSpace = 5; // item 的间距
    CGFloat itemSize = (SCREEN_WIDTH - horizontal * 2 - itemSpace * 2) / 3; // 计算每个 item 的大小
    layout.minimumLineSpacing = itemSpace;
    layout.minimumInteritemSpacing = itemSpace;
    layout.sectionInset = UIEdgeInsetsMake(0, horizontal, 0, horizontal);
    layout.itemSize = CGSizeMake(floor(itemSize), floor(itemSize));
    
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant + 30, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self.view addSubview:self.collectionView];
    
    NSArray *HomeVCSettings = [self JSONFromFile];
    self.listData = [[NSMutableArray alloc] init];
    for (NSDictionary *HomeVCSetting in HomeVCSettings) {
        HomeModel *listModel = [HomeModel yy_modelWithDictionary:HomeVCSetting];
        [self.listData addObject:listModel];
    }
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
}

#pragma mark - Bind
- (void)bindViewModelDidLoad{
    
}

// The return value is either NSArray * or NSDictionary *
- (id)JSONFromFile
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeVCSettings" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell bindViewModel:[self.listData objectAtIndex:indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeModel *listItem = self.listData[indexPath.row];
    self.viewModel.requestCommand(@"push").execute(@[listItem, @(indexPath.row)]);
}

- (NSMutableArray<RACDisposable *> *)disposees{
    return HT_LAZY(_disposees, @[].mutableCopy);
}

- (void)dealloc{
    [self.disposees makeObjectsPerformSelector:@selector(dispose)];
}

@end
