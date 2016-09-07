//
//  CollectionReusableView.m
//  大姨吗
//
//  Created by wgj on 16/9/5.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "CollectionReusableView.h"

@implementation CollectionReusableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, 300, 20)];
        self.title.textColor = [UIColor blackColor];
        [self addSubview:self.title];
    }
    return self;
}

@end
