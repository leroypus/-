//
//  CalenderViewController.h
//  大姨吗
//
//  Created by wgj on 16/9/2.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JTCalendar/JTCalendar.h>

@interface CalenderViewController : UIViewController

// 这个表示月份的名字
@property (nonatomic, strong) JTCalendarMenuView *calendarMenuView;
// 这个代表日历本身
@property (nonatomic, strong) JTHorizontalCalendarView *calendarContentView;

// 用来协调之前的两个定义，并且使得
@property (nonatomic, strong) JTCalendarManager *calendarManager;

//@property (nonatomic, strong) CalendarVIewCell *calendarViewCell;

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIScrollView *calendersContentView;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *tableHeaderView;


@end
