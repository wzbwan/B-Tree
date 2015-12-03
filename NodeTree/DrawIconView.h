//
//  DrawIconView.h
//  NodeTree
//
//  Created by 王 增宝 on 15/12/3.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawIconView : UIView
@property(nonatomic, strong)NSArray* lines;
- (void)getLines:(NSArray*)lines;
@end
