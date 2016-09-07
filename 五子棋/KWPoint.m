//
//  KWPoint.m
//  五子棋
//
//  Created by wgj on 16/8/26.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "KWPoint.h"

@implementation KWPoint

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithPoint:(NSInteger)x y:(NSInteger)y {

    self = [self init];
    if (self) {
        self.x = x;
        self.y = y;
    }
    return self;
}

- (id)init {

    self = [super init];
    if (self) {
        self.x = -1;
        self.y = -1;
    }
    return self;
}

@end
