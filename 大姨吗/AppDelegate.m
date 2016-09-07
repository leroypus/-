//
//  AppDelegate.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MainViewController.h"
#import "CalenderViewController.h"
#import "LoveBuyViewController.h"
#import "SisterComponentViewController.h"
#import "MyViewController.h"
#import "MainTabBarController.h"


@interface AppDelegate ()

@property (nonatomic, strong) UIImageView *maskView;
@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) CalenderViewController *calenderViewController;
@property (nonatomic, strong) LoveBuyViewController *loveBuyViewController;
@property (nonatomic, strong) SisterComponentViewController *sisterComponentViewController;
@property (nonatomic, strong) MyViewController *myViewController;
@property (nonatomic, strong) ViewController *viewController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    
//    self.maskView = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    self.maskView.image = [UIImage imageNamed:@"launch"];
//    self.maskView.contentMode = UIViewContentModeScaleAspectFill;
//    self.viewController = [[ViewController alloc]init];
//
//    [self.window addSubview:self.maskView];
//    self.maskView.userInteractionEnabled = YES;
    
    
    self.mainViewController = [[MainViewController alloc]init];
    self.calenderViewController = [[CalenderViewController alloc]init];
    self.loveBuyViewController = [[LoveBuyViewController alloc]init];
    self.sisterComponentViewController = [[SisterComponentViewController alloc]init];
    self.myViewController = [[MyViewController alloc]init];
    
    
    self.tabBarController = [[UITabBarController alloc]init];
    self.tabBarController.viewControllers = @[self.mainViewController, self.calenderViewController, self.loveBuyViewController, self.sisterComponentViewController, self.myViewController];
//    UITabBar *tabBar = [self.tabBarController tabBar];

    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 400, 49)];
    backView.backgroundColor = [UIColor blackColor];
    [self.tabBarController.tabBar insertSubview:backView atIndex:0];
//    self.tabBarController.tabBar.opaque = YES;
//    [tabBar setBackgroundColor:[UIColor blackColor]];
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyWindow];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
