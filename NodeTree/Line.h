//
//  Line.h
//  NodeTree
//
//  Created by wzb on 15/12/1.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line : NSObject
@property(assign)CGPoint start;
@property(assign)CGPoint end;

+ (instancetype)createLineFrom:(CGPoint)start to:(CGPoint)end;
@end
