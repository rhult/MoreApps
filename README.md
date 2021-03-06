# More Apps - Cross promotion for iOS apps

Say you have an app that is awesome and gets lots of downloads every day. What if you could easily tell those users that you have a bunch of apps that are equally awesome, and that they should check them out too!

"More Apps" is my attempt at solving this in a hopefully unobtrusive and very pragmatic way.

This Xcode project contains "More Apps" which is a simple UIViewController presenting a list of your other apps, and optionally apps by your friends/affiliates. The list is completely controlled from the server side, but in a static way so you don't need  a web service running, just a static file. Features:

* Open source license
* Works for both iPhone and iPad
* Can be updated without touching the app by editing the static contents on the server
* Can be used in a navigation hierarchy or as a modal view
* Optionally handles the network being down, retries automatically when it goes up
* Localizable (not to 100% yet but patches are welcome)
* Uses StoreKit to show the App Store product page inside the app on iOS 6, opens App Store for iOS 5.

## Try it

Just open the project in Xcode, and hit Run. Note that the App Store can't be opened in the simulator so if you want to try all the aspects you might want to run on an actual device.

## How it works

There is a client side component (for the app), and a server side component. The client side is a simple view that shows the content of the URL you specify, and some logic to handle progress indication and  error handling. It also takes care of opening the App Store in a civilized manner (including using the StoreKit provided UI on iOS 6). The server side is a static web page using javascript to dynamically build the page on the client side, filtering a list of app definitions depending on locale, device type and app ID supplied by the app.

## What it looks like

The CSS is based on the original App Store search listings which since have changed dramatically in iOS 6. The good news is you can easily tweak this by editing the CSS yourself if you want another look. Here's the default style:

![More Apps example screenshot](https://github.com/rhult/MoreApps/raw/master/Screenshots/Example.png)

If anyone creates other styles, don't hesitate to let me know so I can incorporate them here.

## Using it

### Client side

You need the two files MoreAppsViewController.m and MoreAppsViewController.h. You need to add StoreKit.framework to the linked frameworks.

You can also add the included Reachability class, or use your own copy if you already have one. If you do, the view controller will automatically reload once the network becomes available in case an error occurred. If you do choose to use Reachability, make sure to add SystemConfiguration.framework to the linked in frameworks.

#### Example of presenting the view
```objective-c
MoreAppsViewController *controller = [[MoreAppsViewController alloc] init];
controller.appIdentifier = @"DemoApp";
controller.moreAppsURL = [NSURL URLWithString:@"http://mynonexistingwebsite.com/mypromopage.html"];

// Wrap in a navigation controller for the modal case.
UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
[self presentModalViewController:navController animated:YES];
```

### Server side

Copy the following files in the DemoData folder to your server:

- index.html
- moreapps.css
- moreapps.js

Create appdefinitions.js and fill it with your app definitions (see below). You can try it out by just viewing the local index.html on a desktop computer browser, passing various options like index.html?locale=sv_SE&device=iphone etc.

#### Listing the available apps

The static server side file uses javascript to define one or two variables with JSON structures. Those two are:

    appDefinitions = { ... } // For your list of apps.
    affiliateAppDefinitions = { ... } // Optional list with apps from affiliates or friends.

The easiest way to get started is to look at the example version in DemoData/appdefinitions.js and edit it for your own purposes. An example of an app entry:

```js
    { "id": "addidoku", // Identifier, used to filter out "self" from the app list. Just a string.
      "name": "Addidoku", // Either a dict with language/name pairs, or just the name if it's not localized.
      "category": "Games",
      "summary": { // Same as name, either a dict or just the summary.
        "en": "Addictive Casual Puzzler",
        "sv": "Beroendeframkallande pusselspel"
      },
      "link": "http://itunes.apple.com/app/id510574334?mt=8",
      "icon": "addidoku-114.png",
      "type": "free", // Can be free or paid, affects the title of the button when running on iPad.
      "showOnLocales": [], // List of locales, e.g. [ "sv_SE", "nn" ]. Empty list means show on all locales.
      "showOnDevices": [] // List of device types, e.g. [ "iphone", "ipad" ]. Empty list means show on all devices.
    }
```

#### Icons

The app icons you provide should be 114x114, and the HTML/CSS output will make them look sharp on retina devices, and still have the right size on non-retina devices. The corners are rounded for you so you can just use your regular app icons.

## Changes require no updates to the app

If you want to add or remove apps, or do things like update icons or descriptions, just edit the appdefinitions.js file and the app icons. Changes are then immediately visible in your apps using this.

## Limitations

As you see in the screenshot above, there is no information about the prices. You could hack the code to display the right price and currency depending on the locale but since it would have to be done manually, I went with the much simpler solution - to not show the price.

# License

This project is available under the [BSD 2-Clause “Simplified” License](http://www.opensource.org/licenses/BSD-2-Clause):

Copyright (c) 2012, Tinybird Interactive AB <http://tinybird.com>  
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
