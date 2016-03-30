//
//  FAppDelegate.h
//  Test Question Designer
//
//  Created by MacBook on 3/22/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FTestEditorWindow.h"

@interface FAppDelegate : NSObject <NSApplicationDelegate>

- (void) toggleEssentialMenuItems: (BOOL) toggle;

@property (assign) IBOutlet NSWindow *window;
@property FTestEditorWindow* editorWindow;
@property (weak) IBOutlet NSMenuItem *closeMenuItem;
@property (weak) IBOutlet NSMenuItem *saveMenuItem;
@property (weak) IBOutlet NSMenuItem *saveAsMenuItem;

@end
