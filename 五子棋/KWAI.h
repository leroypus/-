//
//  KWAI.h
//  五子棋
//
//  Created by wgj on 16/8/26.
//  Copyright © 2016年 wgj. All rights reserved.
//  讲的是上下左下和右下的遍历

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "KWPoint.h"

typedef NS_ENUM(NSInteger, OccupyType) {
    OccupyTypeEmpty = 0,
    OccupyTypeUser,
    OccupyTypeAI ,
    OccupyTypeUnknown,
};

@interface KWPointData : NSObject

@property (nonatomic, strong) KWPoint *p;
// 达到出现的连子数目
@property (nonatomic, assign) int count;

- (id)initWithPoint:(KWPoint *)point count:(int)count;

@end

@interface KWOmni : NSObject

// 所有子的信息
@property (nonatomic, strong) NSMutableArray *curBoard;
@property (nonatomic, assign) OccupyType oppType;
@property (nonatomic, assign) OccupyType myType;

- (id)initWithArr:(NSMutableArray *)arr opp:(OccupyType)opp my:(OccupyType)my;
- (BOOL)isStepEmergent:(KWPoint *)pp Num:(int)num type:(OccupyType)xType;


@end

@interface KWAI : NSObject

+ (KWPoint *)geablog:(NSMutableArray *)board type:(OccupyType)type;
+ (KWPoint *)SearphTheGreat:(NSMutableArray *)board type:(OccupyType)type;

@end
