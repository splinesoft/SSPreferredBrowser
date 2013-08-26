//
//  SSPreferredBrowser
//  Splinesoft
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIApplication+SSAppURLs.h"

// Keys for NSUserDefaults
extern NSString * const kSSPreferredBrowserKey;
extern NSString * const kSSShouldOpenURLsExternallyKey;

@interface SSPreferredBrowser : NSObject

#pragma mark - Installed Browsers

/**
 * Returns a dictionary of available browsers.
 * The keys are NSNumbers that correspond to `SSAppURLType` enum values. See `SSAppURLs`.
 * The values are localized strings of each browser's name.
 */
+ (NSDictionary *) availableBrowserDictionary;

#pragma mark - Preferred Browser

/**
 * Return the full localized name of the currently preferred browser.
 * Safari by default.
 */
+ (NSString *) preferredBrowserName;

/**
 * Return the type of the currently-preferred browser.
 */
+ (SSAppURLType) preferredBrowserType;

/**
 * Set the currently-preferred browser.
 * This should be one of the keys returned in `availableBrowserDictionary`.
 */
+ (void) setPreferredBrowserType:(SSAppURLType)browserType;

#pragma mark - Opening URLs Preference

/**
 * Return whether we should open URLs externally.
 */
+ (BOOL) shouldOpenURLsExternally;

/**
 * Set the user preference for opening URLs externally.
 */
+ (void) setShouldOpenURLsExternally:(BOOL)shouldOpenExternally;

#pragma mark - Open URLs

/**
 * Open a URL in our preferred browser
 */
+ (BOOL) openURLInPreferredBrowser:(NSString *)URLString;

@end
