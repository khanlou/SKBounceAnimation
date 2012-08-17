//
//  ScaleRotateBounceController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "ScaleRotateBounceController.h"

@interface ScaleRotateBounceController ()

@end

@implementation ScaleRotateBounceController

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
	
	self.title = @"Scale Bounce";

	bouncingView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	bouncingView.center = CGPointMake(160, 200);
	bouncingView.backgroundColor = [UIColor cyanColor];
	[self.view addSubview:bouncingView];
	
	UILabel *textLabel = [[UILabel alloc] initWithFrame:bouncingView.bounds];
	textLabel.text = @"text";
	textLabel.textAlignment = UITextAlignmentCenter;
	textLabel.backgroundColor = [UIColor clearColor];
	[bouncingView addSubview:textLabel];
	
//	bouncingView.layer.transform = CATransform3DScale(bouncingView.layer.transform, 2, 2, 2);

	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addBounceAnimation {
	if (!CGRectContainsPoint(bouncingView.frame, CGPointMake(160, 200))) {
		bouncingView.frame = CGRectMake(10, 10, 40, 40);
		bouncingView.center = CGPointMake(160, 200);
		return;
	}
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:@"transform"];
	CATransform3D transform = bouncingView.layer.transform;
	bounceAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
	bounceAnimation.toValue = [NSValue valueWithCATransform3D:
						  CATransform3DScale(CATransform3DRotate(transform, M_PI/4, 0, 0, 1), 1.5, 1.5, 1.5)
						  ];
	bounceAnimation.duration = 0.5f;
	bounceAnimation.numberOfBounces = 2;
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
