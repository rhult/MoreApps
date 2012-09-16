//
//  DemoViewController.m
//  MoreApps
//
//  Created by Richard Hult on 2012-09-14.
//  Copyright (c) 2012 Tinybird Interactive AB. All rights reserved.
//

#import "DemoViewController.h"
#import "MoreAppsViewController.h"


@implementation DemoViewController

- (IBAction)hitMe
{
    MoreAppsViewController *controller = [[MoreAppsViewController alloc] init];
    controller.appIdentifier = @"DemoApp";
    controller.moreAppsURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    controller.shouldShowDoneButton = YES;

    // Wrap in a navigation controller for the modal case.
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentModalViewController:navController animated:YES];
}

@end
