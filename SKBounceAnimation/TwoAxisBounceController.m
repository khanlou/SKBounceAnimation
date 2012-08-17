//
//  TwoAxisBounceController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "TwoAxisBounceController.h"

@interface TwoAxisBounceController ()

@end

@implementation TwoAxisBounceController

@synthesize bouncingView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.title = @"Two Axis Bounce";

	bouncingView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	bouncingView.center = CGPointMake(60, 60);
	bouncingView.backgroundColor = [UIColor blueColor];
	[self.view addSubview:bouncingView];

	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addBounceAnimation {
	if (!CGRectContainsPoint(bouncingView.frame, CGPointMake(60, 60))) {
		bouncingView.frame = CGRectMake(10, 10, 40, 40);
		bouncingView.center = CGPointMake(60, 60);
		return;
	}
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"position"];
	bounceAnimation.fromValue = [NSValue valueWithCGPoint:bouncingView.center];
	bounceAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(240, 340)];
	bounceAnimation.duration = 0.5f;
	bounceAnimation.numberOfBounces = 4;
	bounceAnimation.delegate = self;

	bounceAnimation.removedOnCompletion = NO;
	bounceAnimation.fillMode = kCAFillModeForwards;

	[bouncingView.layer addAnimation:bounceAnimation forKey:@"someKey"];
}

- (void) animationDidStop:(SKBounceAnimation *)animation finished:(BOOL)flag {
	[bouncingView.layer setValue:animation.toValue forKeyPath:animation.keyPath];
	[bouncingView.layer removeAnimationForKey:@"someKey"];
}
@end
