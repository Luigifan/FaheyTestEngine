//
//  FAppDelegate.m
//  Test Question Designer
//
//  Created by MacBook on 3/22/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FAppDelegate.h"

@implementation FAppDelegate
@synthesize window = _window;
@synthesize editorWindow;
@synthesize closeMenuItem;
@synthesize saveMenuItem;
@synthesize saveAsMenuItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
//    [self toggleEssentialMenuItems:NO];
}
- (IBAction)openMenuClicked:(id)sender 
{
    //This will open the open file dialog and allow the user to select a test question that they can open.
    NSOpenPanel* openPane = [[NSOpenPanel alloc] init];
    [openPane setTitle:@"Select mts file to open."];
    [openPane setAllowedFileTypes:[NSArray arrayWithObject:@"mts"]];
    [openPane beginSheetModalForWindow:nil completionHandler:^(NSInteger result) {
        NSLog(@"Done");
        editorWindow = [[FTestEditorWindow alloc] initWithWindowNibNameAndFilePath:@"FTestEditorWindow" : openPane.URL.path];
        [editorWindow showWindow:nil];
        [self toggleEssentialMenuItems:YES];
    }];
}

- (void)toggleEssentialMenuItems:(BOOL)toggle
{
    [saveMenuItem setEnabled:toggle];
    [closeMenuItem setEnabled:toggle];
    [saveMenuItem setEnabled:toggle];
}

- (IBAction)closeMenuItemClicked:(id)sender 
{
    if(editorWindow != nil)
    {
        [editorWindow close];
        [self toggleEssentialMenuItems:NO];
    }
}
- (IBAction)saveMenuItemClicked:(id)sender 
{
    //TODO:
}
- (IBAction)saveAsMenuItemClicked:(id)sender 
{
    //TODO:
}

@end
