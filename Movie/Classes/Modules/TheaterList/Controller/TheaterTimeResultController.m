//
//  TheaterTimeResultController.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterTimeResultController.h"
#import "TheaterDateView.h"
#import "TheaterTimeResultCell.h"
#import "MovieListModel.h"
#import "SQliteDAO.h"
#import "MBProgressHUD.h"
#import "UIScrollView+EmptyDataSet.h"

@interface TheaterTimeResultController () <UITableViewDelegate,UITableViewDataSource,DateViewProtocol,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
/// 列表
@property (strong, nonatomic) UITableView *listTableView;
/// banner
@property (strong, nonatomic) TheaterDateView *dateView;

@property (nonatomic,assign) CGFloat dateViewHeight;

@property (nonatomic,assign) NSInteger SelectRow;

@property (nonatomic, strong) SQliteDAO *SQliteDAO;

/// Disposable数组
@property (strong, nonatomic) NSMutableArray<RACDisposable *> *disposees;

@end

@implementation TheaterTimeResultController

- (void)favorites {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    if ([self.SQliteDAO saveTheaterModel:self.viewModel.listItem]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TheaterMyFavourite"
                                                            object: nil];
        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = NSLocalizedString(@"加入最愛中...", @"HUD message title");
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        [hud hideAnimated:YES afterDelay:1.f];
    } else {

        // Set the text mode to show only text.
        hud.mode = MBProgressHUDModeText;
        hud.label.text = NSLocalizedString(@"已加入最愛", @"HUD message title");
        // Move to bottm center.
        hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
        [hud hideAnimated:YES afterDelay:1.f];
    }
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.SQliteDAO = [[SQliteDAO alloc]init];
    
    self.dateViewHeight = 60;
    self.SelectRow = 0;
    
    self.dateView.delegate = self;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateHighlighted];
    [rightBtn sizeToFit];   //按钮自适应大小
    [rightBtn addTarget:self action:@selector(favorites) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant+self.dateViewHeight, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant-self.dateViewHeight) style:UITableViewStylePlain];
    self.listTableView.estimatedRowHeight = 44.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.listTableView];
    [self.view addSubview:self.dateView];
    
    @weakify(self);
    // 上下拉刷新
    [self.listTableView addRefreshWithKaKaHeaderBlock:^{
        @strongify(self);
        self.dateView.dateButton.userInteractionEnabled = NO;
        self.viewModel.requestCommand(@"list").execute(@[@(RefreshActionType_Refresh),self.viewModel.listItem.id]);
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
            [self.listTableView reloadData];
        }
    });
    
    self.viewModel.requestCommand(@"list").execute(@[@(RefreshActionType_Refresh),self.viewModel.listItem.id]);
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

- (void)SetDateViewHeight:(CGFloat)height {
    self.dateViewHeight = height;
    [self viewDidLayoutSubviews];
}

- (void)SetSelectRow:(NSInteger)index {
    self.SelectRow = index;
    [self.listTableView reloadData];
}


#pragma mark - Bind
- (void)bindViewModelDidLoad
{
    
    self.title = self.viewModel.listItem.name;
}

- (void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    self.dateView.rectValue(0, NavigationContentTopConstant, SCREEN_WIDTH, self.dateViewHeight);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (self.viewModel.listData.count > 0) {
        return self.viewModel.listData[self.SelectRow].data.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%@%@", self.dateView.dateButton.currentTitle, [self.viewModel.listData objectAtIndex:self.SelectRow].data[indexPath.row].id];
    
    TheaterTimeResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; //出列可重用的cell
    if (cell == nil) {
        cell = [[TheaterTimeResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        TheaterTimeResultModel *listItem = self.viewModel.listData[self.SelectRow].data[indexPath.row];
        cell.frame = tableView.bounds;
        [cell layoutIfNeeded];
        [cell bindViewModel:listItem];
    }
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    TheaterTimeResultModel *listItem = self.viewModel.listData[self.SelectRow].data[indexPath.row];
    if (!listItem) { return; }
    MovieListModel *movieListModel = [MovieListModel new];
    movieListModel.title = listItem.theaterlist_name;
    movieListModel.thumb = listItem.release_foto;
    movieListModel.id = listItem.id;
    movieListModel.en = @"";
    movieListModel.release_movie_time = @"";
    self.viewModel.requestCommand(@"push").execute(movieListModel);
}

- (TheaterDateView *)dateView {
    return HT_LAZY(_dateView, ({
        [TheaterDateView bindViewWithViewModel:self.viewModel];
    }));
}

- (NSMutableArray<RACDisposable *> *)disposees{
    return HT_LAZY(_disposees, @[].mutableCopy);
}
- (void)dealloc{
    [self.disposees makeObjectsPerformSelector:@selector(dispose)];
}

@end
