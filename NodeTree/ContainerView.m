//
//  ContainerView.m
//  NodeTree
//
//  Created by wzb on 15/12/1.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "ContainerView.h"
#import "Line.h"
@implementation ContainerView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if ([self.lines count] > 0) {
        self.cgCRF =UIGraphicsGetCurrentContext();
        CGContextSetRGBStrokeColor(self.cgCRF, 0, 1, 0, 1.0);
        CGContextSetLineWidth(self.cgCRF, 2);
        for (Line* line in self.lines) {
            CGContextMoveToPoint(self.cgCRF, line.start.x, line.start.y);
            CGContextAddLineToPoint(self.cgCRF, line.end.x,line.end.y);
            CGContextStrokePath(self.cgCRF);
        }
    }
}

- (void)drawLineFrom:(CGPoint)startPoint to:(CGPoint)endPoint
{
    Line* l = [Line createLineFrom:startPoint to:endPoint];
    [self.lines addObject:l];
}

- (NSMutableArray*)lines
{
    if (_lines == nil) {
        _lines = [[NSMutableArray alloc] init];
    }
    return _lines;
}
@end
