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
	
	NSString *keyPath = @"position";
	id finalValue = [NSValue valueWithCGPoint:CGPointMake(240, 340)];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCGPoint:bouncingView.center];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = 0.5f;
	bounceAnimation.numberOfBounces = 4;
	bounceAnimation.shouldOvershoot = YES;

	
	[bouncingView.layer addAnimation:bounceAnimation forKey:@"someKey"];
	
	[bouncingView.layer setValue:finalValue forKeyPath:keyPath];
}

@end
