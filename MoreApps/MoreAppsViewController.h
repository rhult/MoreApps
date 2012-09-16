//
//  MoreAppsViewController.h
//  MoreApps
//
//  Created by Richard Hult on 2011-10-09.
//  Copyright (c) 2011 Tinybird Interactive AB. All rights reserved.
//

#import <UIKit/UIKit.h>


@class MoreAppsViewController;

@protocol MoreAppsViewDelegate <NSObject>

// Optional, if not implemented, the view is just dismissed.
- (void)moreAppsViewFinished:(MoreAppsViewController *)controller;

@end

@interface MoreAppsViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate>

@property(nonatomic, unsafe_unretained) id<MoreAppsViewDelegate> delegate;
@property(nonatomic, strong) NSURL *moreAppsURL;
@property(nonatomic, copy) NSString *appIdentifier; // Used to filter out the app so it doesn't list itself.
@property(nonatomic, assign) BOOL shouldShowDoneButton;

// Override this to change the web view to your own UIWebView subclass if needed.
+ (Class)webViewClass;

@end
