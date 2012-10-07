//
//  MoreAppsViewController.h
//  MoreApps
//
//  Created by Richard Hult on 2011-10-09.
//  Copyright (c) 2011 Tinybird Interactive AB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@protocol MoreAppsViewDelegate;

@interface MoreAppsViewController : UIViewController <UIWebViewDelegate, UIAlertViewDelegate, SKStoreProductViewControllerDelegate>

@property(nonatomic, weak) id<MoreAppsViewDelegate> delegate;
@property(nonatomic, strong) NSURL *moreAppsURL;
@property(nonatomic, copy) NSString *appIdentifier; // Used to filter out the app so it doesn't list itself.

// Override this to change the web view to your own UIWebView subclass if needed.
+ (Class)webViewClass;

@end

@protocol MoreAppsViewDelegate <NSObject>

// Optional, if not implemented, the view is just dismissed.
- (void)moreAppsViewFinished:(MoreAppsViewController *)controller;

@end
