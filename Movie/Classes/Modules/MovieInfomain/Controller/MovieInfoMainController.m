//
//  MovieInfoMainController.m
//  Movie
//
//  Created by User on 2024/11/21.
//

#import "MovieInfoMainController.h"
#import "MovieInfoViewController.h"
#import "StoreInfoViewController.h"
#import "MovieTimeTabsViewControlle.h"
#import "VideoViewController.h"
#import "SQliteDAO.h"
#import "MBProgressHUD.h"

@interface MovieInfoMainController () <UITabBarControllerDelegate>

@property (nonatomic, strong) SQliteDAO *SQliteDAO;

@end

@implementation MovieInfoMainController

- (void)favorites {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    if ([self.SQliteDAO saveMovieModel:self.viewModel.listItem]) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MovieMyFavourite"
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
  
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateNormal];
    [rightBtn setImage:[UIImage systemImageNamed:@"heart"] forState:UIControlStateHighlighted];
    [rightBtn sizeToFit];   //按钮自适应大小
    [rightBtn addTarget:self action:@selector(favorites) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.delegate = self;
    
    self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.tintColor = UIColorMake(255, 85, 85);
    
    /// 添加子控制器
    [self.view addSubview:self.tabBarController.view];
    [self addChildViewController:self.tabBarController];
    [self addChileVC];
}

#pragma mark - Bind
- (void)bindViewModelDidLoad{
    
    self.title = self.viewModel.listItem.title;
}

- (void)addChileVC
{
    
    MovieInfoViewController *movieInfoViewController = [MovieInfoViewController viewControllerWithViewModelName:@"MovieInfoViewModel" parameter:@{@"listItem":self.viewModel.listItem}];
    UIViewController *nav1 = [self setChildVC:movieInfoViewController title:@"電影資料" imageName:@"movieclapper" withSelectedName:@"movieclapper.fill"];
    
    StoreInfoViewController *storeInfoViewController = [StoreInfoViewController viewControllerWithViewModelName:@"StoreInfoViewModel" parameter:@{@"listItem":self.viewModel.listItem}];
    UIViewController *nav2 =  [self setChildVC:storeInfoViewController title:@"劇情簡介" imageName:@"doc.text" withSelectedName:@"doc.text.fill"];
    
    MovieTimeTabsViewControlle *movieTimeTabsViewControlle = [MovieTimeTabsViewControlle viewControllerWithViewModelName:@"MovieTimeTabsViewModel" parameter:@{@"listItem":self.viewModel.listItem}];
    UIViewController *nav3 =   [self setChildVC:movieTimeTabsViewControlle title:@"播放時間" imageName:@"clock" withSelectedName:@"clock.fill"];
    
    VideoViewController *videoViewController = [VideoViewController viewControllerWithViewModelName:@"VideoViewModel" parameter:@{@"listItem":self.viewModel.listItem}];
    UIViewController *nav4 =  [self setChildVC:videoViewController title:@"預告片" imageName:@"video" withSelectedName:@"video.fill"];
    
    self.tabBarController.viewControllers = @[nav1,nav2,nav3,nav4];
}

- (UIViewController *)setChildVC:(UIViewController *)vc title:(NSString *)title imageName:(NSString *)imgName withSelectedName:(NSString *)selectedName
{
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:imgName];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedName];
    
    NSDictionary *textAttributes1 = @{NSFontAttributeName:textFontPingFangRegularFont(18),
                                      NSForegroundColorAttributeName: UIColorMake(138, 138, 138)};
    [vc.tabBarItem setTitleTextAttributes:textAttributes1 forState:UIControlStateNormal];
    
    NSDictionary *textAttributes2 = @{NSFontAttributeName:textFontPingFangRegularFont(18),
                                      NSForegroundColorAttributeName: UIColorMake(255, 85, 85)};
    [vc.tabBarItem setTitleTextAttributes:textAttributes2 forState:UIControlStateSelected];
    
    return vc;
}

@end
