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

- (UINavigationController *)moreAppsNavigationViewController
{
    MoreAppsViewController *controller = [[MoreAppsViewController alloc] init];
    controller.appIdentifier = @"DemoApp";

    // For local testing, we just point to the included page.
    controller.moreAppsURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];

    // For a real-world app, point to your web server.
    //controller.moreAppsURL = [NSURL URLWithString:@"<my web site here>"];

    // Wrap in a navigation controller for the modal case.
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    return navController;
}

- (IBAction)hitMe
{
    UINavigationController *navController = [self moreAppsNavigationViewController];

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navController.modalPresentationStyle = UIModalPresentationPageSheet;
    }

    [self presentModalViewController:navController animated:YES];
}

@end
