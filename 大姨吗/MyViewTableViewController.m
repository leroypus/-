//
//  MyViewTableViewController.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "MyViewTableViewController.h"
#import  <Masonry/Masonry.h>

@implementation MyViewTableViewController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {

    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor clearColor];
        
        _tableView = ({
            UITableView *view1 = [UITableView new];
            view1.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view1];
            [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.view.mas_top);
                make.left.mas_equalTo(self.view.mas_left);
                make.right.mas_equalTo(self.view.mas_right);
                make.bottom.mas_equalTo(self.view.mas_bottom);
            }];
            view1;
        });
        
        _tableHeaderView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.tableView.mas_top);
                make.left.mas_equalTo(self.view.mas_left);
                make.right.mas_equalTo(self.view.mas_right);
                make.height.mas_equalTo(80.0f);
            }];
            view;
        });
        
        _tableFooterView = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor whiteColor];
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.mas_equalTo(self.tableView.mas_bottom);
                make.left.mas_equalTo(self.view.mas_left);
                make.right.mas_equalTo(self.view.mas_right);
                make.height.mas_equalTo(200.0f);
            }];
            view;
        });
        
        _imageView = ({
            UIImageView *view = [UIImageView new];
            view.image = [UIImage imageNamed:@"背景"];
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.tableHeaderView.mas_top);
                make.left.mas_equalTo(self.view.mas_left);
                make.right.mas_equalTo(self.view.mas_right);
                make.height.mas_equalTo(80.0f);
            }];
            view;
        });
        
        _avaverImageView = ({
            UIImageView *view = [UIImageView new];
            view.image = [UIImage imageNamed:@"头像"];
            view.layer.cornerRadius = 35;
            view.layer.masksToBounds = YES;
            view.layer.borderWidth = 1.5f;
            [self.view addSubview:view];
            [view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self.tableHeaderView.mas_centerY);
                make.centerX.mas_equalTo(self.tableHeaderView.mas_centerX);
                make.size.mas_equalTo(CGSizeMake(70, 70));
            }];
            view;
        });

    }
    return self;
}

@end
