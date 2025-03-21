//
//  UIViewController+VinKit.m
//  VinBaseComponents
//
//  Created by vin on 2021/5/26.
//

#import "UIViewController+VinKit.h"
#import <VinBaseComponents/VVRunTimeMethods.h>


@implementation UIViewController (VinKit)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 重新实现viewDidLoad ，内部会先调用父类的 viewDidLoad 方法
        vv_ExtendImplementationOfVoidMethodWithoutArguments([UIViewController class], @selector(viewDidLoad), ^(UIViewController *selfObject) {
            !selfObject.vv_viewDidLoadBlock ?: selfObject.vv_viewDidLoadBlock(selfObject);
        });
        
        // 重新实现viewWillAppear: ，内部会先调用父类的 viewWillAppear: 方法
        vv_ExtendImplementationOfVoidMethodWithSingleArgument([UIViewController class], @selector(viewWillAppear:), BOOL, ^(UIViewController *selfObject, BOOL animated) {
            !selfObject.vv_viewWillAppearBlock ?: selfObject.vv_viewWillAppearBlock(selfObject, animated);
        });
        
        // 重新实现viewDidAppear: ，内部会先调用父类的 viewDidAppear: 方法
        vv_ExtendImplementationOfVoidMethodWithSingleArgument([UIViewController class], @selector(viewDidAppear:), BOOL, ^(UIViewController *selfObject, BOOL animated) {
            !selfObject.vv_viewDidAppearBlock ?: selfObject.vv_viewDidAppearBlock(selfObject, animated);
        });
        
        // 重新实现viewWillLayoutSubviews ，内部会先调用父类的 viewWillLayoutSubviews 方法
        vv_ExtendImplementationOfVoidMethodWithoutArguments([UIViewController class], @selector(viewWillLayoutSubviews), ^(UIViewController *selfObject) {
            !selfObject.vv_viewWillLayoutSubviewsBlock ?: selfObject.vv_viewWillLayoutSubviewsBlock(selfObject);
        });
        
        // 重新实现viewDidLayoutSubviews ，内部会先调用父类的 viewDidLayoutSubviews 方法
        vv_ExtendImplementationOfVoidMethodWithoutArguments([UIViewController class], @selector(viewDidLayoutSubviews), ^(UIViewController *selfObject) {
            !selfObject.vv_viewDidLayoutSubviewsBlock ?: selfObject.vv_viewDidLayoutSubviewsBlock(selfObject);
        });
        
        // 重新实现viewWillDisappear: ，内部会先调用父类的 viewWillDisappear: 方法
        vv_ExtendImplementationOfVoidMethodWithSingleArgument([UIViewController class], @selector(viewWillDisappear:), BOOL, ^(UIViewController *selfObject, BOOL animated) {
            !selfObject.vv_viewWillDisappearBlock ?: selfObject.vv_viewWillDisappearBlock(selfObject, animated);
        });
        
        // 重新实现viewDidDisappear: ，内部会先调用父类的 viewDidDisappear: 方法
        vv_ExtendImplementationOfVoidMethodWithSingleArgument([UIViewController class], @selector(viewDidDisappear:), BOOL, ^(UIViewController *selfObject, BOOL animated) {
            !selfObject.vv_viewDidDisappearBlock ?: selfObject.vv_viewDidDisappearBlock(selfObject, animated);
        });
        
    });
}


+ (UIViewController *)vv_currentViewController {
    //UIViewController *vc = [UIApplication sharedApplication].delegate.window.rootViewController;
    UIViewController *vc = nil;
    UIScene *scene = [[[[UIApplication sharedApplication] connectedScenes] allObjects] firstObject];
    if([scene.delegate conformsToProtocol:@protocol(UIWindowSceneDelegate)]){
        UIWindow *window = [(id <UIWindowSceneDelegate>)scene.delegate window];
        vc = window.rootViewController;
    }
    
    while (true) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            if (![vc isKindOfClass:[UITabBarController class]] &&
                ![vc isKindOfClass:[UINavigationController class]]) {
                break;
            }
        }
    }
    return vc;
}

- (nullable UIViewController *)vv_childViewControllerWithName:(NSString *)name {
    __block UIViewController *vc;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([NSStringFromClass(obj.class) isEqualToString:name]) {
            vc = obj;
            *stop = YES;
        }
    }];
    return vc;
}


#pragma mark - Bind
- (void)setVv_viewDidLoadBlock:(void (^)(UIViewController *))vv_viewDidLoadBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewDidLoadBlock),
                             vv_viewDidLoadBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *))vv_viewDidLoadBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setVv_viewWillAppearBlock:(void (^)(UIViewController *, BOOL))vv_viewWillAppearBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewWillAppearBlock),
                             vv_viewWillAppearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *, BOOL))vv_viewWillAppearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setVv_viewDidAppearBlock:(void (^)(UIViewController *, BOOL))vv_viewDidAppearBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewDidAppearBlock),
                             vv_viewDidAppearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *, BOOL))vv_viewDidAppearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setVv_viewWillLayoutSubviewsBlock:(void (^)(UIViewController *))vv_viewWillLayoutSubviewsBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewWillLayoutSubviewsBlock),
                             vv_viewWillLayoutSubviewsBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *))vv_viewWillLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setVv_viewDidLayoutSubviewsBlock:(void (^)(UIViewController *))vv_viewDidLayoutSubviewsBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewDidLayoutSubviewsBlock),
                             vv_viewDidLayoutSubviewsBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *))vv_viewDidLayoutSubviewsBlock {
    return objc_getAssociatedObject(self, _cmd);
}


- (void)setVv_viewWillDisappearBlock:(void (^)(UIViewController *, BOOL))vv_viewWillDisappearBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewWillDisappearBlock),
                             vv_viewWillDisappearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *, BOOL))vv_viewWillDisappearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setVv_viewDidDisappearBlock:(void (^)(UIViewController *, BOOL))vv_viewDidDisappearBlock {
    objc_setAssociatedObject(self,
                             @selector(vv_viewDidDisappearBlock),
                             vv_viewDidDisappearBlock,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void (^)(UIViewController *, BOOL))vv_viewDidDisappearBlock {
    return objc_getAssociatedObject(self, _cmd);
}

@end
