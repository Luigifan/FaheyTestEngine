//
//  FTestEditorWindow.h
//  Test Question Designer
//
//  Created by MacBook on 3/22/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "TestQuestionsParser.h"
#import "FTestQuestionTableViewController.h"

@interface FTestEditorWindow : NSWindowController {
    NSString* testFilePath;
    TestQuestionsParser* questionsParser;
}

- (id) initWithWindowNibNameAndFilePath:(NSString*)nibName: (NSString*)filePath;
- (BOOL) saveTestQuestions;
- (void) addQuestionsIntoDataSource;

@property (weak) IBOutlet NSTableView *testQuestionTableView;
@property TableViewController* mainViewController;

//@property (strong) IBOutlet FTestQuestionTableViewController *testQuestionTableViewDataSource;

@end
