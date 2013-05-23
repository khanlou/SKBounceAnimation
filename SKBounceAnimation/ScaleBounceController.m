//
//  ScaleBounceController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "ScaleBounceController.h"

#define kSKStartingScale 0.7f

@interface ScaleBounceController ()

@end

@implementation ScaleBounceController

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

	bouncingView = [[UIImageView alloc] init];
	bouncingView.image = [UIImage imageNamed:@"uialertview-Blocks"];
	bouncingView.frame = CGRectMake(0, 0, bouncingView.image.size.width, bouncingView.image.size.height);
	bouncingView.center = CGPointMake(160, 200);
//	bouncingView.backgroundColor = [UIColor cyanColor];
	[self.view addSubview:bouncingView];
	
	
	bouncingView.layer.transform = CATransform3DMakeScale(kSKStartingScale, kSKStartingScale, kSKStartingScale);
	bouncingView.alpha = 0.0f;
	
	UILabel *textLabel = [[UILabel alloc] initWithFrame:bouncingView.bounds];
	textLabel.text = @"Click for a fake alert view";
	textLabel.textAlignment = UITextAlignmentCenter;
	textLabel.backgroundColor = [UIColor clearColor];
	[self.view addSubview:textLabel];
	
//	bouncingView.layer.transform = CATransform3DScale(bouncingView.layer.transform, 2, 2, 2);
	
	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addBounceAnimation {
	
	if (bouncingView.alpha == 1.0f) {
		bouncingView.alpha = 0.0f;
		bouncingView.layer.transform = CATransform3DMakeScale(kSKStartingScale, kSKStartingScale, kSKStartingScale);
		return;
	}
	
	CGFloat animationDuration = 0.28f;
	[UIView animateWithDuration:0.10f delay:0 options:UIViewAnimationCurveEaseOut animations:^{
		bouncingView.alpha = 1.0f;
	} completion:^(BOOL finished) {
		
	}];
	
	NSString *keyPath = @"transform";
	CATransform3D transform = bouncingView.layer.transform;
	id finalValue = [NSValue valueWithCATransform3D:
				  CATransform3DIdentity
				  ];
	
	SKBounceAnimation *bounceAnimation = [SKBounceAnimation animationWithKeyPath:keyPath];
	bounceAnimation.fromValue = [NSValue valueWithCATransform3D:transform];
	bounceAnimation.toValue = finalValue;
	bounceAnimation.duration = animationDuration;
	bounceAnimation.numberOfBounces = 3;
	bounceAnimation.stiffness = SKBounceAnimationStiffnessLight;
	bounceAnimation.shouldOvershoot = YES;
	
	[bouncingView.layer addAnimation:bounceAnimation forKey:@"someKey"];
	
	[bouncingView.layer setValue:finalValue forKeyPath:keyPath];
}

@end
