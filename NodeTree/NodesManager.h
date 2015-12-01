//
//  NodesManager.h
//  NodeTree
//
//  Created by wzb on 15/12/1.
//  Copyright © 2015年 shangyilian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NodesManager : NSObject
@property (nonatomic, strong)NSMutableArray* nodes;

+ (NodesManager*)sharedNodesManager;
@end
