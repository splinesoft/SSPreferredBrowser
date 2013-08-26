# SSPreferredBrowser

![](http://cocoapod-badges.herokuapp.com/v/SSPreferredBrowser/badge.png) &nbsp; ![](http://cocoapod-badges.herokuapp.com/p/SSPreferredBrowser/badge.png)

Quickly present available web browsers, save prefs, and perform common browser actions.

`SSPreferredBrowser` makes it easy to build a table like this:

![](https://raw.github.com/splinesoft/SSPreferredBrowser/master/Example/browser.png)

`SSPreferredBrowser` can also open URLs in the user's preferred browser and provides localized names for browsers installed on the user's device.

`SSPreferredBrowser` is powered by [SSAppURLs](https://github.com/splinesoft/SSAppURLs), a nifty way to check for and open iOS URL schemes.

`SSPreferredBrowser` powers browser selection and open-in-browser behavior in my app [MUDRammer - A Modern MUD Client for iPhone and iPad](https://itunes.apple.com/us/app/mudrammer-a-modern-mud-client/id597157072?mt=8).

# Install

Install with [Cocoapods](http://cocoapods.org/). Add to your Podfile:

```
pod 'SSPreferredBrowser', :head # YOLO
```

# Example

Check out `Example` for the source code of the table in the screenshot above.

```objc
// If the user prefers to use an external browser over an in-app webview,
// then open a URL in the user's preferred browser
if( [SSPreferredBrowser shouldOpenURLsExternally] ) {
    // The user's preferred browser name, localized. 
    // Something like "Chrome" or "Opera Mini"
    NSLog(@"Opening a URL in %@!", [SSPreferredBrowser preferredBrowserName]);

    [SSPreferredBrowser openURLInPreferredBrowser:@"http://www.splinesoft.net"];
} else {
	// Open an in-app webview
}
```

# Browsers

`SSPreferredBrowser` supports Safari, Chrome, Opera Mini, and 1Password.

New browsers and localizations are welcome!

# Thanks!

`SSPreferredBrowser` is a [@jhersh](https://github.com/jhersh) production -- ([electronic mail](mailto:jon@her.sh) | [@jhersh](https://twitter.com/jhersh))