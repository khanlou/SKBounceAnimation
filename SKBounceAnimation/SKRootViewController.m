//
//  SKRootViewController.m
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//notes
//byvalue weirdness?
//uicolor
//values less than 1

#import "SKRootViewController.h"

@interface SKRootViewController ()

@end

@implementation SKRootViewController

@synthesize bounceDemos, tableView;

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	
	self.bounceDemos = [NSArray arrayWithObjects:@"Y Position", @"X,Y Position", @"Size", @"Color", @"Scale", @"Scale and Rotate", @"Rect", nil];
	self.title = @"SKBounce";
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return bounceDemos.count;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (UITableViewCell*) tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSString *reuseIdentifier = @"aCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
	}
	cell.textLabel.text = [bounceDemos objectAtIndex:indexPath.row];
	
	return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *viewController = nil;
	switch (indexPath.row) {
		case 0:
			viewController = [[OneAxisBounceController alloc] init];
			break;
		case 1:
			viewController = [[TwoAxisBounceController alloc] init];
			break;
		case 2:
			viewController = [[SizeBounceController alloc] init];
			break;
		case 3:
			viewController = [[ColorBounceController alloc] init];
			break;
		case 4:
			viewController = [[ScaleBounceController alloc] init];
			break;
		case 5:
			viewController = [[ScaleRotateBounceController alloc] init];
			break;
		case 6:
			viewController = [[RectBounceController alloc] init];
			break;
			
		default:
			break;
	}
	[self.navigationController pushViewController:viewController animated:YES];
	[self.tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
