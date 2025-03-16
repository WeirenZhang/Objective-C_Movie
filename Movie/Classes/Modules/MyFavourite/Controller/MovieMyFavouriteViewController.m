//
//  MovieMyFavouriteViewController.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MovieMyFavouriteViewController.h"
#import "MovieListViewCell.h"
#import "MovieListModel.h"
#import "UIScrollView+EmptyDataSet.h"

@interface MovieMyFavouriteViewController () <UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

@end

@implementation MovieMyFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.SQliteDAO = [[SQliteDAO alloc] init];
    
    // Do any additional setup after loading the view.
    self.listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTopConstant, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTopConstant) style:UITableViewStylePlain];
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
    self.listTableView.estimatedRowHeight = 44.0;
    self.listTableView.rowHeight = UITableViewAutomaticDimension;
    self.listTableView.backgroundColor = [UIColor whiteColor];
    
    self.listData = [[NSMutableArray alloc] init];
    [self.listData addObjectsFromArray:[self.SQliteDAO getAllMovieModels]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(UpdateMovieMyFavourite:)
                                                 name:@"MovieMyFavourite" object:nil];
    
    self.listTableView.emptyDataSetSource = self;
    self.listTableView.emptyDataSetDelegate = self;
}

- (void)UpdateMovieMyFavourite:(NSNotification*)not
{
    [self.listData removeAllObjects];
    [self.listData addObjectsFromArray:[self.SQliteDAO getAllMovieModels]];
    [self.listTableView reloadData];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    [self.view addSubview:self.listTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"Cell";
    MovieListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[MovieListViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    MovieListModel *listItem = self.listData[indexPath.row];
    [cell.discard addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    [cell.discard setTag:indexPath.row];
    cell.style = @"MyFavourite";
    [cell bindViewModel:listItem];
    UIView *selectedView = [[UIView alloc]init];
    selectedView.backgroundColor = [UIColor colorWithRed:209/255.0 green:209/255.0 blue: 213/255.0 alpha:1.0];
    cell.selectedBackgroundView = selectedView;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MovieListModel *listItem = self.listData[indexPath.row];
    if (!listItem) { return; }
    self.viewModel.requestCommand(@"push").execute(listItem);
}

- (void)delete:(id)sender
{
    MovieListModel *listItem = self.listData[[sender tag]];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"是否要刪除 %@？", listItem.title] preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"確定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if ([self.SQliteDAO removeMovieModel:listItem]) {
            [self.listData removeObjectAtIndex:[sender tag]];  //删除数组里的数据
            [self.listTableView reloadData];  //删除对应数据的cell
        }
    }];
    UIAlertAction *canselAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertController addAction:okAction];
    [alertController addAction:canselAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - DZNDelegate
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.listData.count == 0) {
        NSMutableAttributedString *text = [[NSMutableAttributedString alloc]initWithString:@"無資料"];
        //[text addAttribute:NSFontAttributeName value:[UIFont wtkNormalFont:24] range:NSMakeRange(0, 4)];
        
        return text;
    } else {
        return nil;
    }
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    if (self.listData.count == 0) {
        return [UIImage imageNamed:@"ic_nodata"];
    } else {
        return nil;
    }
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
{
    return [UIColor clearColor];
}

@end
