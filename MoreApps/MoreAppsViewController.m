//
//  MoreAppsViewController.m
//  MoreApps
//
//  Created by Richard Hult on 2011-10-09.
//  Copyright (c) 2011 Tinybird Interactive AB. All rights reserved.
//

// Define to 0 if you don't want to use Reachability.
#define USE_REACHABILITY 1

#import "MoreAppsViewController.h"

#if USE_REACHABILITY
#import "Reachability.h"
#endif


#define kCssTemplate @"body { -webkit-text-size-adjust:none; font-family:HelveticaNeue; text-shadow:0px 1px 1px #d6d6d6; margin-top:2em; }" \
  @" h1 { font-size:17px; color:#2c2f33; }"
#define kHtmlTemplate @"<!DOCTYPE html><html><head><meta content=\"text/html; charset=utf-8\" http-equiv=\"Content-Type\">" \
  @"<style>" kCssTemplate @"</style></head><body><h1><center>%@</center></h1></body></html>"

typedef enum {
    kStateInitial = 0,
    kStateLoadingUpdating,
    kStateLoadingMoreApps,
    kStateDone,
    kStateError
} State;

@interface MoreAppsViewController () {
    NSURL *appStoreURL;
    UIAlertView *appStoreAlertView;
}

#if USE_REACHABILITY
@property(nonatomic, strong) Reachability *reachability;
#endif

@property(nonatomic, assign) State state;
@property(nonatomic, assign) BOOL shouldShowDoneButton;

@end

@implementation MoreAppsViewController

+ (Class)webViewClass
{
    return [UIWebView class];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _shouldShowDoneButton = YES;
    }
    return self;
}

- (NSURL *)fullURL
{
    if (self.moreAppsURL == nil) {
        NSLog(@"No MoreApps URL set");
        return nil;
    }

    NSMutableString *string = [NSMutableString string];
    [string appendString:[self.moreAppsURL absoluteString]];

    if ([self.moreAppsURL query]) {
        [string appendString:@"&"];
    } else {
        [string appendString:@"?"];
    }

    [string appendFormat:@"locale=%@", [[NSLocale currentLocale] localeIdentifier]];

    if (self.appIdentifier) {
        [string appendFormat:@"&me=%@", self.appIdentifier];
    }

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [string appendFormat:@"&device=iphone"];
    }

    return [NSURL URLWithString:string];
}

- (void)loadLocalPageWithContent:(NSString *)content
{
    NSString *string = [NSString stringWithFormat:kHtmlTemplate, content];
    [(UIWebView *)self.view loadHTMLString:string baseURL:[[NSBundle mainBundle] resourceURL]];
}

- (void)loadErrorPage
{
    self.state = kStateError;
    [self loadLocalPageWithContent:NSLocalizedString(@"There doesn't seem to be a working network connection. Please try again later.", @"MoreApps, error")];

#if USE_REACHABILITY
    self.reachability = [Reachability reachabilityForInternetConnection];
    self.reachability.delegate = self;
    [self.reachability startNotifier];
#endif
}

- (void)loadMoreAppsPage
{
    self.state = kStateLoadingMoreApps;

    if (self.moreAppsURL) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[self fullURL] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
        [(UIWebView *)self.view loadRequest:request];
    }
}

- (void)loadUpdatingPage
{
    self.state = kStateLoadingUpdating;
    [self loadLocalPageWithContent:NSLocalizedString(@"Updating...", @"MoreApps, loading")];
}

#if USE_REACHABILITY
- (void)reachabilityChanged
{
    if ([self.reachability currentReachabilityStatus] != kNotReachable) {
        [self.reachability stopNotifier];
        self.reachability = nil;
        [self loadUpdatingPage];
    }
}
#endif

- (void)loadView
{
    UIWebView *webView = [[[[self class] webViewClass] alloc] initWithFrame:CGRectZero];
    webView.delegate = self;
    webView.opaque = NO;
    webView.backgroundColor = [UIColor colorWithRed:0xbf/255.0 green:0xc0/255.0 blue:0xc2/255.0 alpha:1];

    self.view = webView;
    self.title = NSLocalizedString(@"More Apps", @"MoreApps, view controller title");

    [self loadUpdatingPage];
}

- (void)viewDidUnload
{
#if USE_REACHABILITY
    self.reachability = nil;
#endif

    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    // We want a Done button only if there is no navigation stack. This means it will works automagically for navigation
    // based UIs and also modal ones where there is just this controller added to a navigation controller.
    if (self.shouldShowDoneButton && [self.navigationController.viewControllers count] == 1) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    }
}

- (void)done
{
    if ([self.delegate respondsToSelector:@selector(moreAppsViewFinished:)]) {
        [self.delegate moreAppsViewFinished:self];
    } else {
        [self.parentViewController dismissModalViewControllerAnimated:YES];
    }
}

#pragma mark - UIAlertView delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex != [alertView cancelButtonIndex]) {
        [[UIApplication sharedApplication] openURL:appStoreURL];
    }

    appStoreURL = nil;
    appStoreAlertView = nil;
}

#pragma mark - Web View delegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[request.URL scheme] isEqualToString:@"file"]) {
        return YES;
    }
    if ([[request.URL scheme] isEqualToString:@"about"]) {
        return YES;
    }

    if ([[request.URL host] isEqualToString:[[self fullURL] host]]) {
        return YES;
    }

    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        appStoreURL = request.URL;
        appStoreAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Open App Store", @"MoreApps, app store alert title")
                                                       message:NSLocalizedString(@"This will open App Store to show the selected app.", @"MoreApps, app store alert")
                                                      delegate:self
                                             cancelButtonTitle:NSLocalizedString(@"Cancel", @"MoreApps, button")
                                             otherButtonTitles:NSLocalizedString(@"OK", @"MoreApps, button"), nil];
        [appStoreAlertView show];

        return NO;
    }

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    switch (self.state) {
        case kStateInitial:
            [self loadUpdatingPage];
            break;
        case kStateLoadingUpdating:
            // Just for testing the "Updating..." screen when running in local test mode.
            if ([[self.moreAppsURL scheme] isEqualToString:@"file"]) {
                [self performSelector:@selector(loadMoreAppsPage) withObject:nil afterDelay:1];
            } else {
                [self loadMoreAppsPage];
            }
            break;
        case kStateLoadingMoreApps:
            self.state = kStateDone;
            break;
        case kStateDone:
            break;
        case kStateError:
            // Nothing. Just wait for the network to come back.
            break;
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //NSLog(@"Did fail: %@", error);
    [self loadErrorPage];
}

@end
