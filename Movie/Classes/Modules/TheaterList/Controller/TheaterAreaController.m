//
//  TheaterAreaController.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterAreaController.h"

@interface TheaterAreaController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation TheaterAreaController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    
    @weakify(self);
    // 上下拉刷新
    [self.listTableView addRefreshWithKaKaHeaderBlock:^{
        @strongify(self);
        self.viewModel.requestCommand(@"list").execute(@(RefreshActionType_Refresh));
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
    
    self.viewModel.requestCommand(@"list").execute(@(RefreshActionType_Refresh));
    [self.listTableView.headRefreshControl beginRefreshing];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    TheaterAreaModel *listItem = self.viewModel.listData[indexPath.row];
    cell.textLabel.text = listItem.theater_top;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheaterAreaModel *listItem = self.viewModel.listData[indexPath.row];
    if (!listItem) { return; }
    self.viewModel.requestCommand(@"push").execute(listItem);
}

@end
