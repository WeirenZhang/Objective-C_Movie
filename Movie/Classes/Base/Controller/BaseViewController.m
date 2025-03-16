//
//  HTBaseViewController.m
//  HeartTrip
//
//  Created by vin on 2021/5/26.
//  Copyright © 2021 Vin. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@property (nonatomic,strong) id parameter;
@property (nonatomic,strong) id viewModel;
@end

@implementation BaseViewController

#pragma mark - HTViewControllerProtocol
+ (instancetype)viewControllerWithViewModelName:(NSString * _Nullable)viewModelName
                                      parameter:(id _Nullable)parameter {
    
    BaseViewController *controller = [[self alloc] init];
    controller.parameter = parameter;
    if (viewModelName.length) {
        
        Class viewModelClass = NSClassFromString(viewModelName);
        
        if (vv_ProtocolAndSelector(viewModelClass,
                                   @protocol(ViewModelProtocol),
                                   @selector(viewModelWithParameter:))) {
            
            controller.vv_viewDidLoadBlock = ^(UIViewController * _Nonnull _self) {
                
                BaseViewController *vc = (id)_self;
                id<ViewModelProtocol> viewModel = [viewModelClass viewModelWithParameter:parameter];
                vc.viewModel = viewModel;
                if ([viewModel respondsToSelector:sel_registerName("setViewModelController:")]) {
                    ((void(*)(id, SEL, id))objc_msgSend)(viewModel, sel_registerName("setViewModelController:"), vc);
                }
                if (vv_ProtocolAndSelector(viewModel,
                                           @protocol(ViewModelProtocol),
                                           @selector(viewModelLoad))) {
                    [vc bindViewModelWillLoad];
                    [viewModel viewModelLoad];
                }
            };
            controller.vv_viewWillAppearBlock = ^(UIViewController * _Nonnull _self, BOOL animated) {
                [(UIViewController<ViewControllerProtocol> *)_self bindViewModelDidLoad];
            };
        }
    }
    return controller;
}

- (void)bindViewModelWillLoad {}
- (void)bindViewModelDidLoad {}
- (void)viewDidLoad {[super viewDidLoad]; self.view.backgroundColor = UIColor.whiteColor;}
- (void)popFromViewController:(NSString *)controllerName parameter:(NSDictionary *)parameter {}
- (void)dissmissFromViewController:(NSString *)controllerName parameter:(NSDictionary *)parameter {}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
- (void)dealloc {
    //DDLogDebug(@"%@已销毁", NSStringFromClass([self class]));
    if (![self isMemberOfClass:BaseViewController.class] &&
        [NSStringFromClass(self.class) hasSuffix:@"BaseViewController_"]) {
        Class cls = self.class;
        objc_disposeClassPair(cls);
    }
}

@end
