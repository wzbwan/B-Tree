//
//  ViewController.m
//  NodeTree
//
//  Created by wzb on 15/11/30.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "ViewController.h"
#import "Node.h"
#import "NodeView.h"
#import <math.h>
@interface ViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)Node* rootNode;
@property (weak, nonatomic) IBOutlet UITextField *nodeNameTextField;
@property (assign)int count;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong)UIView* containerView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.count = 0;
    for (UIView* view in self.view.subviews) {
        if (view.tag == 1) {
            view.layer.cornerRadius = 6;
        }
    }

//    for (int i = 66; i <= 80; i++) {
//        [self.rootNode addChildNode:[Node createNodeWithName:[NSString stringWithFormat:@"%c",i]]];
//    }
//    NSLog(@"NLR:前序遍历");
//    [self.rootNode printNodeNLR];
//    NSLog(@"LNR:中序遍历");
//    [self.rootNode printNodeLNR];
//    NSLog(@"LRN:后序遍历");
//    [self.rootNode printNodeLRN];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)clearNodeTree
{
    if (self.containerView) {
        [self.containerView removeFromSuperview];
        [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.bounds.size.width, self.myScrollView.bounds.size.height)];
    }
}

- (void)drawNodeTree
{
    [self clearNodeTree];
    int leavel = (int)[self.rootNode leavel];
    NSLog(@"leavel: %d",leavel);
    int maxPoint = pow(2, leavel-1);
    NSLog(@"maxPoint: %d",maxPoint);
    float deviceWidth = [UIScreen mainScreen].bounds.size.width;
//    float spacingNodes = 50;
    float spacingEdgeWithNode = 0;
    float nodeWidth = 25;
    float nodeHeight = 50;
    if(leavel == 1){
        NodeView* nodeview = [NodeView createNodeView:self.rootNode andframe:CGRectMake((deviceWidth / 2) - (nodeWidth / 2), nodeHeight, nodeWidth, nodeHeight)];
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.myScrollView.bounds.size.width, self.myScrollView.bounds.size.height)];
        [self.myScrollView addSubview:self.containerView];
        [self.containerView addSubview:nodeview];
        return;
    }else{
        float containerViewH = ((leavel * 2) + 1) * nodeHeight > self.myScrollView.bounds.size.height ? ((leavel * 2) + 1) * nodeHeight : self.myScrollView.bounds.size.height;
        float containerViewW = self.myScrollView.bounds.size.width;

        if ((((maxPoint * 2) - 1) * nodeWidth) > self.myScrollView.bounds.size.width) {
            containerViewW = (((maxPoint * 2) - 1) * nodeWidth);
        }else{
            spacingEdgeWithNode = (deviceWidth - (((maxPoint * 2) - 1) * nodeWidth)) / 2;
        }
        NSLog(@"containerW %f",containerViewW);
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, containerViewW, containerViewH)];
        [self.myScrollView setContentSize:CGSizeMake(containerViewW, containerViewH)];
        NodeView* rootNodeview = [NodeView createNodeView:self.rootNode andframe:CGRectMake((containerViewW / 2) - (nodeWidth / 2), nodeHeight, nodeWidth, nodeHeight)];
        [self.containerView addSubview:rootNodeview];
        for (int i = 2; i <= leavel; i++) {
            NSArray * array = [self.rootNode nodesInLeavel:i];
            for (int j = 0; j < [array count]; j++) {
                Node* node = [array objectAtIndex:j];
                NodeView* nv = [NodeView createNodeView:node andframe:CGRectMake(((pow(2, leavel - i)) - 1) * nodeWidth + j * (pow(2, (leavel - i + 1))) * nodeWidth + spacingEdgeWithNode, i * nodeHeight, nodeWidth * 2, nodeHeight)];
                [self.containerView addSubview:nv];
            }
        }
        [self.myScrollView addSubview:self.containerView];
    }
}

- (Node*)rootNode
{
    if (_rootNode == nil) {
        _rootNode = [Node createNodeWithName:@"0"];
    }
    return _rootNode;
}

- (IBAction)addNode:(id)sender {
    if (self.nodeNameTextField.text.length>0) {
        if (self.count == 0) {
            self.rootNode = [Node createNodeWithName:self.nodeNameTextField.text];
        }else{
            [self.rootNode addChildNode:[Node createNodeWithName:self.nodeNameTextField.text]];
        }
    }else{
        if (self.count == 0) {
            self.rootNode = [Node createNodeWithName:@"0"];
        }else{
            [self.rootNode addChildNode:[Node createNodeWithName:[NSString stringWithFormat:@"%d",(self.count)]]];
        }
    }
    self.count ++;
    [self drawNodeTree];
}

- (IBAction)removeNode:(id)sender {
    self.rootNode = nil;
    self.count = 0;
    [self clearNodeTree];
}

- (IBAction)LNR:(id)sender {

}

- (IBAction)NLR:(id)sender {

}

- (IBAction)LRN:(id)sender {

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
@end
