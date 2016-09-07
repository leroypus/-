//
//  LoveBuyViewController.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "LoveBuyViewController.h"

@implementation LoveBuyViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"姨吗爱买";
        UIImage *image = [[UIImage imageNamed:@"姨吗爱买"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        [self.tabBarItem setImage:image];
    }
    return self;
}

@end
