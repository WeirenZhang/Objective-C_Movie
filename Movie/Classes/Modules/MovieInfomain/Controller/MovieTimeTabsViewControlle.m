//
//  MovieTimeTabsViewControlle.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieTimeTabsViewControlle.h"
#import "MovieDateView.h"
#import "MovieTimeResultCell.h"
#import "JXCategoryView.h"
#import "MovieTimeResultViewController.h"
#import <ObjectiveSugar/ObjectiveSugar.h>
#import "DGActivityIndicatorView.h"

@interface MovieTimeTabsViewControlle ()
<JXCategoryViewDelegate, JXCategoryTitleViewDataSource, JXCategoryListContainerViewDelegate,DateViewProtocol>

@property (strong, nonatomic) MovieDateView *dateView;

@property (nonatomic,assign) CGFloat dateViewHeight;

@property (nonatomic,assign) NSInteger SelectRow;

@property (strong, nonatomic) DGActivityIndicatorView *activityIndicatorView;

@end

@implementation MovieTimeTabsViewControlle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dateViewHeight = 60;
    self.SelectRow = 0;
    
    self.dateView.delegate = self;
    
    [self.view addSubview:self.categoryView];
    [self.view addSubview:self.listContainerView];
    
    self.activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:(DGActivityIndicatorAnimationType)[@(DGActivityIndicatorAnimationTypeBallSpinFadeLoader) integerValue] tintColor:UIColorMake(255, 85, 85)];
    [self.view addSubview:self.activityIndicatorView];
    
    [self.view addSubview:self.dateView];
    
    @weakify(self);
    
    // 监听列表数据
    self.viewModel.requestCommand(@"list").subscribeAll(^(id  _Nonnull value) {
        
    }, ^(NSError * _Nonnull error) {
        @strongify(self);
        NSLog(@"error %@d", error);
        self.viewModel.emptyType = EmptyType_NetworkError;
        //[self.listTableView reloadData];
    }, ^(id  _Nonnull value) {
        @strongify(self);
        if (![value boolValue]) {
            //self.viewModel.emptyType = EmptyType_OneAction;
            if (self.viewModel.listData.count > 0) {
                NSArray *areas = [self.viewModel.listData[self.SelectRow].list map:^NSString*(MovieTimeTabItemModel* post) {
                    return post.area;
                }];
                self.categoryView.titles = areas;
                [self.categoryView reloadData];
            }
            [self.activityIndicatorView stopAnimating];
        }
    });
    
    self.viewModel.requestCommand(@"list").execute(self.viewModel.listItem.id);
    [self.activityIndicatorView startAnimating];
}

- (void)SetDateViewHeight:(CGFloat)height {
    
    self.dateViewHeight = height;
    [self viewDidLayoutSubviews];
}

- (void)SetSelectRow:(NSInteger)index {
    
    self.SelectRow = index;
    NSArray *areas = [self.viewModel.listData[self.SelectRow].list map:^NSString*(MovieTimeTabItemModel* post) {
        return post.area;
    }];
    self.categoryView.titles = areas;
    [self.categoryView reloadData];
}

#pragma mark - Bind
- (void)bindViewModelDidLoad
{
    
    //self.title = self.viewModel.listItem.name;
}

- (CGFloat)preferredCategoryViewHeight {
    return 50;
}

- (void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    self.dateView.rectValue(0, NavigationContentTopConstant, SCREEN_WIDTH, self.dateViewHeight);
    
    self.categoryView.frame = CGRectMake(0, NavigationContentTopConstant + self.dateViewHeight, SCREEN_WIDTH, [self preferredCategoryViewHeight]);
    self.listContainerView.frame = CGRectMake(0, NavigationContentTopConstant + self.dateViewHeight + [self preferredCategoryViewHeight], SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationContentTopConstant + self.dateViewHeight + [self preferredCategoryViewHeight]));
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@100);
        make.height.equalTo(@100);
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view);
    }];
}

// 返回列表的数量
- (NSInteger)numberOfListsInlistContainerView:(JXCategoryListContainerView *)listContainerView {
    
    if (self.viewModel.listData.count > 0) {
        return self.viewModel.listData[self.SelectRow].list.count;
    } else {
        return 0;
    }
}

// 根据下标 index 返回对应遵守并实现 `JXCategoryListContentViewDelegate` 协议的列表实例
- (id<JXCategoryListContentViewDelegate>)listContainerView:(JXCategoryListContainerView *)listContainerView initListForIndex:(NSInteger)index {
    
    MovieTimeResultViewController *movieTimeResultViewController = [MovieTimeResultViewController viewControllerWithViewModelName:@"MovieTimeResultViewModel" parameter:@{@"listItem":self.viewModel.listData[self.SelectRow].list[index].data}];
    return movieTimeResultViewController;
}

- (MovieDateView *)dateView {
    return HT_LAZY(_dateView, ({
        [MovieDateView bindViewWithViewModel:self.viewModel];
    }));
}

// 分页菜单视图
- (JXCategoryTitleView *)categoryView {
    if (!_categoryView) {
        _categoryView = [[JXCategoryTitleView alloc] init];
        _categoryView.delegate = self;
        JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
        lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
        // 可以试试宽度补偿
        //        lineView.indicatorWidthIncrement = 10;
        _categoryView.indicators = @[lineView];
        
        // !!!: 将列表容器视图关联到 categoryView
        _categoryView.listContainer = self.listContainerView;
    }
    return _categoryView;
}

// 列表容器视图
- (JXCategoryListContainerView *)listContainerView {
    if (!_listContainerView) {
        _listContainerView = [[JXCategoryListContainerView alloc] initWithType:JXCategoryListContainerType_ScrollView delegate:self];
    }
    return _listContainerView;
}

@end
