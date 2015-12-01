//
//  Node.h
//  NodeTree
//
//  Created by wzb on 15/11/30.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property(nonatomic, strong)Node* leftNode;
@property(nonatomic, strong)Node* rightNode;
@property(nonatomic, strong)Node* parentNode;
@property(nonatomic, strong)NSString* name;
@property(assign)int nodeID;

+ (instancetype)createNodeWithName:(NSString*)name;
+ (instancetype)createNodeWithName:(NSString *)name andID:(int)nodeID;

- (void)addChildNode:(Node*)child;
- (BOOL)isFull;

- (NSInteger)leavel;
- (NSArray*)nodesInLeavel:(int)leavel;
// PreorderTraversal 先序遍历
- (void)printNodeNLR;
// InorderTraversal 中序遍历
- (void)printNodeLNR;
// PostorderTraversal 后序遍历
- (void)printNodeLRN;
@end
