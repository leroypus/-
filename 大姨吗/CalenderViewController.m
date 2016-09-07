//
//  CalenderViewController.m
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "CalenderViewController.h"
#import <JTCalendar/JTCalendar.h>
#import <Masonry/Masonry.h>

@interface CalenderViewController ()<JTCalendarDelegate,UITableViewDelegate, UITableViewDataSource> {

    NSMutableDictionary *_eventsByDate;
    NSMutableArray *_dateSelected;
    
    NSDate *_todayDate;
}

@end

@implementation CalenderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"日历";
        UIImage *image = [[UIImage imageNamed:@"日历"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
        [self.tabBarItem setImage:image];

    }
    
    return self;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    _calendarManager = [JTCalendarManager new];
    _calendarManager.delegate = self;
    
   //CalendarVIewCell *calendarViewCell = [[CalendarVIewCell alloc]init];
    
    self.calendarMenuView = ({
        JTCalendarMenuView *view = [JTCalendarMenuView new];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.view.mas_top);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.height.mas_equalTo(60.0f);
        }];
        view;
    });
    
    _contentView = ({
        UIScrollView *view1 = [UIScrollView new];
        [self.view addSubview:view1];
        [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.calendarMenuView.mas_bottom);
            make.left.mas_equalTo(self.view.mas_left);
            make.right.mas_equalTo(self.view.mas_right);
            make.bottom.mas_equalTo(self.view.mas_bottom);
        }];
        view1;
    });
    
    
    // 是否允许单周显示，显示未一周
//    _calendarManager.settings.pageViewHaveWeekDaysView = YES;
//    _calendarManager.settings.pageViewNumberOfWeeks = 1;
//    [_calendersContentView addSubview:self.calendarContentView];
    [_contentView addSubview:self.tableView];
    [_calendarManager setMenuView:self.calendarMenuView];
    [_calendarManager setContentView:self.calendarContentView];
    [_calendarManager setDate:[NSDate date]];
    [self.tableView.tableHeaderView addSubview:self.calendarContentView];
}

#pragma mark - CalendarManager delegate


// 这个方法是用来管理天视图的设计对于那些特殊的日子，这个方法被调用的时候是天发生了变化
- (void)calendar:(JTCalendarManager *)calendar prepareDayView:(JTCalendarDayView *)dayView {
    
    dayView.hidden = NO;
    
    if([dayView isFromAnotherMonth]){
        dayView.hidden = NO;
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    // Today
    else if([_calendarManager.dateHelper date:[NSDate date] isTheSameDayThan:dayView.date]){
        
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor redColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else if (_dateSelected && [_calendarManager.dateHelper date:_dateSelected isTheSameDayThan:dayView.date]) {
        dayView.circleView.hidden = NO;
        dayView.circleView.backgroundColor = [UIColor blueColor];
        dayView.dotView.backgroundColor = [UIColor whiteColor];
        dayView.textLabel.textColor = [UIColor whiteColor];
    }
    else if (![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]) {
    
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor lightGrayColor];
    }
    // Another days of this month
    else {
        dayView.circleView.hidden = YES;
        dayView.dotView.backgroundColor = [UIColor redColor];
        dayView.textLabel.textColor = [UIColor blackColor];
    }

    
//    if ([self haveEventForDays:dayView.date]) {
//        dayView.dotView.hidden = NO;
//    }
//    else {
//    
//        dayView.dotView.hidden = YES;
//    }
}

- (void)calendar:(JTCalendarManager *)calendar didTouchDayView:(JTCalendarDayView *)dayView {

    // Use to indicate the selected date
    _dateSelected = dayView.date;
    
    // Animation for the circleView
    dayView.circleView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView transitionWithView:dayView
                      duration:.3
                       options:0
                    animations:^{
                        dayView.circleView.transform = CGAffineTransformIdentity;
                        [_calendarManager reload];
                    } completion:nil];
    
    // Load the previous or next page if touch a day from another month
    if(![_calendarManager.dateHelper date:_calendarContentView.date isTheSameMonthThan:dayView.date]){
        if([_calendarContentView.date compare:dayView.date] == NSOrderedAscending){
            [_calendarContentView loadNextPageWithAnimation];
        }
        else{
            [_calendarContentView loadPreviousPageWithAnimation];
        }
    }
}

//- (void)calendar:(JTCalendarManager *)calendar prepareMenuItemView:(UIView *)menuItemView date:(NSDate *)date {
//
//    
//}

#pragma mark - DateSelected 


#pragma mark - Fake date
//
//// used only to have a key for _events By day
//- (BOOL)haveEventForDay:(NSDate *)date {
//
//    _eventsByDate = [NSMutableDictionary new];
//    
//    for (int i = 0; i < 30; i ++) {
//        // 随机生成30随机数
//        NSDate *randomDate = [NSDate dateWithTimeInterval:(rand() % (3600 * 24 * 60)) sinceDate:[NSDate date]];
//        
//        // Use the date as key for eventsByDate
//        NSString *key = [[self dateWithF]];
//    }
//}

#pragma mark - 动作
- (void)didGoTodayTouch {

    [_calendarManager setDate:_todayDate];
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
    
     NSIndexPath *indexPath = [[NSIndexPath alloc]initWithIndex:section];
    if (indexPath.section == 0) {
        return 50.0f;
    }
    if (indexPath.section == 1) {
        return 50.0f;
    }
    else{
        
        return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    UIView *view = [[UIView alloc]init];
    if (section == 1) {
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label =[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 30)];
        [label setText:@"习惯"];

        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5, 20, 20)];
        image.image = [UIImage imageNamed:@"习惯"];
        
//        RadioButton *radioButton = [[RadioButton alloc]initWithFrame:CGRectMake(300, 10, 20, 20)];
//        radioButton.selected = YES;
        
        [view addSubview:image];
        [view addSubview:label];
//        [view addSubview:radioButton];
    }
    return view;
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
                UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 13, 150, 20)];
                label.text = @"自定义记录项";
                [cell addSubview:label];
                UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"添加新的"]];
                image.frame = CGRectMake(120, 13, 15, 15);
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
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 380, 600) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableHeaderView = self.tableHeaderView;
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (UIView *)tableHeaderView {
    
    if (!_tableHeaderView) {
        _tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 220)];
        _tableHeaderView.backgroundColor = [UIColor whiteColor];
    }
    return _tableHeaderView;
}

- (JTHorizontalCalendarView *)calendarContentView {

    if (!_calendarContentView) {
        _calendarContentView = [[JTHorizontalCalendarView alloc]initWithFrame:CGRectMake(0, 0, 380, 220)];
        _calendarContentView.backgroundColor = [UIColor whiteColor];
    }
    return _calendarContentView;
}

@end
