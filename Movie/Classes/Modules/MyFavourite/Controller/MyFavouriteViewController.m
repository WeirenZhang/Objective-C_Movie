//
//  MyFavouriteViewController.m
//  Movie
//
//  Created by User on 2024/11/27.
//

#import "MyFavouriteViewController.h"
#import "MovieMyFavouriteViewController.h"
#import "TheaterMyFavouriteViewController.h"

@interface MyFavouriteViewController () <UITabBarControllerDelegate>

@end

@implementation MyFavouriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    MovieMyFavouriteViewController *movieMyFavouriteViewController = [MovieMyFavouriteViewController viewControllerWithViewModelName:@"MovieMyFavouriteViewModel" parameter:nil];
    UIViewController *nav1 = [self setChildVC:movieMyFavouriteViewController title:@"電影" imageName:@"movieclapper" withSelectedName:@"movieclapper.fill"];
    
    TheaterMyFavouriteViewController *theaterMyFavouriteViewController = [TheaterMyFavouriteViewController viewControllerWithViewModelName:@"TheaterMyFavouriteViewModel" parameter:nil];
    UIViewController *nav2 =  [self setChildVC:theaterMyFavouriteViewController title:@"電影院" imageName:@"popcorn" withSelectedName:@"popcorn.fill"];
    
    self.tabBarController.viewControllers = @[nav1,nav2];
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
