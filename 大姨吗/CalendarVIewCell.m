//
//  CalendarVIewCell.m
//  大姨吗
//
//  Created by wgj on 16/9/7.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "CalendarVIewCell.h"

@interface CalendarVIewCell()<UITableViewDataSource, UITableViewDelegate>
@end

@implementation CalendarVIewCell

//- (instancetype)init {
//    
//    self = [super init];
//    if (self) {
//        [self addSubview:self.tableView];
//    }
//    return self;
//}

- (void)viewDidLoad {

    [self addSubview:self.tableView];
}

#pragma mark - UITableViewDataSourc

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return 6;
    }
    if (section == 1) {
        return 4;
    }
    else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    if (section == 0) {
        return 50.0f;
    }
    if (section == 1) {
        return 50.0f;
    }
    else{
    
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"月经开始";
                cell.imageView.image = [UIImage imageNamed:@"月经开始"];
                UISwitch *switchView=[[UISwitch alloc]initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                switchView.on = YES;
                [cell addSubview:switchView];
                break;
            }
            case 1: {
                cell.textLabel.text = @"经期结束";
                cell.imageView.image = [UIImage imageNamed:@"经期结束"];
                UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                switchView.on = YES;
                [cell addSubview:switchView];
                break;
            }
            case 2: {
                cell.textLabel.text = @"月经详情";
                cell.imageView.image = [UIImage imageNamed:@"月经详情"];
                break;
            }
            case 3: {
                cell.textLabel.text = @"爱爱";
                cell.imageView.image = [UIImage imageNamed:@"爱爱"];
                UISwitch *switchView = [[UISwitch alloc]initWithFrame:CGRectZero];
                cell.accessoryView = switchView;
                switchView.on = YES;
                [cell addSubview:switchView];
                break;
            }
            case 4: {
                cell.textLabel.text = @"体重";
                cell.imageView.image = [UIImage imageNamed:@"体重"];
                break;
            }
            case 5: {
                cell.textLabel.text = @"身体症状";
                cell.imageView.image = [UIImage imageNamed:@"身体症状"];
                break;
            }
            default:
                break;
        }
    }
    else if (indexPath.section == 1) {
    
        switch (indexPath.row) {
            case 0: {
                cell.textLabel.text = @"备注";
                cell.imageView.image = [UIImage imageNamed:@"备注"];
                break;
            }
            case 1: {
                cell.imageView.image = [UIImage imageNamed:@"记录更多东西"];
                break;
            }
            case 2: {
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 5, 150, 20)];
                label.text = @"自定义记录项";
                [cell addSubview:label];
                UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"添加更多"]];
                image.frame = CGRectMake(120, 5, 20, 20);
                [cell addSubview:image];
                break;
            }
            case 3: {
                cell.textLabel.text = @"添加待办事项";
                cell.imageView.image = [UIImage imageNamed:@"添加新的"];
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

#pragma mark - Properties

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {

    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 120)];
    }
    return _tableHeaderView;
}


@end
