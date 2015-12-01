//
//  ContainerView.h
//  NodeTree
//
//  Created by wzb on 15/12/1.
//  Copyright © 2015年 shangyilian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContainerView : UIView
@property(assign)CGContextRef cgCRF;
@property(nonatomic, strong)NSMutableArray* lines;

- (void)drawLineFrom:(CGPoint)startPoint to:(CGPoint)endPoint;
@end
