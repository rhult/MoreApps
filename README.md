# More Apps for iOS

This Xcode project contains "More Apps" which is a simple UIViewController presenting a list of your other apps, and optionally apps by your friends/affiliates. The list is completely controlled from the server side, but in a static way so you don't need  a web service running, just a static file. Features:

* Works for both iPhone and iPad
* Can be updated without touching the app by editing the static contents on the server
* Can be used in a navigation hierarchy or as a modal view
* Handles the network being down, retries automatically when it goes up
* Localizable

## How it works

There is a client/app side, and a server side component. The client side is a is a simple view that shows the content of the URL you specify. The server side is a static web page using javascript to dynamically build the page on the client side, filtering a list of app definitions depending on locale, device type and app ID supplied by the app.

## What it looks like

![More Apps example screenshot](https://github.com/rhult/MoreApps/raw/master/Screenshots/Example.png)

## Using it

### Client side

SystemConfiguration.framework

### Server side

Copy the files in DemoData to your server:

- index.html
- moreapps.css
- moreapps.js

Create appdefinitions.js and fill it with your app definitions (see the version in Data/appdefinitions.js for an example). You can try it out by just view the local index.html on a desktop computer, passing various options like index.html?locale=sv_SE&device=ipad etc.

## Listing the available apps

The static server side file uses JSON to list app definitions. Two variables should be set up:

 foo = bar
 
 bar = foo

## Changes require no updates to the app

If you want to add or remove apps, or do things like update icons or descriptions, just edit the appdefinitions.js file and the app icons. Changes are then immediately visible in your apps using this.

## License

This project is available under the [BSD 2-Clause “Simplified” License](http://www.opensource.org/licenses/BSD-2-Clause):

Copyright (c) 2012, Tinybird Interactive AB <http://tinybird.com>  
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
