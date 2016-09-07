//
//  KWAI.m
//  五子棋
//
//  Created by wgj on 16/8/26.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "KWAI.h"

static NSInteger kBoardSize = 19;


@implementation KWPointData

- (id)init {
    
    self = [super init];
    if (self) {
        self.p = [[KWPoint alloc] initWithPoint:-1 y:-1];
        self.count = 0;
    }
    
    return self;
}

- (id)initWithPoint:(KWPoint *)point count:(int)ncount {
    
    self = [self init];
    if (self) {
        //        self.p = point;
        self.p = [[KWPoint alloc] initWithPoint:-1 y:-1];
        self.p.x = point.x;
        self.p.y = point.y;
        self.count = ncount;
    }
    
    return self;
}

@end

@implementation KWOmni

- (id)init {
    
    self = [super init];
    if (self) {
        
        self.oppType = OccupyTypeEmpty;
        self.myType = OccupyTypeEmpty;
    }
    
    return self;
}

- (id)initWithArr:(NSMutableArray *)arr opp:(OccupyType)opp my:(OccupyType)my {
    
    self = [self init];
    if (self) {
        self.curBoard = arr;
        self.oppType = opp;
        self.myType = my;
    }
    
    return self;
}

- (BOOL)isStepEmergent:(KWPoint *)pp Num:(int)num type:(OccupyType)xType {
    
    //    NSLog(@"is Step emergent");
    
    KWPoint* check = [[KWPoint alloc] initWithPoint:pp.x y:pp.y];
    if (![self checkPoint:check]) {
        return FALSE;
    } else {
        
        KWPoint *test = [[KWPoint alloc] initWithPoint:check.x y:check.y]; // 开始进行寻找的点
        KWPoint *testR = [[KWPoint alloc] initWithPoint:check.x y:check.y]; // 遍历点的左侧的点
        KWPoint *testL = [[KWPoint alloc] initWithPoint:check.x y:check.y]; // 遍历点的右侧的点
        
        testR = [[KWPoint alloc] initWithPoint:check.x + 1 y:check.y]; // 开始遍历点的正右侧
        testL = [[KWPoint alloc] initWithPoint:check.x - 1 y:check.y]; // 开始遍历的点的正左侧
        
        for(int hi = 1; (test.x+hi < kBoardSize) && ([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == xType); hi++) //在相应点向右侧进行遍历，寻找最长的连续距离
            testR = [[KWPoint alloc] initWithPoint:testR.x + 1 y:testR.y];
        for(int hii = 1; (test.x-hii >= 0) && ([self.curBoard[(int)testL.x][(int)testL.y] integerValue] == xType); hii++) //在相应点向左侧进行遍历，寻找最长的连续距离
            testL = [[KWPoint alloc] initWithPoint:testR.x - 1 y:testR.y];
        
        if ([self checkPoint:testL] && [self checkPoint:testR]) {// 如果两个点都是可用的
            if (testR.x - testL.x >= num) { // 如果两个点之间的距离大于或等于我们需要的距离
                if ([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == OccupyTypeEmpty && [self.curBoard[(int)testL.x][(int)testL.y] integerValue] == OccupyTypeEmpty) { // 并且这段连续距离的两侧都是可以落子的空点
                    return TRUE;
                }
            }
        }
        
        
        testR = [[KWPoint alloc] initWithPoint:check.x y:check.y + 1]; // 开始遍历点的正下方
        testL = [[KWPoint alloc] initWithPoint:check.x y:check.y - 1]; // 开始遍历的点的正上方
        
        for(int vi = 1; (test.y+vi < kBoardSize) && ([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == xType); vi++){ // 不断向正下方寻找最长连续
            testR.x = testR.x;
            testR.y = testR.y + 1;
        }
        for(int vii = 1; (test.y-vii >= 0) && ([self.curBoard[(int)testL.x][(int)testL.y] integerValue] == xType); vii++){ // 不断向正上方寻找最长连续
            //            testL = CGPointMake(testL.x, test.y - 1);
            testL.x = testL.x;
            testL.y = testL.y - 1;
        }
        
        if ([self checkPoint:testL]  && [self checkPoint:testR]) {
            if(testR.y - testL.y >= num)
                if([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == OccupyTypeEmpty && [self.curBoard[(int)testL.x][(int)testL.y] integerValue] == OccupyTypeEmpty)
                    return true;
        }
        
        testR.x = check.x + 1; // 开始遍历点的右下方
        testR.y = check.y + 1;
        testL.x = check.x - 1; // 开始遍历点的左上方
        testL.y = check.y - 1;
        
        // 后面的判断逻辑和上面是相同的 不再赘述
        for(int ri = 1; (test.x+ri < kBoardSize && test.y+ri < kBoardSize) && ([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == xType); ri++) {
            testR.x = testR.x + 1;
            testR.y = testR.y + 1;
        }
        //            testR = CGPointMake(testR.x + 1, testR.y + 1);
        
        for(int rii = 1; (test.x-rii >= 0 && test.y-rii >= 0) && ([self.curBoard[(int)testL.x][(int)testL.y] integerValue] == xType); rii++) {
            
            testL.x = testL.x - 1;
            testL.y = testL.y - 1;
        }
        
        if ([self checkPoint:testL] && [self checkPoint:testR]) {
            if(testR.x - testL.x >= num)
                if([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == OccupyTypeEmpty && [self.curBoard[(int)testL.x][(int)testL.y] integerValue] == OccupyTypeEmpty)
                    return true;
        }
        
        
        testR.x = check.x + 1; // 开始遍历点的右上方
        testR.y = check.y - 1;
        testL.x = check.x - 1; // 开始遍历点的左下方
        testL.y = check.y + 1;
        for(int li = 1; (test.x+li < kBoardSize && test.y-li >= 0) && ([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == xType); li++) {
            //            testR = CGPointMake(testR.x + 1, testR.y - 1);
            testR.x = testR.x + 1;
            testR.y = testR.y - 1;
        }
        
        //            testR.Set(testR.x+1, testR.y-1);
        for(int lii = 1; (test.x-lii >= 0 && test.y+lii < kBoardSize) && ([self.curBoard[(int)testL.x][(int)testL.y] integerValue] == xType); lii++) {
            //            testL = CGPointMake(testL.x - 1, testL.y + 1);
            testL.x = testL.x - 1;
            testL.y = testL.y + 1;
        }
        if ([self checkPoint:testL] && [self checkPoint:testR]) {
            if(testR.x - testL.x >= num)
                if([self.curBoard[(int)testR.x][(int)testR.y] integerValue] == OccupyTypeEmpty && [self.curBoard[(int)testL.x][(int)testL.y] integerValue] == OccupyTypeEmpty)
                    return true;
        }
        
    }
    return FALSE;
}

- (BOOL)checkPoint:(KWPoint *)point {
    
    // 如果一个点的X Y 坐标都大于等于0且小于棋盘大小时才认为可用
    
    if (((int)point.x >= 0 && (int)point.x < kBoardSize) && ((int)point.y >= 0 && (int)point.y < kBoardSize)) {
        return YES;
    }
    return NO;
}

- (KWPoint *)nextStep:(OccupyType)xType num:(int)num thre:(int)threshold x:(int)startX y:(int)startY {
    
    KWPoint *search = [[KWPoint alloc] initWithPoint:startX y:startY];
    KWPoint * hPoint;
    KWPoint * vPoint;
    KWPoint * rPoint;
    KWPoint * lPoint;
    // 横向上寻找形成的num连珠的起始点
    hPoint = [self horizontal:search type:xType num:num thre:threshold];
    // 竖向上寻找形成的num连珠的起始点
    vPoint = [self vertical:search type:xType num:num thre:threshold];
    // 右下方向上寻找形成的num连珠的起始点
    rPoint = [self rightDown:search type:xType num:num thre:threshold];
    // 左下方向上寻找形成的num连珠的起始点
    lPoint = [self leftDown:search type:xType num:num thre:threshold];
    
    if(num == 5){
        if([self checkPoint:hPoint])// 表示找到胜利的五子连珠了
            return hPoint;
        if([self checkPoint:vPoint])
            return vPoint;
        if([self checkPoint:rPoint])
            return rPoint;
        if([self checkPoint:lPoint])
            return lPoint;
    } else{
        
        while([self checkPoint:hPoint] && ![self isStepEmergent:hPoint Num:num type:xType]){
            hPoint = [self horizontal:[self getNextPoint:hPoint] type:xType num:num thre:threshold];//在横向上寻找threshold连续且可以形成num连续的点
        }
        if([self isStepEmergent:hPoint Num:num type:xType])// 在找到threshold连续的点并且两侧可以落子后，返回该点
            return hPoint;
        
        
        while([self checkPoint:vPoint] && ![self isStepEmergent:vPoint Num:num type:xType]){
            vPoint = [self vertical:[self getNextPoint:vPoint] type:xType num:num thre:threshold]; //在竖向上寻找threshold连续且可以形成num连续的点
        }
        if([self isStepEmergent:vPoint Num:num type:xType])// 在找到threshold连续的点并且两侧可以落子后，返回该点
            return vPoint;
        
        while([self checkPoint:rPoint] && ![self isStepEmergent:rPoint Num:num type:xType]){
            rPoint = [self rightDown:[self getNextPoint:rPoint] type:xType num:num thre:threshold]; //在右下向上寻找threshold连续且可以形成num连续的点
        }
        if([self isStepEmergent:rPoint Num:num type:xType])// 在找到threshold连续的点并且两侧可以落子后，返回该点
            return rPoint;
        
        while([self checkPoint:lPoint] && ![self isStepEmergent:lPoint Num:num type:xType]){
            lPoint = [self leftDown:[self getNextPoint:lPoint] type:xType num:num thre:threshold];//在左下向上寻找threshold连续且可以形成num连续的点
        }
        if([self isStepEmergent:lPoint Num:num type:xType])// 在找到threshold连续的点并且两侧可以落子后，返回该点
            return lPoint;
    }
    
    KWPoint * invalid = [[KWPoint alloc] init];
    return invalid;
}

- (KWPoint *)horizontal:(KWPoint *)pp type:(OccupyType)xType num:(int)num thre:(int)threshold {
    
    if (![self checkPoint:pp]) {
        return pp;
    }
    
    int count = 0;
    KWPoint *solution = [[KWPoint alloc] init];
    for(int ii = 0; ii < num; ii++){
        
        NSInteger x = (int)(pp.x) + ii; // 在横向上逐渐寻找下一个点
        //NSInteger y = (int)pp.y;
        
        if (x < kBoardSize) {
            if([self.curBoard[x][(int)pp.y] integerValue] == xType){ // 如果满足了一定连续条件
                count ++;
            }
            
            if([self.curBoard[x][(int)pp.y] integerValue] == OccupyTypeEmpty) { // 在横向上找到了一个空点
                solution.x = x;
                solution.y = pp.y;
            }
        }
        
    }
    if(count >= threshold && [self checkPoint:solution])// 如果找到了我们希望的连珠个数，并且这些连珠之后还有可以落子的点
        return solution;
    
    return [self horizontal:[self getNextPoint:pp] type:xType num:num thre:threshold]; // 否则以递归的方式向后一个点进行遍历
}

- (KWPoint *)vertical:(KWPoint *)pp type:(OccupyType)xType num:(int)num thre:(int)threshold {
    
    if (![self checkPoint:pp]) {
        return pp;
    }
    
    //    NSLog(@"in vertical pp.x is %@, pp.y is %@", @(pp.x), @(pp.y));
    
    int count = 0;
    KWPoint *solution = [[KWPoint alloc] init];
    for(int ii = 0; ii < num; ii++){
        
        NSInteger x = (int)(pp.x);
        NSInteger y = (int)pp.y + ii;// 在竖向上逐渐寻找下一个点
        
        if (y < kBoardSize) {
            if([self.curBoard[x][y] integerValue] == xType){
                count ++;
            }
            
            if([self.curBoard[x][y] integerValue] == OccupyTypeEmpty) {
                solution.x = pp.x;
                solution.y = pp.y + ii;
            }
        }
        
    }
    if(count >= threshold && [self checkPoint:solution])
        return solution;
    
    return [self vertical:[self getNextPoint:pp] type:xType num:num thre:threshold];
}

- (KWPoint *)rightDown:(KWPoint *)pp type:(OccupyType)xType num:(int)num thre:(int)threshold {
    
    //    if(!pp.Valid())
    //        return pp;
    if (![self checkPoint:pp]) {
        return pp;
    }
    
    int count = 0;
    KWPoint *solution = [[KWPoint alloc] init];
    for(int ii = 0; ii < num; ii++){
        NSInteger x = (int)(pp.x + ii);// 在右下向上逐渐寻找下一个点
        NSInteger y = (int)pp.y + ii;
        
        if ((pp.x+ii < kBoardSize) &&
            (pp.y+ii < kBoardSize)) {
            if(([self.curBoard[x][y] integerValue] == xType))
                count ++;
            
            if([self.curBoard[x][y] integerValue] == OccupyTypeEmpty) {
                solution.x = pp.x+ ii;
                solution.y = pp.y + ii;
            }
        }
        
    }
    if(count >= threshold && [self checkPoint:solution])
        return solution;
    
    //    return rightDown(getNextPoint(pp), xType, num, threshold);
    return [self rightDown:[self getNextPoint:pp] type:xType num:num thre:threshold];
}

- (KWPoint *)leftDown:(KWPoint *)pp type:(OccupyType)xType num:(int)num thre:(int)threshold {
    
    if(![self checkPoint:pp])
        return pp;
    
    int count = 0;
    KWPoint *solution = [[KWPoint alloc] init];
    for(int ii = 0; ii < num; ii++){
        
        NSInteger x = (int)(pp.x - ii);// 在左下向上逐渐寻找下一个点
        NSInteger y = (int)pp.y + ii;
        
        if ((pp.x-ii >= 0) &&
            (pp.y+ii < kBoardSize)) {
            if(([self.curBoard[x][y] integerValue] == xType))
                count ++;
            //                solution = CGPointMake(pp.x - ii, pp.y + ii);
            
            if([self.curBoard[x][y] integerValue] == OccupyTypeEmpty) {
                solution.x = pp.x - ii;
                solution.y = pp.y + ii;
            }
        }
        
        
        //            solution.Set(pp.x-ii, pp.y+ii);
    }
    if(count >= threshold && [self checkPoint:solution])
        return solution;
    
    //    return leftDown(getNextPoint(pp), xType, num, threshold);
    return [self leftDown:[self getNextPoint:pp] type:xType num:num thre:threshold];
}

- (KWPoint *)getNextPoint:(KWPoint *)pp {
    
    KWPoint *result = [[KWPoint alloc] init];
    result.x = pp.x;
    result.y = pp.y;
    if(pp.x+1 < kBoardSize){
        result.x = pp.x + 1; //如果下一个点在同一排 则返回下一个
        result.y = pp.y;
        return result;
    }
    result.x = 0; // 否则返回下一排第一个
    result.y = pp.y + 1;
    return result;
}

@end

@implementation KWAI


+ (KWPoint *)geablog:(NSMutableArray *)board type:(OccupyType)type {
    
    KWPoint *calibur = [[self class] SeraphTheGreat:board type:type];
    return calibur;
}

+ (KWPoint *)SeraphTheGreat:(NSMutableArray *)board type:(OccupyType)myType {
    
    KWOmni *omniknight = [[KWOmni alloc] init];
    if(myType == OccupyTypeUser)
        
        omniknight = [[KWOmni alloc] initWithArr:board opp:OccupyTypeAI my:OccupyTypeUser];
    else
        
        omniknight = [[KWOmni alloc] initWithArr:board opp:OccupyTypeUser my:OccupyTypeAI];
    KWPoint *calibur;
    
    calibur = [omniknight nextStep:omniknight.myType num:5 thre:4 x:0 y:0];// 以AI自己的角度观察场上形势，从（0， 0）点开始遍历，寻找是否有4子连珠并且可以形成5子连珠的点
    if([omniknight checkPoint:calibur]) { // 如果有 在此摆子形成进攻或直接胜利
        return calibur;
    }
    
    
    calibur = [omniknight nextStep:omniknight.oppType num:5 thre:4 x:0 y:0]; // AI以用户的角度观察场上形势，从（0， 0）点开始遍历，寻找用户棋子排放是否有4子连珠并且可以形成5子连珠的点
    if ([omniknight checkPoint:calibur]) { // 如果有 则在此落子进行防守
        return calibur;
    }
    
    calibur = [omniknight nextStep:omniknight.myType num:4 thre:3 x:0 y:0]; // 以AI自己的角度观察场上形势，从（0， 0）点开始遍历，寻找是否有3子连珠并且可以形成4子连珠的点
    if([omniknight checkPoint:calibur])// 如果有 在此摆子形成进攻
        
        return calibur;
    
    calibur = [omniknight nextStep:omniknight.oppType num:4 thre:3 x:0 y:0];  // AI以用户的角度观察场上形势，从（0， 0）点开始遍历，寻找用户棋子排放是否有3子连珠并且可以形成4子连珠的点
    if ([omniknight checkPoint:calibur]) { // 如果有 在此摆子形成防守
        return calibur;
    }
    
    calibur = [omniknight nextStep:omniknight.myType num:3 thre:2 x:0 y:0]; // 以AI自己的角度观察场上形势，从（0， 0）点开始遍历，寻找是否有2子连珠并且可以形成3子连珠的点
    if([omniknight checkPoint:calibur]) // 如果有 在此摆子形成进攻
        return calibur;
    
    calibur = [omniknight nextStep:omniknight.myType num:2 thre:1 x:0 y:0]; // 以AI自己的角度观察场上形势，从（0， 0）点开始遍历，寻找是否有1子连珠并且可以形成2子连珠的点
    if([omniknight checkPoint:calibur]) // 如果有 在此摆子形成进攻
        return calibur;
    
    calibur = [omniknight nextStep:omniknight.oppType num:3 thre:2 x:0 y:0]; // AI以用户的角度观察场上形势，从（0， 0）点开始遍历，寻找用户棋子排放是否有2子连珠并且可以形成3子连珠的点
    if ([omniknight checkPoint:calibur]) { // 如果有 在此摆子形成防守
        return calibur;
    }
    
    calibur = [omniknight nextStep:omniknight.oppType num:2 thre:1 x:0 y:0]; // AI以用户的角度观察场上形势，从（0， 0）点开始遍历，寻找用户棋子排放是否有1子连珠并且可以形成2子连珠的点
    if ([omniknight checkPoint:calibur]) { // 如果有 在此摆子形成防守
        return calibur;
    }
    
    //  如果什么都没有则返回不可用的点
    KWPoint *sad = [[KWPoint alloc] initWithPoint:(kBoardSize+1)/2 y:(kBoardSize+1)/2];
    return sad;
}

@end
