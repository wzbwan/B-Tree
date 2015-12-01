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
    nodeView.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    nodeView.nameLabel.text = node.name;
    nodeView.nameLabel.textAlignment = NSTextAlignmentCenter;
    [nodeView addSubview:nodeView.nameLabel];
//    NSLog(@"node:%@ x:%f,y:%f,w:%f,h:%f",node.name,frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    return nodeView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
