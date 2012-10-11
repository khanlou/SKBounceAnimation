//
//  SizeBounceController.h
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 8/15/12.
//
//

#import "SizeBounceController.h"

@interface SizeBounceController ()

@end

@implementation SizeBounceController

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
	
	self.title = @"Size Bounce";

	bouncingView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
	bouncingView.center = CGPointMake(160, 200);
	bouncingView.backgroundColor = [UIColor blueColor];
	[self.view addSubview:bouncingView];

	UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addBounceAnimation)];
	[self.view addGestureRecognizer:tapGR];
	self.view.backgroundColor = [UIColor whiteColor];
}

- (void) addBounceAnimation {
	if (!CGRectContainsPoint(bouncingView.frame, CGPointMake(160, 200)) || !CGSizeEqualToSize(bouncingView.frame.size, CGSizeMake(40, 40))) {
		bouncingView.frame = CGRectMake(10, 10, 40, 40);
		bouncingView.center = CGPointMake(160, 200);
		return;
	}
	
	
	NSString *sizeKeyPath = @"bounds";
	id finalSize = [NSValue valueWithCGRect:CGRectMake(0, 0, 100, 100)];
	
	SKBounceAnimation *sizeAnimation = [SKBounceAnimation animationWithKeyPath:sizeKeyPath];
	sizeAnimation.fromValue = [NSValue valueWithCGRect:bouncingView.frame];
	sizeAnimation.toValue = finalSize;
	sizeAnimation.duration = 0.5f;
	sizeAnimation.numberOfBounces = 4;
	sizeAnimation.shouldOvershoot = YES;
	
	[bouncingView.layer addAnimation:sizeAnimation forKey:@"sizeKey"];
	
	[bouncingView.layer setValue:finalSize forKeyPath:sizeKeyPath];

}

@end
