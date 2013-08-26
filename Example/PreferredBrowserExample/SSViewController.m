//
//  SSViewController.m
//  PreferredBrowserExample
//
//  Created by Jonathan Hersh on 8/25/13.
//  Copyright (c) 2013 Splinesoft. All rights reserved.
//

#import "SSViewController.h"
#import <SSDataSources.h>
#import <SSPreferredBrowser.h>

@interface SSViewController ()

@end

@implementation SSViewController {
    NSDictionary *availableBrowsers;
    NSArray *orderedBrowserTypes;
}

- (id)init {
    if( ( self = [self initWithStyle:UITableViewStyleGrouped]) ) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    availableBrowsers = [SSPreferredBrowser availableBrowserDictionary];
    orderedBrowserTypes = [[availableBrowsers allKeys] sortedArrayUsingSelector:@selector(compare:)];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return SSBrowserNumSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch( section ) {
        case SSBrowserSectionBrowsers:
            return [availableBrowsers count];
        case SSBrowserSectionOpenInApp:
            return 1;
        default:
            return 0;
    }
    
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch( section ) {
        case SSBrowserSectionBrowsers:
            return @"Preferred Browser";
        default:
            return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SSBaseTableCell *cell = [SSBaseTableCell cellForTableView:tableView];
    NSString *label;
    BOOL isChecked = NO;
    
    switch( indexPath.section ) {
        case SSBrowserSectionBrowsers: {
            SSAppURLType browserType = [orderedBrowserTypes[indexPath.row] unsignedIntegerValue];
            label = availableBrowsers[@(browserType)];            
            isChecked = [SSPreferredBrowser preferredBrowserType] == browserType;            
            break;
        }
        case SSBrowserSectionOpenInApp:
            label = @"Open Links In-App";
            isChecked = ![SSPreferredBrowser shouldOpenURLsExternally];
            break;
        default:
            break;
    }
    
    cell.textLabel.text = label;
    
    cell.accessoryType = ( isChecked
                           ? UITableViewCellAccessoryCheckmark
                           : UITableViewCellAccessoryNone );
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    switch( indexPath.section ) {
        case SSBrowserSectionOpenInApp:
            [SSPreferredBrowser setShouldOpenURLsExternally:
             ![SSPreferredBrowser shouldOpenURLsExternally]];
            break;
        case SSBrowserSectionBrowsers: {
            SSAppURLType browserType = [orderedBrowserTypes[indexPath.row] unsignedIntegerValue];
            
            if( browserType == [SSPreferredBrowser preferredBrowserType] ) {
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                return;
            }
            
            [SSPreferredBrowser setPreferredBrowserType:browserType];
            break;
        }
        default:
            break;
    }
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section]
             withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
