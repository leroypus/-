//
//  GobangView.m
//  五子棋
//
//  Created by wgj on 16/8/26.
//  Copyright © 2016年 wgj. All rights reserved.
//
// 这个view负责展示和智能逻辑

#import "GobangView.h"
#import "KWAI.h"

// 定义我的棋盘上到底有多少个点，const是定义一个指针

const NSInteger kBoardSize = 19;

@interface GobangView ()

@property (nonatomic, assign) BOOL isPlayerPlaying;
// 标志为，标志是否是玩家正在下棋
@property (nonatomic, strong) NSMutableArray *places;
// 记录所有的位置状态
@property (nonatomic, strong) NSMutableArray *chesses;
// 记录所有棋盘上的棋子
@property (nonatomic, strong) NSMutableArray *holders;
// 记录五子连珠后对用的五个棋子
@property (nonatomic, strong) UIView *redDot;
// 指示AI最新一步所在的位置

@end

@implementation GobangView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame {

    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:230.0/255.0 green:192.0/255.0 blue:148.0/255.0 alpha:1.0];
        
        self.redDot = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        self.redDot.backgroundColor = [UIColor redColor];
        self.redDot.layer.cornerRadius = 2.5;
        
        for (int i = 0; i <kBoardSize + 2; i ++) {
            //
            UIView *horizentalLine = [[UIView alloc]initWithFrame:CGRectMake(0, i*frame.size.height/(kBoardSize + 1), frame.size.width, 0.5)];
            horizentalLine.backgroundColor = [UIColor blackColor];
            [self addSubview:horizentalLine];
        }
        for (int i = 0; i <kBoardSize +2; i++) {
            UIView *verticalLine = [[UIView alloc]initWithFrame:CGRectMake(i*frame.size.width/(kBoardSize+1), 0, 0.5, frame.size.height)];
            verticalLine.backgroundColor = [UIColor blackColor];
            [self addSubview:verticalLine];
        }
        self.places = [NSMutableArray array];
        for (int i = 0; i < kBoardSize; i ++) {
            NSMutableArray *chil = [NSMutableArray array];
            for (int j = 0; j < kBoardSize; j ++) {
                [chil addObject:@(OccupyTypeEmpty)];
            }
            [self.places addObject:chil];
        }
        self.chesses = [NSMutableArray array];
        self.holders = [NSMutableArray array];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.userInteractionEnabled = NO;
    
    self.isPlayerPlaying = YES;
    
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSInteger h = 0 , v = 0;
    
    for (NSUInteger i = 0; i <= kBoardSize; i ++) {
        
        if (i * self.frame.size.width / (kBoardSize + 1) <= point.x && point.x < (i + 1) * self.frame.size.width / (kBoardSize + 1)) {
            
            
            
            if (i == 0) {
                h = 0;
                
                break;
            }
            
            if (i == kBoardSize) {
                h = kBoardSize - 1;
                
                break;
            }
            
            if (fabs(i * self.frame.size.width / (kBoardSize + 1) - point.x) >= fabs((i + 1) * self.frame.size.width / (kBoardSize + 1) - point.x)) {
                h = i;
                
                break;
            } else {
                
                h = i - 1;
                break;
            }
        }
        
        NSLog(@"got you h!");
    }
    
    for (int i = 0; i <= kBoardSize; i ++) {
        if (i * self.frame.size.width / (kBoardSize + 1) <= point.y && point.y < (i + 1) * self.frame.size.width / (kBoardSize + 1)) {
            if (i == 0) {
                v = 0;
                break;
            }
            
            if (i == kBoardSize) {
                v = kBoardSize - 1;
                break;
            }
            
            if (fabs(i * self.frame.size.width / (kBoardSize + 1) - point.y) >= fabs((i + 1) * self.frame.size.width / (kBoardSize + 1) - point.y)) {
                v = i;
                
                break;
            } else {
                
                v = i - 1;
                
                break;
            }
        }
        
        NSLog(@"got you V!");
    }
    

    if (h >= kBoardSize || v >= kBoardSize) {
        
        NSLog(@"failed!");
        self.userInteractionEnabled = YES;
        return;
    }
    
    UIImageView *black = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
    black.backgroundColor = [UIColor clearColor];
    black.image = [UIImage imageNamed:@"black"];
    black.layer.cornerRadius = 5;
    black.clipsToBounds = YES;
    black.frame = CGRectMake((h + 1) * self.frame.size.width / (kBoardSize + 1) - 5, (v + 1) * self.frame.size.height / (kBoardSize + 1) - 5, 10, 10);
    [self addSubview:black];
    
    if ([self.places[h][v] integerValue] == 0) {

    } else {
        
        self.userInteractionEnabled = YES;
        return;
    }

    
    KWPoint *p;
    p = [KWAI geablog:self.places type:OccupyTypeUser];
    p = [[KWPoint alloc] initWithPoint:h y:v];
    
    if ([self move:p] == FALSE) {
        [self win:OccupyTypeAI];
         //       self.userInteractionEnabled = YES;
        return;
    }
//
//    UIImageView *black = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
//    black.backgroundColor = [UIColor clearColor];
//    black.image = [UIImage imageNamed:@"black"];
//    black.layer.cornerRadius = 5;
//    black.clipsToBounds = YES;
//    black.frame = CGRectMake((h + 1) * self.frame.size.width / (kBoardSize + 1) - 5, (v + 1) * self.frame.size.height / (kBoardSize + 1) - 5, 10, 10);
//    [self addSubview:black];

    if ([self checkVictory:OccupyTypeUser]== OccupyTypeUser) {
        [self win:OccupyTypeUser];
         //       self.userInteractionEnabled = YES;
        return;
    }
    
    p = [KWAI geablog:self.places type:OccupyTypeAI];
    
    if ([self move:p] == FALSE) {
        [self win:OccupyTypeUser];
        //        self.userInteractionEnabled = YES;
        return;
    }
    if ([self checkVictory:OccupyTypeAI] == OccupyTypeAI) {
        [self win:OccupyTypeAI];
        //        self.userInteractionEnabled = YES;
        return;
    }
    
    self.userInteractionEnabled = YES;
}


- (OccupyType)getType:(CGPoint)point {
    
    if ((point.x >= 0 && point.x < kBoardSize) && (point.y >= 0 && point.y < kBoardSize)) {
        NSInteger x = (int)point.x;
        // places:记录所有的位置状态
        NSMutableArray *arr = self.places[x];
        NSInteger y = (int)point.y;
        return [arr[y] integerValue];
    }
    
    return OccupyTypeUnknown;
}

- (OccupyType)checkNode:(CGPoint)point { //对个给定的点向四周遍历 看是否能形成5子连珠
    
    OccupyType curType = [self getType:point];
    BOOL vic = TRUE;
    for (int i = 1; i < 5; i ++) {
        CGPoint nextP = CGPointMake(point.x + i, point.y);
        if (point.x + i >= kBoardSize || [self getType:nextP] != curType) {
            vic = FALSE;
            break;
        }
    }
    
    if (vic == TRUE) {
        return curType;
    }
    vic = TRUE;
    for (int i = 1; i < 5; i++) {
        CGPoint nextP = CGPointMake(point.x, point.y + i);
        if (point.y + i >= kBoardSize || [self getType:nextP] != curType) {
            vic = false;
            break;
        }
    }
    
    if (vic == TRUE) {
        return curType;
    }
    vic = TRUE;
    for (int i = 1; i < 5; i++) {
        CGPoint nextP = CGPointMake(point.x + i, point.y + i);
        if (point.x + i >= kBoardSize || point.y + i >= kBoardSize || [self getType:nextP] != curType) {
            vic = false;
            break;
        }
    }
    
    if (vic == TRUE) {
        return curType;
    }
    vic = TRUE;
    for (int i = 1; i < 5; i ++) {
        CGPoint nextP = CGPointMake(point.x - i, point.y + i);
        if (point.x - i < 0 || point.y + i >= kBoardSize || [self getType:nextP] != curType) {
            vic = false;
            break;
        }
    }
    
    if (vic == TRUE) {
        return curType;
    }
    
    return OccupyTypeEmpty;
}

- (OccupyType)checkVictory:(OccupyType)type { // 检查是否type方胜利了的方法
    
    BOOL isFull = TRUE;
    for (int i = 0; i < kBoardSize; i ++) {
        for (int j = 0; j < kBoardSize; j ++) {
            CGPoint p = CGPointMake(i, j);
            OccupyType winType = [self checkNode:p]; // 检查是否形成5子连珠
            if (winType == OccupyTypeUser) {
                return OccupyTypeUser;
            } else if (winType == OccupyTypeAI) {
                return OccupyTypeAI;
            }
            NSMutableArray *arr = self.places[i];
            OccupyType ty = [arr[j] integerValue];
            if (ty == OccupyTypeEmpty) {
                isFull = false;
            }
        }
    }
    
    if (isFull == TRUE) {
        return type;
    }
    
    return OccupyTypeEmpty;
}

- (BOOL)move:(KWPoint *)p { // 向p点进行落子并绘制的方法
    if (p.x < 0 || p.x >= kBoardSize ||
        p.y < 0 || p.y >= kBoardSize) {
        return false;
    }
    
    NSInteger x = p.x;
    NSMutableArray *arr = self.places[x];
    NSInteger y = p.y;
    OccupyType ty = [arr[y] integerValue];
    if (ty == OccupyTypeEmpty) {
        if (self.isPlayerPlaying) {
            [arr replaceObjectAtIndex:y withObject:@(OccupyTypeUser)];
            
            UIImageView *black = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            black.backgroundColor = [UIColor clearColor];
            black.image = [UIImage imageNamed:@"black"];
            black.layer.cornerRadius = 5;
            black.clipsToBounds = YES;
            [self addSubview:black];
            black.frame = CGRectMake((x + 1) * self.frame.size.width / (kBoardSize + 1) - 5, (y + 1) * self.frame.size.height / (kBoardSize + 1) - 5, 10, 10);
            
            [self.chesses addObject:black];
            
        } else {
            [arr replaceObjectAtIndex:y withObject:@(OccupyTypeAI)];
            
            UIImageView *black = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
            black.image = [UIImage imageNamed:@"white"];
            black.backgroundColor = [UIColor clearColor];
            black.layer.cornerRadius = 5;
            black.clipsToBounds = YES;
            [self addSubview:black];
            //        black.center = CGPointMake(h * self.frame.size.width / 10, v * self.frame.size.height);
            black.frame = CGRectMake((p.x + 1) * self.frame.size.width / (kBoardSize + 1) - 5, (p.y + 1) * self.frame.size.height / (kBoardSize + 1) - 5, 10, 10);
            [self.chesses addObject:black];
            
            [self.redDot removeFromSuperview];
            [black addSubview:self.redDot];
            self.redDot.frame = CGRectMake(2.5, 2.5, 5, 5);
        }
        self.isPlayerPlaying = !self.isPlayerPlaying;
        return TRUE;
    } else {
        return FALSE;
    }
}

- (void)reset { // 重新开始的方法
    
    self.userInteractionEnabled = YES;
    
    for (UIView *view in self.chesses) {
        [view removeFromSuperview];
    }
    
    [self.chesses removeAllObjects];
    
    self.places = [NSMutableArray array];
    for (int i = 0; i < kBoardSize; i ++) {
        NSMutableArray *chil = [NSMutableArray array];
        for (int j = 0; j < kBoardSize; j ++) {
            [chil addObject:@(OccupyTypeEmpty)];
        }
        [self.places addObject:chil];
    }
}

- (void)win:(OccupyType)type { // type方获得胜利时出现动画的效果
    
    
    
    self.userInteractionEnabled = NO;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.frame.size.height - 40) / 2, self.frame.size.width, 45)];
    label.layer.cornerRadius = 5;
    label.layer.borderColor = [[UIColor blackColor] CGColor];
    label.layer.borderWidth = 5;
    label.font = [UIFont systemFontOfSize:38];
    [self addSubview:label];
    label.adjustsFontSizeToFitWidth = YES;
    label.alpha = 0;
    label.textAlignment = NSTextAlignmentCenter;
    
    if (OccupyTypeAI == type) {
        label.text = @"您输了～嘿嘿嘿";
        
    } else if (OccupyTypeUser == type) {
        label.text = @"您赢了 太棒！";
        
    }
    
    [UIView animateWithDuration:0.5 animations:^{
        label.alpha = 1;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 delay:2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.alpha = 0;
        } completion:^(BOOL finished) {
            [self reset];
            [label removeFromSuperview];
            self.userInteractionEnabled = YES;
        }];
    }];
}

@end
