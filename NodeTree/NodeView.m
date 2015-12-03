//
//  NodeView.m
//  NodeTree
//
//  Created by wzb on 15/11/30.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "NodeView.h"
#import "Node.h"
@implementation NodeView
+ (instancetype)createNodeView:(Node*)node andframe:(CGRect)frame
{
    NodeView* nodeView = [[NodeView alloc] initWithFrame:frame];
    nodeView.node = node;
    
    nodeView.animationView = [[UIView alloc] initWithFrame:CGRectMake((nodeView.frame.size.width / 2) - 15, (nodeView.frame.size.height / 2) - 15, 30, 30)];
    nodeView.animationView.layer.cornerRadius = 10;
    [nodeView.animationView setBackgroundColor:[UIColor purpleColor]];
    [nodeView addSubview:nodeView.animationView];
    nodeView.animationView.layer.opacity = 0;
    
    nodeView.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    nodeView.nameLabel.text = node.name;
    nodeView.nameLabel.textAlignment = NSTextAlignmentCenter;
    [nodeView addSubview:nodeView.nameLabel];
//    NSLog(@"node:%@ x:%f,y:%f,w:%f,h:%f",node.name,frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    return nodeView;
}

- (CGPoint)getNodeTopPoint
{
    CGRect frame = self.frame;
    return CGPointMake(frame.origin.x + (frame.size.width / 2), frame.origin.y + 20);
}

- (CGPoint)getNodeBottomPoint
{
    CGRect frame = self.frame;
    return CGPointMake(frame.origin.x + (frame.size.width / 2), frame.origin.y + frame.size.height - 20);
}

- (void)runBlinkAnimation
{
    self.animationView.layer.opacity = 1;
    [self performSelector:@selector(blinkFinish) withObject:nil afterDelay:.5];
}

- (void)blinkFinish
{
    self.animationView.layer.opacity = 0;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//    
//}


@end
