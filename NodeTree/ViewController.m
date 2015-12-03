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
#import "NodesManager.h"
#import "ContainerView.h"
@interface ViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong)Node* rootNode;
@property (weak, nonatomic) IBOutlet UITextField *nodeNameTextField;
@property (assign)int count;
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (nonatomic, strong)ContainerView* containerView;
@property (nonatomic, strong)UILabel* printLabel;
@property (assign)float currentZoom; //not use
@property (assign)CGPoint currentOffSet;// not use
@property (weak, nonatomic) IBOutlet UISwitch *animationSwitch;

@property (nonatomic, strong)NSMutableArray * nodeViewsArray;
@property (nonatomic, strong)NSTimer* animationTimer;
@property (assign)int animationStep;
@property (weak, nonatomic) IBOutlet UIButton *LNRBtn;
@property (weak, nonatomic) IBOutlet UIButton *NLRBtn;
@property (weak, nonatomic) IBOutlet UIButton *LRNBtn;
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
        [self.nodeViewsArray removeAllObjects];
    }
}

- (void)drawNodeTree
{
    [self clearNodeTree];
    int leavel = (int)[self.rootNode leavel];
    int maxPoint = pow(2, leavel-1);
    float deviceWidth = [UIScreen mainScreen].bounds.size.width;
//    float spacingNodes = 50;
    float spacingEdgeWithNode = 0;
    float nodeWidth = 25;
    float nodeHeight = 50;
    if(leavel == 1){
        NodeView* nodeview = [NodeView createNodeView:self.rootNode andframe:CGRectMake((deviceWidth / 2) - (nodeWidth / 2), nodeHeight, nodeWidth, nodeHeight)];
        self.containerView = [[ContainerView alloc] initWithFrame:CGRectMake(0, 0, self.myScrollView.bounds.size.width, self.myScrollView.bounds.size.height)];
        [self.containerView setBackgroundColor:[UIColor whiteColor]];
        [self.myScrollView addSubview:self.containerView];
        [self.containerView addSubview:nodeview];
        return;
    }else{
        float containerViewH = ((leavel * 2) + 1) * nodeHeight > self.myScrollView.bounds.size.height ? ((leavel * 2) + 1) * nodeHeight : self.myScrollView.bounds.size.height;
        float containerViewW = self.myScrollView.bounds.size.width;

        if ((((maxPoint * 2) - 1) * nodeWidth) > self.myScrollView.bounds.size.width) {
            containerViewW = (((maxPoint * 2) - 1) * nodeWidth);
            [self.myScrollView setContentSize:CGSizeMake(containerViewW, containerViewH)];
        }else{
            spacingEdgeWithNode = (deviceWidth - (((maxPoint * 2) - 1) * nodeWidth)) / 2;
        }
        self.containerView = [[ContainerView alloc] initWithFrame:CGRectMake(0, 0, containerViewW, containerViewH)];
        [self.containerView setBackgroundColor:[UIColor whiteColor]];
        NodeView* rootNodeview = [NodeView createNodeView:self.rootNode andframe:CGRectMake((containerViewW / 2) - (nodeWidth / 2), nodeHeight, nodeWidth, nodeHeight)];
        [self.nodeViewsArray addObject:rootNodeview];
        [self.containerView addSubview:rootNodeview];
        for (int i = 2; i <= leavel; i++) {
            NSArray * array = [self.rootNode nodesInLeavel:i];
            for (int j = 0; j < [array count]; j++) {
                Node* node = [array objectAtIndex:j];
                NodeView* nv = [NodeView createNodeView:node andframe:CGRectMake(((pow(2, leavel - i)) - 1) * nodeWidth + j * (pow(2, (leavel - i + 1))) * nodeWidth + spacingEdgeWithNode, i * nodeHeight, nodeWidth * 2, nodeHeight)];
                [self.nodeViewsArray addObject:nv];
                [self.containerView addSubview:nv];
            }
        }
        [self.myScrollView addSubview:self.containerView];
        [self drawNodesLines];
    }
}

- (void)drawNodesLines
{
    for (NodeView* nv in self.nodeViewsArray) {
        Node* node = nv.node;
        if (node.leftNode) {
            if (node.rightNode) {
                for (NodeView* leftChild in self.nodeViewsArray) {
                    if (node.leftNode.nodeID == leftChild.node.nodeID) {
                        [self.containerView drawLineFrom:[nv getNodeBottomPoint] to:[leftChild getNodeTopPoint]];
                    }else if (node.rightNode.nodeID == leftChild.node.nodeID){
                        [self.containerView drawLineFrom:[nv getNodeBottomPoint] to:[leftChild getNodeTopPoint]];
                    }
                }
            }else{
                for (NodeView* leftChild in self.nodeViewsArray) {
                    if (node.leftNode.nodeID == leftChild.node.nodeID) {
                        [self.containerView drawLineFrom:[nv getNodeBottomPoint] to:[leftChild getNodeTopPoint]];
                    }
                }
            }
            
        }
    }
    [self.containerView setNeedsDisplay];
}

- (Node*)rootNode
{
    if (_rootNode == nil) {
        _rootNode = [Node createNodeWithName:@"0" andID:0];
    }
    return _rootNode;
}

- (IBAction)addNode:(id)sender {
    if (self.nodeNameTextField.text.length>0) {
        if (self.count == 0) {
            self.rootNode = [Node createNodeWithName:self.nodeNameTextField.text andID:0];
        }else{
            [self.rootNode addChildNode:[Node createNodeWithName:self.nodeNameTextField.text andID:self.count]];
        }
    }else{
        if (self.count == 0) {
            self.rootNode = [Node createNodeWithName:@"0" andID:0];
        }else{
            [self.rootNode addChildNode:[Node createNodeWithName:[NSString stringWithFormat:@"%d",(self.count)] andID:self.count]];
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
    [[[NodesManager sharedNodesManager] nodes] removeAllObjects];
    [self.rootNode printNodeLNR];
    [self printNodes];
    if (self.animationSwitch.isOn) {
        [self startAnimation];
    }
    
}

- (IBAction)NLR:(id)sender {
    [[[NodesManager sharedNodesManager] nodes] removeAllObjects];
    [self.rootNode printNodeNLR];
    [self printNodes];
    if (self.animationSwitch.isOn) {
        [self startAnimation];
    }
}

- (IBAction)LRN:(id)sender {
    [[[NodesManager sharedNodesManager] nodes] removeAllObjects];
    [self.rootNode printNodeLRN];
    [self printNodes];
    if (self.animationSwitch.isOn) {
        [self startAnimation];
    }
}

- (IBAction)animationSwitch:(id)sender {
    if (self.animationTimer) {
        [self.animationTimer invalidate];
        [self setTraversalBtnEnable:YES];
    }
}

- (void)timerTick:(NSTimer*)timer
{
    if (self.animationStep < [[[NodesManager sharedNodesManager] nodes] count]) {
        Node* node = [[[NodesManager sharedNodesManager] nodes] objectAtIndex:self.animationStep];
        for (NodeView* nv in self.nodeViewsArray) {
            if (nv.node.nodeID == node.nodeID) {
                [nv runBlinkAnimation];
            }
        }
        self.animationStep++;
    }else{
        [timer invalidate];
        self.animationStep = 0;
        [self setTraversalBtnEnable:YES];
    }

}

- (void)startAnimation
{
    self.animationTimer = [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    [self.animationTimer fire];
    self.animationStep = 0;
    
    [self setTraversalBtnEnable:NO];
}

- (void)printNodes
{
    if (self.containerView) {
        NSString* string = @"";
        for (Node* node in [[NodesManager sharedNodesManager] nodes]) {
            string = [string stringByAppendingString:[NSString stringWithFormat:@"%@、",node.name]];
        }
        int lines = (string.length * 14 / self.containerView.frame.size.width) + 1;
        if (self.printLabel) {
            [self.printLabel removeFromSuperview];
        }
        self.printLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.containerView.frame.size.width, lines * 30)];
        self.printLabel.numberOfLines = lines;
        self.printLabel.text = string;
        [self.containerView addSubview:self.printLabel];
    }
}

- (void)setTraversalBtnEnable:(BOOL)enable
{
    if (enable) {
        [self.LNRBtn setEnabled:YES];
        [self.NLRBtn setEnabled:YES];
        [self.LRNBtn setEnabled:YES];
    }else{
        [self.LNRBtn setEnabled:NO];
        [self.NLRBtn setEnabled:NO];
        [self.LRNBtn setEnabled:NO];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    self.currentZoom = scrollView.zoomScale;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.currentOffSet = scrollView.contentOffset;
}

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.containerView;
}

- (NSMutableArray*)nodeViewsArray
{
    if (_nodeViewsArray == nil) {
        _nodeViewsArray = [[NSMutableArray alloc] init];
    }
    return _nodeViewsArray;
}
@end
