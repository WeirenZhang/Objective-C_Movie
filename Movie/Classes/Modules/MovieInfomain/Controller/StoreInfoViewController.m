//
//  StoreInfoViewController.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "StoreInfoViewController.h"
#import "StoreInfoModel.h"

@interface StoreInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation StoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant) style:UITableViewStylePlain];
    self.listTableView.estimatedRowHeight = 44.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
            //self.viewModel.emptyType = EmptyType_OneAction;
            [self.listTableView endRefresh];
            [self.listTableView reloadData];
        }
    });
    
    self.viewModel.requestCommand(@"list").execute(@[@(RefreshActionType_Refresh),self.viewModel.listItem.id]);
    [self.listTableView.headRefreshControl beginRefreshing];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    StoreInfoModel *listItem = self.viewModel.listData[indexPath.row];
    cell.textLabel.text = listItem.storeInfo;
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font =[UIFont systemFontOfSize:20];
    cell.backgroundColor = [UIColor whiteColor];
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

@end
