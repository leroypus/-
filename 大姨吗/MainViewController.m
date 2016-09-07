//
//  MainViewController.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "MainViewController.h"
#import "PrefixHeader.pch"

// 3rd frameworks
#import <Masonry/Masonry.h>

@interface MainViewController()
@end

@implementation MainViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
   self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"首页";
        UIImage *image = [[UIImage imageNamed:@"首页"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        [self.tabBarItem setImage:image];
        self.view.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    // layout subviews
//    WEAKSELF
}


@end
