//
//  AboutViewController.m
//  NodeTree
//
//  Created by 王 增宝 on 15/12/2.
//  Copyright © 2015年 wzbwan. All rights reserved.
//

#import "AboutViewController.h"
#import "POP.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardView;
// tips1Label;
@property (weak, nonatomic) IBOutlet UILabel *tips1Label;
@property (weak, nonatomic) IBOutlet UILabel *tips2Label;
@property (weak, nonatomic) IBOutlet UILabel *tips3Label;
@property (weak, nonatomic) IBOutlet UILabel *tips4Label;

@property (assign)CGPoint birthPosition;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.cardView.layer.cornerRadius = 6;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.cardView.bounds];
    
    self.cardView.layer.masksToBounds = NO;
    
    self.cardView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.cardView.layer.shadowOffset = CGSizeMake(5, 5);
    
    self.cardView.layer.shadowOpacity = 0.5f;
    
    self.cardView.layer.shadowPath = shadowPath.CGPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)runCardComeAnimation:(CGPoint)point
{
    CGRect device = [UIScreen mainScreen].bounds;
    self.birthPosition = point;
    POPSpringAnimation* comeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    comeAnim.fromValue = [NSValue valueWithCGPoint:point];
    comeAnim.toValue = [NSValue valueWithCGPoint:CGPointMake((device.size.width / 2), (device.size.height / 2))];
    comeAnim.delegate = self;
    comeAnim.name = @"comeAnim";
    [self.cardView.layer pop_addAnimation:comeAnim forKey:nil];
    
    POPSpringAnimation* scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    [self.cardView.layer pop_addAnimation:scaleAnim forKey:nil];
}

- (void)runCardOutAnimation{
    POPSpringAnimation* comeAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    comeAnim.toValue = [NSValue valueWithCGPoint:self.birthPosition];
    [self.cardView.layer pop_addAnimation:comeAnim forKey:nil];
    
    POPSpringAnimation* scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    scaleAnim.delegate = self;
    scaleAnim.name = @"leaveAnim";
    [self.cardView.layer pop_addAnimation:scaleAnim forKey:nil];
}

- (void)runTipsHideAnimation
{
    POPSpringAnimation* fadeHideAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    fadeHideAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    fadeHideAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    [self.tips1Label.layer pop_addAnimation:fadeHideAnim forKey:nil];
    [self.tips2Label.layer pop_addAnimation:fadeHideAnim forKey:nil];
    [self.tips3Label.layer pop_addAnimation:fadeHideAnim forKey:nil];
    [self.tips4Label.layer pop_addAnimation:fadeHideAnim forKey:nil];
}

- (void)prepareForHideTips
{
    NSLog(@"tips opacity %f",self.tips1Label.layer.opacity);
    if (self.tips1Label.layer.opacity <= 0.01) {
        self.tips1Label.layer.opacity = 1;
        self.tips2Label.layer.opacity = 1;
        self.tips3Label.layer.opacity = 1;
        self.tips4Label.layer.opacity = 1;
        [self performSelector:@selector(runTipsHideAnimation) withObject:nil afterDelay:2];
    }
}

- (void)runScaleAnimation:(UIView*)view scaleFrom:(float)size to:(float)scale
{
    POPSpringAnimation* scaleAnim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnim.fromValue = [NSValue valueWithCGPoint:CGPointMake(size, size)];
    scaleAnim.toValue = [NSValue valueWithCGPoint:CGPointMake(scale, scale)];
    [view.layer pop_addAnimation:scaleAnim forKey:nil];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished
{
    if ([anim.name isEqualToString:@"leaveAnim"]) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }else if ([anim.name isEqualToString:@"comeAnim"]){
        [self performSelector:@selector(runTipsHideAnimation) withObject:nil afterDelay:1.5];
    }
}

- (IBAction)tap:(id)sender {
    UITapGestureRecognizer* tap = (UITapGestureRecognizer*)sender;
    CGPoint tapPoint = [tap locationInView:self.cardView];
    if (tapPoint.x < 0 || tapPoint.x > self.cardView.frame.size.width || tapPoint.y < 0 || tapPoint.y > self.cardView.frame.size.height) {
        [self runCardOutAnimation];
    }else{
        [self prepareForHideTips];
    }
}

- (IBAction)btnTouchDown:(id)sender {
    
}

- (IBAction)btnDragExit:(id)sender {
    
}

- (IBAction)githubLink:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/wzbwan/B-Tree"]];
}

- (IBAction)mailLink:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:wzbwan@iCloud.com"]];
}

- (IBAction)wechatLink:(id)sender {
    
}

- (IBAction)websiteLink:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://zengbao.wang"]];
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
