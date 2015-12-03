//
//  Line.m
//  NodeTree
//
//  Created by wzb on 15/12/1.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "Line.h"

@implementation Line

+ (instancetype)createLineFrom:(CGPoint)start to:(CGPoint)end
{
    Line* line = [[Line alloc] init];
    line.start = start;
    line.end = end;
    return line;
}
@end
