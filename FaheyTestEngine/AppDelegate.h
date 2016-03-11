//
//  AppDelegate.h
//  FaheyTestEngine
//
//  Created by MacBook on 2/26/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>	
#import "TableViewController.h"
#import "TestQuestionsParser.h"
#import "SettingsStorage.h"

@class TestWindowControllerWindowController;

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDelegate>{
    TestWindowControllerWindowController *testWindowController;
}

- (void) readTestIntoLabel: (TestQuestionsParser*)parser;
- (void) loadSettingsFromDisk;
- (void) postLoadInit;
- (void) writeSettingsToDisk;
- (void) parserOkaySoPutTestIntoArray: (TestQuestionsParser*)parser: (NSString*) path;
- (void) tableDoubleClickAction: (id)nib;
- (NSString*) getSettingsLocationPath;
@property (assign) IBOutlet NSWindow *window;
@property (weak) IBOutlet NSTableView *availableTestsTable;
@property (weak) IBOutlet NSTextField *MainLabel;

#pragma mark - Custom Things
@property TableViewController* mainTableViewController;
@property NSUserDefaults *userDefaults;
//settings
@property NSMutableArray* defaultsAvailableTestsColumn1;
@property NSMutableArray* defaultsAvailableTestsColumn2;
@property NSString* lastSelectedTest;
//

@end
