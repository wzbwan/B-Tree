//
//  NodeView.h
//  NodeTree
//
//  Created by wzb on 15/11/30.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Node;
@interface NodeView : UIView
@property(nonatomic, strong)Node* node;
@property(nonatomic, strong)UIImage* ndoeImage;
@property(nonatomic, strong)UILabel* nameLabel;

+ (instancetype)createNodeView:(Node*)node andframe:(CGRect)frame;
- (CGPoint)getNodeTopPoint;
- (CGPoint)getNodeBottomPoint;
@end
