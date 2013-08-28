//
//  SSPreferredBrowser
//  Splinesoft
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSPreferredBrowser.h"

NSString * const kSSPreferredBrowserKey = @"SS-Preferred-Browser";
NSString * const kSSShouldOpenURLsExternallyKey = @"SS-Open-URLS-Externally";

static inline NSString * SSLocalizedBrowserWithType(SSAppURLType type) {
    NSString *key;
    
    switch( type ) {
        case SSAppURLTypeChromeHTTP:
        case SSAppURLTypeChromeHTTPS:
            key = @"CHROME";
            break;
        case SSAppURLType1PasswordHTTP:
        case SSAppURLType1PasswordHTTPS:
            key = @"1PW";
            break;
        case SSAppURLTypeSafariHTTP:
        case SSAppURLTypeSafariHTTPS:
            key = @"SAFARI";
            break;
        case SSAppURLTypeOperaHTTP:
        case SSAppURLTypeOperaHTTPS:
            key = @"OPERA";
            break;
        default:
            break;
    }
    
    return NSLocalizedStringFromTable(key, @"SSPreferredBrowsers", nil);
};

@implementation SSPreferredBrowser

#pragma mark - Installed Browsers

+ (NSDictionary *)availableBrowserDictionary {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObject:SSLocalizedBrowserWithType(SSAppURLTypeSafariHTTP)
                                                                   forKey:@(SSAppURLTypeSafariHTTP)];
    
    for( NSNumber *browser in @[
            @(SSAppURLTypeChromeHTTP),
            @(SSAppURLType1PasswordHTTP),
            @(SSAppURLTypeOperaHTTP),
        ] ) {
        
        SSAppURLType browserType = (SSAppURLType)[browser unsignedIntegerValue];
        
        if( [[UIApplication sharedApplication] canOpenAppType:browserType] )
            [dict setObject:SSLocalizedBrowserWithType(browserType)
                     forKey:@(browserType)];
    }
    
    return [dict copy];
}

#pragma mark - Preferred Browser

+ (SSAppURLType)preferredBrowserType {
    SSAppURLType preferredBrowser = (SSAppURLType)[[NSUserDefaults standardUserDefaults]
                                                   integerForKey:kSSPreferredBrowserKey];
    
    if( ![[[self availableBrowserDictionary] allKeys] containsObject:@(preferredBrowser)] )
        return SSAppURLTypeSafariHTTP;
    
    return preferredBrowser;
}

+ (NSString *)preferredBrowserName {
    return SSLocalizedBrowserWithType([self preferredBrowserType]);
}

+ (void) setPreferredBrowserType:(SSAppURLType)browserType {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:browserType forKey:kSSPreferredBrowserKey];
}

#pragma mark - Opening URLs preference

+ (void)setShouldOpenURLsExternally:(BOOL)shouldOpenExternally {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:shouldOpenExternally forKey:kSSShouldOpenURLsExternallyKey];
}

+ (BOOL)shouldOpenURLsExternally {
    return [[NSUserDefaults standardUserDefaults] boolForKey:kSSShouldOpenURLsExternallyKey];
}

#pragma mark - Opening URLs

+ (BOOL)openURLInPreferredBrowser:(NSString *)URLString {
    if( [URLString length] == 0 )
        return NO;
    
    NSURL *targetURL = [NSURL URLWithString:URLString];
    SSAppURLType browserType = [self preferredBrowserType];
    SSAppURLType targetType;
    BOOL isHTTPS = [[[targetURL scheme] lowercaseString] isEqualToString:@"https"];
    
    switch( browserType ) {
        case SSAppURLTypeSafariHTTP:
        case SSAppURLTypeSafariHTTPS:
            
            if( isHTTPS )
                targetType = SSAppURLTypeSafariHTTPS;
            else
                targetType = SSAppURLTypeSafariHTTP;
            
            break;
        case SSAppURLTypeChromeHTTP:
        case SSAppURLTypeChromeHTTPS:
            
            if( isHTTPS )
                targetType = SSAppURLTypeChromeHTTPS;
            else
                targetType = SSAppURLTypeChromeHTTP;
            
            break;
        case SSAppURLTypeOperaHTTP:
        case SSAppURLTypeOperaHTTPS:
            
            if( isHTTPS )
                targetType = SSAppURLTypeOperaHTTPS;
            else
                targetType = SSAppURLTypeOperaHTTP;
            
            break;
        case SSAppURLType1PasswordHTTP:
        case SSAppURLType1PasswordHTTPS:
            
            if( isHTTPS )
                targetType = SSAppURLType1PasswordHTTPS;
            else
                targetType = SSAppURLType1PasswordHTTP;
            
            break;
        default:
            NSLog(@"unknown or unavailable browser type.");
            return NO;
    }
    
    return [[UIApplication sharedApplication] openAppType:browserType
                                                withValue:[targetURL absoluteString]];
}

@end
