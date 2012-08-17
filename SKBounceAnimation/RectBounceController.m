//
//  RectBounceController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "RectBounceController.h"

@interface RectBounceController ()

@end

@implementation RectBounceController

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
	
	self.title = @"Rect Bounce";

	bouncingView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	bouncingView.center = CGPointMake(60, 60);
	bouncingView.backgroundColor = [UIColor blueColor];
	[self.view addSubview:bouncingView];

	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addBounceAnimation {
	if (!CGRectContainsPoint(bouncingView.frame, CGPointMake(60, 60)) || !CGSizeEqualToSize(bouncingView.frame.size, CGSizeMake(40, 40))) {
		bouncingView.frame = CGRectMake(10, 10, 40, 40);
		bouncingView.center = CGPointMake(60, 60);
		return;
	}
	SKBounceAnimation *sizeAnimation = [SKBounceAnimation animationWithKeyPath:@"bounds"];
	sizeAnimation.fromValue = [NSValue valueWithCGRect:bouncingView.frame];
	sizeAnimation.toValue = [NSValue valueWithCGRect:
						  CGRectMake(0, 0, 100, 100)
						  ];
	sizeAnimation.duration = 0.5f;
	sizeAnimation.numberOfBounces = 4;
	sizeAnimation.delegate = self;

	sizeAnimation.removedOnCompletion = NO;
	sizeAnimation.fillMode = kCAFillModeForwards;

	[bouncingView.layer addAnimation:sizeAnimation forKey:@"someKey"];
	
	
	
	
	SKBounceAnimation *positionAnimation = [SKBounceAnimation animationWithKeyPath:@"position"];
	positionAnimation.fromValue = [NSValue valueWithCGPoint:bouncingView.center];
	positionAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
	positionAnimation.duration = 0.5f;
	positionAnimation.numberOfBounces = 4;
	positionAnimation.delegate = self;
	
	positionAnimation.removedOnCompletion = NO;
	positionAnimation.fillMode = kCAFillModeForwards;
	
	[bouncingView.layer addAnimation:positionAnimation forKey:@"someKey2"];

}

- (void) animationDidStop:(SKBounceAnimation *)animation finished:(BOOL)flag {
	[bouncingView.layer setValue:animation.toValue forKeyPath:animation.keyPath];
	[bouncingView.layer removeAnimationForKey:@"someKey"];
	[bouncingView.layer removeAnimationForKey:@"someKey2"];
}
@end
