//
//  DrawIconViewController.m
//  NodeTree
//
//  Created by 王 增宝 on 15/12/3.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "DrawIconViewController.h"
#import "Line.h"
#import "DrawIconView.h"
#import "ViewController.h"

@interface DrawIconViewController ()

@end

@implementation DrawIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect device = [UIScreen mainScreen].bounds;
    float r = 32;
    float hr = 16;
    float h = 68;
    float width = 320;
    if (device.size.width > 700) {
        r = 50;
        hr = 25;
        h = 130;
        width = 500;
    }
    NSLog(@"%f",device.size.width);
    float dd = (device.size.width - width) / 2;
    float hh = (device.size.height / 2) - hr;
    UIImageView* root = [self getCycle:CGPointMake(dd  + (9 * hr), hh - h)];
    [self.view addSubview:root];
    UIImageView* node1 = [self getCycle:CGPointMake(dd + (3 * hr), hh)];
    [self.view addSubview:node1];
    UIImageView* node2 = [self getCycle:CGPointMake(dd + (15 * hr), hh)];
    [self.view addSubview:node2];

    UIImageView* node3 = [self getCycle:CGPointMake(dd, hh + h)];
    [self.view addSubview:node3];
    UIImageView* node4 = [self getCycle:CGPointMake(dd + (6 * hr), hh + h)];
    [self.view addSubview:node4];
    UIImageView* node5 = [self getCycle:CGPointMake(dd + (12 * hr), hh + h)];
    [self.view addSubview:node5];
    UIImageView* node6 = [self getCycle:CGPointMake(dd + (18 * hr), hh + h)];
    [self.view addSubview:node6];
    
//    Line* line1 = [Line createLineFrom:root.center to:node1.center];
//    Line* line2 = [Line createLineFrom:root.center to:node2.center];
//    Line* line3 = [Line createLineFrom:node1.center to:node3.center];
//    Line* line4 = [Line createLineFrom:node1.center to:node4.center];
//    Line* line5 = [Line createLineFrom:node2.center to:node5.center];
//    Line* line6 = [Line createLineFrom:node2.center to:node6.center];
//    DrawIconView* view = (DrawIconView*)self.view;
//    [view getLines:@[line1,line2,line3,line4,line5,line6]];
    [self addMoveAnim:root positionY:node1.layer.position.y];
    [self addMoveAnim:node3 positionY:node1.layer.position.y];
    [self addMoveAnim:node4 positionY:node1.layer.position.y];
    [self addMoveAnim:node5 positionY:node1.layer.position.y];
    [self addMoveAnim:node6 positionY:node1.layer.position.y];
    [self performSelector:@selector(switchToMainView) withObject:nil afterDelay:1];
}

- (void)addMoveAnim:(UIView*)view positionY:(float)y
{
    CABasicAnimation* moveAnim = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, view.layer.position.y)];
    moveAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(view.layer.position.x, y)];
    moveAnim.duration = 1.0f;
    moveAnim.timingFunction = UIViewAnimationCurveEaseInOut;
    [view.layer addAnimation:moveAnim forKey:@"move"];
}

- (void)switchToMainView
{
    UIWindow * window =[[[UIApplication sharedApplication] windows] objectAtIndex:0];
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController* mainView = [storyboard instantiateViewControllerWithIdentifier:@"mainViewController"];
    window.rootViewController = mainView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImageView*)getCycle:(CGPoint)point
{
    CGRect device = [UIScreen mainScreen].bounds;
    float r = 32;
    if (device.size.width > 700) {
        r = 50;
    }
    UIImageView* cycle = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, r, r)];
    cycle.image = [UIImage imageNamed:@"cycle4.png"];
    return cycle;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
