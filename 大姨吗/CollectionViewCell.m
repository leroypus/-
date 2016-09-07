//
//  CollectionViewCell.m
//  大姨吗
//
//  Created by wgj on 16/9/5.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import "CollectionViewCell.h"

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)

@implementation CollectionViewCell

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
        self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (SCREEN_WIDTH - 80) / 4, (SCREEN_WIDTH - 80) / 4)];
        [self.imageView setUserInteractionEnabled:true];
        [self addSubview:self.imageView];
        
        self.descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, (SCREEN_WIDTH - 80)/ 4, (SCREEN_WIDTH - 80)/ 4, 20)];
        self.descLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.descLabel];
    }
    return self;
}

@end
