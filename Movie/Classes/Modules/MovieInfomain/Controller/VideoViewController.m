//
//  VideoViewController.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "VideoViewController.h"
#import "MovieVideoCell.h"
#import "VideoModel.h"
#import "UIScrollView+EmptyDataSet.h"

@interface VideoViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation VideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant) style:UITableViewStylePlain];
    self.listTableView.estimatedRowHeight = 44.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    
    @weakify(self);
    // 上下拉刷新
    [self.listTableView addRefreshWithKaKaHeaderBlock:^{
        @strongify(self);
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

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.listTableView];
}

#pragma mark - Bind
- (void)bindViewModelDidLoad{
    
    //self.title = self.viewModel.listItem.title;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    MovieVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MovieVideoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    VideoModel *listItem = self.viewModel.listData[indexPath.row];
    [cell bindViewModel:listItem];
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *listItem = self.viewModel.listData[indexPath.row];
    if (!listItem) { return; }
    self.viewModel.requestCommand(@"push").execute(listItem);
}

@end
