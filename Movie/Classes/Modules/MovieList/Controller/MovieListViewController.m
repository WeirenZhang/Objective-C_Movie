//
//  MovieListViewController.m
//  Movie
//
//  Created by User on 2024/11/10.
//

#import "MovieListViewController.h"
#import "UIScrollView+EmptyDataSet.h"

@interface MovieListViewController () <DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

/// 列表
@property (strong, nonatomic) UITableView *listTableView;

@end

@implementation MovieListViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant) style:UITableViewStylePlain];
    self.listTableView.estimatedRowHeight = 44.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listTableView];
    
    @weakify(self);
    
    self.viewModel.page = 1;
    self.viewModel.noMore = false;
    // 上下拉刷新
    [self.listTableView addRefreshWithKaKaHeaderBlock:^{
        @strongify(self);
        self.viewModel.page = 1;
        self.viewModel.noMore = false;
        self.viewModel.requestCommand(@"list").execute(@[@(RefreshActionType_Refresh),self.viewModel.listItem.tab]);
    } withKaKaFooterBlock:^{
        @strongify(self);
        self.viewModel.requestCommand(@"list").execute(@[@(RefreshActionType_LoadMore),self.viewModel.listItem.tab]);
    }];
    
    // 监听列表数据
    self.viewModel.requestCommand(@"list").subscribeAll(^(id  _Nonnull value) {
        
    }, ^(NSError * _Nonnull error) {
        @strongify(self);
        NSLog(@"error %@d", error);
        self.viewModel.emptyType = EmptyType_NetworkError;
        [self.listTableView reloadData];
    }, ^(id  _Nonnull value) {
        @strongify(self);
        if (![value boolValue]) {
            if (self.viewModel.listData.count == 0) {
                self.viewModel.emptyType = EmptyType_NoData;
            }
            //self.viewModel.emptyType = EmptyType_OneAction;
            [self.listTableView endRefresh];
            if (self.viewModel.noMore) {
                [self.listTableView noMore];
            } else {
                [self.listTableView resumeRefreshAvailable];
            }
            [self.listTableView reloadData];
        }
    });
    self.viewModel.requestCommand(@"list").execute(@[@(RefreshActionType_Refresh),self.viewModel.listItem.tab]);
    
    self.listTableView.footRefreshControl.autoRefreshOnFoot = YES;
    [self.listTableView.headRefreshControl beginRefreshing];
    
    self.listTableView.emptyDataSetSource = self;
    self.listTableView.emptyDataSetDelegate = self;
}

#pragma mark - DZNDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.viewModel.emptyType == EmptyType_NoData) {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"暫時無資訊"];
        //[text addAttribute:NSFontAttributeName value:[UIFont wtkNormalFont:24] range:NSMakeRange(0, 4)];
        
        return text;
    } else {
        return nil;
    }
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.viewModel.emptyType == EmptyType_NoData) {
        return [UIImage imageNamed:@"ic_nodata"];
    } else {
        return nil;
    }
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor clearColor];
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    
    return YES;
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.listTableView];
}

#pragma mark - Bind
- (void)bindViewModelDidLoad{
    
    self.title = self.viewModel.listItem.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    MovieListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MovieListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    MovieListModel *listItem = self.viewModel.listData[indexPath.row];
    [cell bindViewModel:listItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieListViewCell *listItem = self.viewModel.listData[indexPath.row];
    if (!listItem) { return; }
    self.viewModel.requestCommand(@"push").execute(listItem);
}

/*
#pragma mark - Getter
- (UITableView *)listTableView {
    return HT_LAZY(_listTableView, ({
        UITableView *tableView = [UITableView ht_tableViewWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant)
                                                              style:UITableViewStylePlain
                                                      tableViewData:self.viewModel
                                                        cellClasses:@[MovieListViewCell.class]
                                            headerFooterViewClasses:nil
                                                  delegateConfigure:[self tableViewConfigure]];
        //tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
        tableView.backgroundColor = UIColor.whiteColor;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.estimatedRowHeight = 44.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        tableView;
    }));
}
*/

/*
- (void (^)(HTTableViewDelegateConfigure *configure))tableViewConfigure{
    @weakify(self);
    return
    ^(HTTableViewDelegateConfigure *configure) {
        
        configure.configNumberOfRowsInSection(^NSInteger(UITableView *tableView, NSInteger section){
            @strongify(self);
            return self.viewModel.listData.count;
        }).configCellClassForRow(^Class(id cellData, NSIndexPath *indexPath) {
            return MovieListViewCell.class;
        }).configDidSelectRowAtIndexPath(^(UITableView *tableView, NSIndexPath *indexPath) {
            @strongify(self);
            MovieListModel *listItem = self.viewModel.listData[indexPath.row];
            if (!listItem) { return; }
            self.viewModel.requestCommand(@"push").execute(listItem);
        }).configEmtyView(^(UITableView *tableView, UIView *emtyContainerView) {
            @strongify(self);
            
            
        });
    };
}
*/

@end
