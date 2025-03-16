//
//  TheaterListController.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "TheaterListController.h"
#import "TheaterInfoCell.h"

@interface TheaterListController () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation TheaterListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant) style:UITableViewStylePlain];
    self.listTableView.estimatedRowHeight = 100.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.listTableView];
}

#pragma mark - Bind
- (void)bindViewModelDidLoad{
    
    self.title = self.viewModel.listItem.theater_top;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.listItem.theater_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    TheaterInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[TheaterInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    TheaterInfoModel *listItem = self.viewModel.listItem.theater_list[indexPath.row];
    [cell bindViewModel:listItem];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TheaterInfoModel *listItem = self.viewModel.listItem.theater_list[indexPath.row];
    if (!listItem) { return; }
    self.viewModel.requestCommand(@"push").execute(listItem);
}

@end
