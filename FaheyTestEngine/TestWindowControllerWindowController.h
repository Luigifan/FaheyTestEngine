//
//  TestWindowControllerWindowController.h
//  FaheyTestEngine
//
//  Created by MacBook on 3/8/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class TestQuestionsParser;
@class MultipleChoiceViewController; //declare a single, reusable multiple choice question view for use
@class FQuestion;
@interface TestWindowControllerWindowController : NSWindowController <NSWindowDelegate>{
    NSString* testPath;
    TestQuestionsParser* testQuestionParser;
    MultipleChoiceViewController* multipleChoiceQuestionViewDelegate;
    int currentQuestionIndex;
}

- (void) generateTestOrder;

- (void) goToNextQuestion;
- (void) goToPreviousQuestion;
- (void) putQuestionInWindow;
- (void) removeCurrentQuestionView;

//stores the indexes we've done already so we don't accidentally pick them
@property NSMutableArray* testOrder;

@property (weak) IBOutlet NSSegmentedCell *segmentedCellToolbarItem;
@property (weak) IBOutlet NSToolbarItem *endToolbarItem;
@property (weak) IBOutlet NSToolbarItem *nextToolbarItem;
@property (weak) IBOutlet NSToolbarItem *resetToolbarItem;
@property (weak) IBOutlet NSToolbarItem *previousToolbarItem;
- (id) initWithWindowNibNameAndTestPath: (NSString*)windowName: (NSString*)path;
@end
