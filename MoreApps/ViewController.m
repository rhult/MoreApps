//
//  ViewController.m
//  CrossPromo
//
//  Created by Richard Hult on 2012-09-14.
//  Copyright (c) 2012 Tinybird Interactive AB. All rights reserved.
//

#import "ViewController.h"
#import "MoreAppsViewController.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)hitMe
{
    MoreAppsViewController *controller = [[MoreAppsViewController alloc] init];
    controller.appIdentifier = @"DemoApp";
    controller.moreAppsURL = [[NSBundle mainBundle] URLForResource:@"index" withExtension:@"html"];
    controller.shouldShowDoneButton = YES;

    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentModalViewController:navController animated:YES];
}

@end
