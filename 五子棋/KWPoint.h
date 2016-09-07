//
//  KWPoint.h
//  五子棋
//
//  Created by wgj on 16/8/26.
//  Copyright © 2016年 wgj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KWPoint : NSObject

@property (nonatomic, assign) NSInteger x;
@property (nonatomic, assign) NSInteger y;

- (id)initWithPoint:(NSInteger)x y:(NSInteger)y;

@end
