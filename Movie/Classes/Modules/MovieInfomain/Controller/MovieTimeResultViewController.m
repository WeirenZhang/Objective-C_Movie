//
//  MovieTimeResultViewController.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieTimeResultViewController.h"
#import "MovieTimeResultCell.h"
#import "TheaterInfoModel.h"

@interface MovieTimeResultViewController () <UITableViewDelegate,UITableViewDataSource>

/// 列表
@property (strong, nonatomic) UITableView *listTableView;

@end

@implementation MovieTimeResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - (NavigationContentTopConstant + 60 + 50)) style:UITableViewStylePlain];
    self.listTableView.estimatedRowHeight = 44.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue: 247/255.0 alpha:1.0];
    self.listTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    
    [self.view addSubview:self.listTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.viewModel.listItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = [NSString stringWithFormat:@"Cell%@", self.viewModel.listItem[indexPath.row].id];
    
    MovieTimeResultCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier]; //出列可重用的cell
    if (cell == nil) {
        cell = [[MovieTimeResultCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        MovieTimeResultModel *listItem = self.viewModel.listItem[indexPath.row];
        
        cell.backgroundColor = [UIColor clearColor];
        cell.layer.cornerRadius = 0.25;
        cell.layer.borderWidth = 0;
        cell.layer.shadowColor = [[UIColor blackColor] CGColor];
        cell.layer.shadowOffset = CGSizeMake(0, 0);
        cell.layer.shadowRadius = 5;
        cell.layer.shadowOpacity = 0.1;
        cell.layer.masksToBounds = false;
        
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
    MovieTimeResultModel *listItem = self.viewModel.listItem[indexPath.row];
    if (!listItem) { return; }
    TheaterInfoModel *theaterInfoModel = [TheaterInfoModel new];
    theaterInfoModel.id = listItem.id;
    theaterInfoModel.name = listItem.theater;
    theaterInfoModel.adds = @"";
    theaterInfoModel.tel = @"";
    self.viewModel.requestCommand(@"push").execute(theaterInfoModel);
}

#pragma mark - JXCategoryListContentViewDelegate

/**
 实现 <JXCategoryListContentViewDelegate> 协议方法，返回该视图控制器所拥有的「视图」
 */
- (UIView *)listView {
    return self.view;
}

@end
