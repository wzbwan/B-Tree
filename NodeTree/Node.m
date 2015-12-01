//
//  Node.m
//  NodeTree
//
//  Created by wzb on 15/11/30.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "Node.h"
#import <math.h>
@implementation Node
+ (instancetype)createNodeWithName:(NSString*)name
{
    Node* node = [[[self class] alloc] init];
    node.name = name;
    return node;
}

+ (instancetype)createNodeWithName:(NSString *)name andID:(int)nodeID
{
    Node* node = [[[self class] alloc] init];
    node.name = name;
    node.nodeID = nodeID;
    return node;
}

- (void)addChildNode:(Node*)child
{
    if ([self isFull]) {
        if ([self compare:self.leftNode right:self.rightNode]) {
            [self.leftNode addChildNode:child];
        }else{
            [self.rightNode addChildNode:child];
        }
    }else{
        if (self.leftNode == nil) {
            child.parentNode = self;
            self.leftNode = child;
            return;
        }
        if (self.rightNode == nil) {
            child.parentNode = self;
            self.rightNode = child;
            return;
        }
    }
}

//yes left   no right
- (BOOL)compare:(Node*)left right:(Node*)right
{
    int leftCount = [left childrenCountSum:1];
    int rightCount = [right childrenCountSum:1];
    if ([left leavel] > [right leavel]) {
        if ([left isAllFull]) {
            return NO;
        }else{
            return YES;
        }
    }else if ([left leavel] == [right leavel]){
        if (leftCount > rightCount) {
            return NO;
        }else{
            return YES;
        }
    }else{
        return NO;
    }
}

- (int)childrenCount:(Node*)node sum:(int)sum
{
    if ([node isFull]) {
        return [self childrenCount:node.leftNode sum:sum+1] + [self childrenCount:node.rightNode sum:1];
    }else if (node.leftNode){
        return [self childrenCount:node.leftNode sum:sum+1];
    }else{
        return sum;
    }
}

- (int)childrenCountSum:(int)sum
{
    if ([self isFull]) {
        return [self.leftNode childrenCountSum:sum+1] + [self.rightNode childrenCountSum:1];
    }else if (self.leftNode){
        return [self.leftNode childrenCountSum:sum+1];
    }else{
        return sum;
    }
}

- (BOOL)isFull
{
    if (self.leftNode && self.rightNode) {
        return YES;
    }
    return NO;
}

- (BOOL)isAllFull
{
    int leavel = (int)[self leavel];
    int fullCount = 0;
    for (int i = leavel-1; i >= 0; i--) {
        fullCount += pow(2, i);
    }
    if (fullCount > [self childrenCount:self sum:1]) {
        return NO;
    }else{
        return YES;
    }
}

- (NSInteger)leavel
{
    if (self.leftNode) {
        return 1 + [self.leftNode leavel];
    }
    return 1;
}

- (NSArray*)nodesInLeavel:(int)leavel
{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    if (leavel == 1 && [self leavel] == 1) {
        Node* node = [Node createNodeWithName:self.name andID:self.nodeID];
        [array addObject:node];
    }else if (leavel == 2) {
        if (self.leftNode) {
            [array addObject:self.leftNode];
        }
        if (self.rightNode) {
            [array addObject:self.rightNode];
        }
    }else{
        if (self.leftNode) {
            [array addObjectsFromArray:[self.leftNode nodesInLeavel:leavel-1]];
        }
        if (self.rightNode) {
            [array addObjectsFromArray:[self.rightNode nodesInLeavel:leavel-1]];
        }
        
    }
    return array;
}

- (void)printNodeNLR
{
    NSLog(@"%@",self.name);
    if (self.leftNode) {
        [self.leftNode printNodeNLR];
    }
    if (self.rightNode) {
        [self.rightNode printNodeNLR];
    }
}

- (void)printNodeLNR
{
    if ([self isFull]) {
        [self.leftNode printNodeLNR];
        NSLog(@"%@",self.name);
        [self.rightNode printNodeLNR];
    }else if (self.leftNode){
        [self.leftNode printNodeLNR];
    }else{
        NSLog(@"%@",self.name);
    }
}

- (void)printNodeLRN
{
    if (self.leftNode) {
        [self.leftNode printNodeLRN];
        if (self.rightNode) {
            [self.rightNode printNodeLRN];
        }
        NSLog(@"%@",self.name);
    }else{
        NSLog(@"%@",self.name);
    }
}
@end
