//
//  DrawIconView.m
//  NodeTree
//
//  Created by 王 增宝 on 15/12/3.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "DrawIconView.h"
#import "Line.h"
@implementation DrawIconView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    
    for (int i = 0; i < [self.lines count]; i++) {
        Line* line = [self.lines objectAtIndex:i];
        CGContextMoveToPoint(context, line.start.x, line.start.y);
        CGContextAddLineToPoint(context, line.end.x, line.end.y);
        CGContextStrokePath(context);
    }
}

- (void)getLines:(NSArray*)lines
{
    self.lines = lines;
    [self setNeedsDisplay];
}
@end
