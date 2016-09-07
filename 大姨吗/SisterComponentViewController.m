//
//  SisterComponentViewController.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "SisterComponentViewController.h"
#import "MyViewCollectionViewController.h"

@implementation SisterComponentViewController

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
        self.tabBarItem.title = @"姐妹说";
        UIImage *image = [[UIImage imageNamed:@"姐妹说"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        [self.tabBarItem setImage:image];

    }
    return self;
}

@end
