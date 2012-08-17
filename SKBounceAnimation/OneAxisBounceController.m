//
//  SKBounceOneAxisViewController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "OneAxisBounceController.h"

@interface OneAxisBounceController ()

@end

@implementation OneAxisBounceController

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
	
	self.title = @"One Axis Bounce";

	bouncingView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	bouncingView.center = CGPointMake(160, 60);
	bouncingView.backgroundColor = [UIColor blueColor];
	[self.view addSubview:bouncingView];

	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addBounceAnimation {
	if (!CGRectContainsPoint(bouncingView.frame, CGPointMake(160, 60))) {
		bouncingView.frame = CGRectMake(10, 10, 40, 40);
		bouncingView.center = CGPointMake(160, 60);
		return;
	}
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"position.y"];
	bounceAnimation.fromValue = [NSNumber numberWithFloat:bouncingView.center.x];
	bounceAnimation.toValue = [NSNumber numberWithFloat:300];
	bounceAnimation.duration = 0.5f;
	bounceAnimation.delegate = self;
	bounceAnimation.numberOfBounces = 4;
	bounceAnimation.shouldOvershoot = YES;

	bounceAnimation.removedOnCompletion = NO;
	bounceAnimation.fillMode = kCAFillModeForwards;

	[bouncingView.layer addAnimation:bounceAnimation forKey:@"someKey"];
}

- (void) animationDidStop:(SKBounceAnimation *)animation finished:(BOOL)flag {
	[bouncingView.layer setValue:animation.toValue forKeyPath:animation.keyPath];
	[bouncingView.layer removeAnimationForKey:@"someKey"];
}
@end
