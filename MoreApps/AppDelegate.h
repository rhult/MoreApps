//
//  AppDelegate.h
//  MoreApps
//
//  Created by Richard Hult on 2012-09-14.
//  Copyright (c) 2012 Tinybird Interactive AB. All rights reserved.
//

#import <UIKit/UIKit.h>


@class DemoViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property(strong, nonatomic) UIWindow *window;
@property(strong, nonatomic) DemoViewController *viewController;

@end
