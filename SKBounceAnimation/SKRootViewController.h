//
//  SKRootViewController.h
//  SKBounceAnimation
//
//  Created by Soroush Khanlou on 6/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneAxisBounceController.h"
#import "TwoAxisBounceController.h"
#import "RectBounceController.h"
#import "ColorBounceController.h"
#import "SizeBounceController.h"
#import "ScaleBounceController.h"
#import "ScaleRotateBounceController.h"

@interface SKRootViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *bounceDemos;

@end
