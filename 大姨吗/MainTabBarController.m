//
//  MainTabBarController.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainViewController.h"
#import "CalenderViewController.h"
#import "LoveBuyViewController.h"
#import "SisterComponentViewController.h"
#import "MyViewController.h"

@interface MainTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MainTabBarController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [self buildTabbarController];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self addSignView];
    });
}

- (void)buildTabbarController {

    [self addChildViewController:[MainViewController new]image:[UIImage imageNamed:@"首页"]selectedImage:[UIImage imageNamed:@"Home_selected"] tag:0];
}

- (void)addChildViewController:(UIViewController *)viewController image:(UIImage *)image selectedImage:(UIImage *)selectedImage tag:(NSInteger)tag {

    UITabBarItem *item = [[UITabBarItem alloc]init];
    item.image = image;
    item.title = nil;
    item.tag = tag;
    item.imageInsets = UIEdgeInsetsMake(7, 0, -7, 0);
    item.selectedImage = selectedImage;
    viewController.tabBarItem = item;
//    MainNaviViewController *navController = [[MainNaviViewController alloc]initWithRootViewController:viewController];
//    [self addChildViewController:navController];

}

@end
