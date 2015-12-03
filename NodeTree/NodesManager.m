//
//  NodesManager.m
//  NodeTree
//
//  Created by wzb on 15/12/1.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "NodesManager.h"

@implementation NodesManager

+ (NodesManager*)sharedNodesManager
{
    static NodesManager *sharedNodesManager = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNodesManager = [[self alloc] init];
        sharedNodesManager.nodes = [[NSMutableArray alloc]init];
    });
    return sharedNodesManager;
}
@end
