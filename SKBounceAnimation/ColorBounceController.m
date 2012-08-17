//
//  ColorBounceController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "ColorBounceController.h"

@interface ColorBounceController ()

@end

@implementation ColorBounceController

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
	
	self.title = @"Color Bounce";

	bouncingView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	bouncingView.center = CGPointMake(160, 200);
	bouncingView.backgroundColor = [UIColor redColor];
	[self.view addSubview:bouncingView];
	
	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}	- (void) addBounceAnimation {
	if (!CGRectContainsPoint(bouncingView.frame, CGPointMake(160, 200))) {
		bouncingView.frame = CGRectMake(10, 10, 40, 40);
		bouncingView.center = CGPointMake(160, 200);
		return;
	}
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"backgroundColor"];
	bounceAnimation.fromValue = [UIColor redColor];
	bounceAnimation.toValue = [UIColor blueColor];
	bounceAnimation.duration = 1.5f;
	bounceAnimation.numberOfBounces = 2;
	bounceAnimation.delegate = self;
//	bounceAnimation.shouldOvershoot = NO;

	bounceAnimation.removedOnCompletion = NO;
	bounceAnimation.fillMode = kCAFillModeForwards;

	[bouncingView.layer addAnimation:bounceAnimation forKey:@"someKey"];
}

- (void) animationDidStop:(SKBounceAnimation *)animation finished:(BOOL)flag {
	[bouncingView.layer setValue:animation.toValue forKeyPath:animation.keyPath];
	[bouncingView.layer removeAnimationForKey:@"someKey"];
	if ([animation.toValue isKindOfClass:[UIColor class]]) {
		[bouncingView.layer setValue:(id)((UIColor*)animation.toValue).CGColor forKeyPath:animation.keyPath];
	}
}
@end
